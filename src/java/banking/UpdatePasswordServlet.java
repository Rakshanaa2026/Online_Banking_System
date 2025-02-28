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

@WebServlet("/UpdatePasswordServlet")
public class UpdatePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp?error=Please login first");
            return;
        }

        String username = (String) session.getAttribute("username");
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("errorMessage", "New passwords do not match.");
            response.sendRedirect("settings.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

            // Verify current password
            String checkQuery = "SELECT password FROM users WHERE username=?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (!dbPassword.equals(currentPassword)) {
                    session.setAttribute("errorMessage", "Incorrect current password.");
                    response.sendRedirect("settings.jsp");
                    return;
                }
            } else {
                session.setAttribute("errorMessage", "User not found.");
                response.sendRedirect("settings.jsp");
                return;
            }

            // Update password in the database
            String updateQuery = "UPDATE users SET password=? WHERE username=?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setString(1, newPassword);
            updateStmt.setString(2, username);
            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("successMessage", "Password successfully changed. Logging out...");
                response.sendRedirect("settings.jsp");
            } else {
                session.setAttribute("errorMessage", "Password update failed.");
                response.sendRedirect("settings.jsp");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred.");
            response.sendRedirect("settings.jsp");
        }
    }
}
