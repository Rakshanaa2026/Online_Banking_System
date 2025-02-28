/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp?error=Please login first");
            return;
        }

        String sender = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");
        double transferAmount = Double.parseDouble(request.getParameter("transfer_amount"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

            // Check sender balance
            String checkSenderQuery = "SELECT balance FROM users WHERE username=?";
            pstmt = conn.prepareStatement(checkSenderQuery);
            pstmt.setString(1, sender);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                session.setAttribute("errorMessage", "Sender account not found!");
                response.sendRedirect("transfer.jsp");
                return;
            }
            double senderBalance = rs.getDouble("balance");

            // Check receiver existence
            String checkReceiverQuery = "SELECT balance FROM users WHERE username=?";
            pstmt = conn.prepareStatement(checkReceiverQuery);
            pstmt.setString(1, receiver);
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                session.setAttribute("errorMessage", "Receiver account not found!");
                response.sendRedirect("transfer.jsp");
                return;
            }
            double receiverBalance = rs.getDouble("balance");

            if (transferAmount > senderBalance) {
                session.setAttribute("errorMessage", "Insufficient funds!");
                response.sendRedirect("transfer.jsp");
                return;
            }

            // Perform transfer (Use transaction handling)
            conn.setAutoCommit(false);

            // Deduct from sender
            String updateSender = "UPDATE users SET balance = balance - ? WHERE username=?";
            pstmt = conn.prepareStatement(updateSender);
            pstmt.setDouble(1, transferAmount);
            pstmt.setString(2, sender);
            pstmt.executeUpdate();

            // Add to receiver
            String updateReceiver = "UPDATE users SET balance = balance + ? WHERE username=?";
            pstmt = conn.prepareStatement(updateReceiver);
            pstmt.setDouble(1, transferAmount);
            pstmt.setString(2, receiver);
            pstmt.executeUpdate();

            // Log transaction
            String logTransaction = "INSERT INTO transaction (transdate, sender, reciever, amount) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(logTransaction);
            pstmt.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
            pstmt.setString(2, sender);
            pstmt.setString(3, receiver);
            pstmt.setDouble(4, transferAmount);
            pstmt.executeUpdate();

            conn.commit();  // Commit transaction

            session.setAttribute("successMessage", "₹" + transferAmount + " transferred to " + receiver + " successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Rollback if error occurs
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            session.setAttribute("errorMessage", "Transaction failed. Please try again.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("transfer.jsp");
    }
}
