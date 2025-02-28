<%-- 
    Document   : deposit
    Created on : 27-Feb-2025, 1:47:49 pm
    Author     : raksh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser == null || sessionUser.getAttribute("username") == null) {
        response.sendRedirect("index.jsp?error=Please login first");
        return;
    }

    String successMessage = (String) sessionUser.getAttribute("successMessage");
    String errorMessage = (String) sessionUser.getAttribute("errorMessage");

    if (successMessage != null) {
        sessionUser.removeAttribute("successMessage");
    }
    if (errorMessage != null) {
        sessionUser.removeAttribute("errorMessage");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit Money</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
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
        .navbar1 {
            background-color: #007b5e;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }
        .container {
            max-width: 400px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .message {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            background-color: #ff6600;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #218838;
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
        <h2>Deposit Funds</h2>

        <% if (successMessage != null) { %>
            <div class="message success"><%= successMessage %></div>
        <% } else if (errorMessage != null) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>

        <form action="DepositServlet" method="post">
            <div class="input-group">
                <label>Enter Deposit Amount:</label>
                <input type="number" name="deposit_amount" step="0.01" min="1" required>
            </div>
            <button type="submit" class="btn">Deposit</button>
        </form>
    </div>
</body>
</html>

