<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Balance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: whitesmoke;
        }
        .navbar {
            background-color: #007b5e;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .navbar .icons {
            display: flex;
            gap: 15px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .container {
            margin-top: 50px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
        }
        h2 {
            color: #333;
        }
        .balance {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">Online Banking</div>
        <div class="icons">
            <a href="home.jsp">🏠 Home</a>
            <a href="settings.jsp">⚙ Settings</a>
            <a href="logout.jsp">🚪 Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Your Account Balance</h2>

        <%
            HttpSession sessionUser = request.getSession(false);
            if (sessionUser == null || sessionUser.getAttribute("username") == null) {
                response.sendRedirect("index.jsp?error=Please login first");
                return;
            }
            String username = (String) sessionUser.getAttribute("username");

            // Database connection
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking", "root", "root");

                String sql = "SELECT balance FROM users WHERE username=?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    double balance = resultSet.getDouble("balance");
        %>
                    <p class="balance">₹<%= balance %></p>
        <%
                } else {
                    out.println("<p class='error'>Error fetching balance.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error'>Database error.</p>");
            } finally {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>
    </div>
</body>
</html>