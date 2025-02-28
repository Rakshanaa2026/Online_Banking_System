/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package banking;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
/**
 *
 * @author raksh
 */
@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp?error=Please login first");
            return;
        }

        String username = (String) session.getAttribute("username");
        String depositAmountStr = request.getParameter("deposit_amount");

        if (depositAmountStr == null || depositAmountStr.isEmpty()) {
            session.setAttribute("errorMessage", "Invalid deposit amount.");
            response.sendRedirect("deposit.jsp");
            return;
        }

        double depositAmount = Double.parseDouble(depositAmountStr);

        if (depositAmount <= 0) {
            session.setAttribute("errorMessage", "Deposit amount must be greater than zero.");
            response.sendRedirect("deposit.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

            // Fetch current balance
            String selectQuery = "SELECT balance FROM users WHERE username=?";
            PreparedStatement selectStmt = conn.prepareStatement(selectQuery);
            selectStmt.setString(1, username);
            ResultSet rs = selectStmt.executeQuery();

            double currentBalance = 0;
            if (rs.next()) {
                currentBalance = rs.getDouble("balance");
            } else {
                session.setAttribute("errorMessage", "User not found.");
                response.sendRedirect("deposit.jsp");
                return;
            }

            // Update balance
            double newBalance = currentBalance + depositAmount;
            String updateQuery = "UPDATE users SET balance=? WHERE username=?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setDouble(1, newBalance);
            updateStmt.setString(2, username);
            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("successMessage", "Deposit successful! New Balance: ₹" + newBalance);
                response.sendRedirect("deposit.jsp");
            } else {
                session.setAttribute("errorMessage", "Deposit failed.");
                response.sendRedirect("deposit.jsp");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred.");
            response.sendRedirect("deposit.jsp");
        }
    }
}