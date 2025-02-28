package banking;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp?error=Please login first");
            return;
        }

        String username = (String) session.getAttribute("username");
        String withdrawAmountStr = request.getParameter("withdraw_amount");

        if (withdrawAmountStr == null || withdrawAmountStr.isEmpty()) {
            session.setAttribute("errorMessage", "Invalid withdrawal amount.");
            response.sendRedirect("withdraw.jsp");
            return;
        }

        double withdrawAmount = Double.parseDouble(withdrawAmountStr);

        if (withdrawAmount <= 0) {
            session.setAttribute("errorMessage", "Withdrawal amount must be greater than zero.");
            response.sendRedirect("withdraw.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root")) {

                // Fetch current balance
                String selectQuery = "SELECT balance FROM users WHERE username=?";
                try (PreparedStatement selectStmt = conn.prepareStatement(selectQuery)) {
                    selectStmt.setString(1, username);
                    ResultSet rs = selectStmt.executeQuery();

                    double currentBalance = 0;
                    if (rs.next()) {
                        currentBalance = rs.getDouble("balance");
                    } else {
                        session.setAttribute("errorMessage", "User not found.");
                        response.sendRedirect("withdraw.jsp");
                        return;
                    }

                    // Check if sufficient balance is available
                    if (withdrawAmount > currentBalance) {
                        session.setAttribute("errorMessage", "Insufficient balance.");
                        response.sendRedirect("withdraw.jsp");
                        return;
                    }

                    // Update balance
                    double newBalance = currentBalance - withdrawAmount;
                    String updateQuery = "UPDATE users SET balance=? WHERE username=?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setDouble(1, newBalance);
                        updateStmt.setString(2, username);
                        int rowsUpdated = updateStmt.executeUpdate();

                        if (rowsUpdated > 0) {
                            session.setAttribute("successMessage", "Withdrawal successful! New Balance: ₹" + newBalance);
                            response.sendRedirect("withdraw.jsp");
                        } else {
                            session.setAttribute("errorMessage", "Withdrawal failed.");
                            response.sendRedirect("withdraw.jsp");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred.");
            response.sendRedirect("withdraw.jsp");
        }
    }
}