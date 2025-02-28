<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Withdraw Money</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
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
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: 100px auto;
        }
        h2 {
            color: #333;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            display: block;
            font-weight: bold;
        }
        .input-group input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: darkred;
        }
        .message {
            font-weight: bold;
            color: green;
        }
        .error {
            font-weight: bold;
            color: red;
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
        <h2>Withdraw Money</h2>

        <% String successMessage = (String) session.getAttribute("successMessage"); %>
        <% if (successMessage != null) { %>
            <p class="message"><%= successMessage %></p>
            <% session.removeAttribute("successMessage"); %>
        <% } %>

        <% String errorMessage = (String) session.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
            <% session.removeAttribute("errorMessage"); %>
        <% } %>

        <form action="WithdrawServlet" method="post">
            <div class="input-group">
                <label>Enter Amount (₹)</label>
                <input type="number" name="withdraw_amount" required>
            </div>
            <button type="submit" class="btn">Withdraw</button>
        </form>
        <br>
        
    </div>
</body>
</html>