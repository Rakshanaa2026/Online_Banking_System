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
import java.sql.*;

/**
 *
 * @author raksh
 */

@WebServlet(urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String depositstr = request.getParameter("deposit");
        Double deposit = Double.parseDouble(depositstr);

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

            // Check if user already exists
            String checkUser = "SELECT * FROM users WHERE username=?";
            PreparedStatement checkStmt = connection.prepareStatement(checkUser);
            checkStmt.setString(1, username);
            ResultSet resultSet = checkStmt.executeQuery();
            if (resultSet.next()) {
                response.sendRedirect("register.jsp?error=Username already taken");
                return;
            }

            // Insert new user into database
            String sql = "INSERT INTO users (name, username, password, balance) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, username);
            statement.setString(3, password);
            statement.setDouble(4, deposit);
            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("index.jsp?message=Registration successful! Please log in.");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed");
            }

            // Clean up
            resultSet.close();
            checkStmt.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Error occurred");
        }
    }
}
    