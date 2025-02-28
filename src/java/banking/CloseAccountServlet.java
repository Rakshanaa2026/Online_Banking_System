/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package banking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp?error=Please login first");
            return;
        }

        String username = (String) session.getAttribute("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

            // Verify user password
            String checkPasswordQuery = "SELECT password FROM users WHERE username=?";
            pstmt = conn.prepareStatement(checkPasswordQuery);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                session.setAttribute("errorMessage", "User not found!");
                response.sendRedirect("closeAccount.jsp");
                return;
            }

            String correctPassword = rs.getString("password");
            if (!correctPassword.equals(password)) {
                session.setAttribute("errorMessage", "Incorrect password!");
                response.sendRedirect("closeAccount.jsp");
                return;
            }

            // Begin transaction
            conn.setAutoCommit(false);

            // Delete user's transactions
            String deleteTransactions = "DELETE FROM transaction WHERE sender=? OR reciever=?";
            pstmt = conn.prepareStatement(deleteTransactions);
            pstmt.setString(1, username);
            pstmt.setString(2, username);
            pstmt.executeUpdate();

            // Delete user account
            String deleteUser = "DELETE FROM users WHERE username=?";
            pstmt = conn.prepareStatement(deleteUser);
            pstmt.setString(1, username);
            pstmt.executeUpdate();

            conn.commit(); // Commit transaction

            // Invalidate session and redirect to login page
            session.invalidate();
            response.sendRedirect("index.jsp?success=Account closed successfully");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Rollback if error occurs
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            session.setAttribute("errorMessage", "Account closure failed. Please try again.");
            response.sendRedirect("closeAccount.jsp");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
