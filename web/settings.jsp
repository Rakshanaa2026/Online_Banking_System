<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    HttpSession sessionUser = request.getSession(false);
    String successMessage = (sessionUser != null) ? (String) sessionUser.getAttribute("successMessage") : null;
    String errorMessage = (sessionUser != null) ? (String) sessionUser.getAttribute("errorMessage") : null;

    if (successMessage != null) {
        sessionUser.removeAttribute("successMessage"); // Clear message after displaying
%>
    <script>
        setTimeout(function() {
            window.location.href = "logout.jsp";
        }, 3000); // Redirect to logout after 3 seconds
    </script>
<%
    }
    if (errorMessage != null) {
        sessionUser.removeAttribute("errorMessage"); // Clear error message
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Settings</title>
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
            background-color: #0056b3;
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
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">Online Banking</div>
        <div class="icons">
            <a href="home.jsp">🏠 Home</a>
            <a href="view_balance.jsp">💰 View Balance</a>
            <a href="logout.jsp">🚪 Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Update Password</h2>

        <% if (successMessage != null) { %>
            <div class="message success"><%= successMessage %></div>
        <% } else if (errorMessage != null) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } %>

        <form action="UpdatePasswordServlet" method="post">
            <div class="input-group">
                <label>Current Password</label>
                <input type="password" name="current_password" required>
            </div>
            <div class="input-group">
                <label>New Password</label>
                <input type="password" name="new_password" required>
            </div>
            <div class="input-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirm_password" required>
            </div>
            <button type="submit" class="btn">Update Password</button>
        </form>
    </div>
</body>
</html>
