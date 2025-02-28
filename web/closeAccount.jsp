<%-- 
    Document   : closeAccount
    Created on : 27-Feb-2025, 2:48:31 pm
    Author     : raksh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Close Account</title>
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
        .container {
            max-width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 50px auto;
        }
        h2 {
            color: #333;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            font-weight: bold;
            display: block;
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
            background-color: #c82333;
        }
        .home-btn {
            background-color: #007bff;
            margin-top: 10px;
        }
        .home-btn:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 10px;
            font-size: 14px;
        }
        .success {
            color: green;
        }
        .error {
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
        <h2>Close Account</h2>

        <!-- Display success or error messages -->
        <% 
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (successMessage != null) { %>
                <p class="message success"><%= successMessage %></p>
                <% session.removeAttribute("successMessage"); 
            } else if (errorMessage != null) { %>
                <p class="message error"><%= errorMessage %></p>
                <% session.removeAttribute("errorMessage"); 
            }
        %>

        <form action="CloseAccountServlet" method="post">
            <div class="input-group">
                <label>Enter Password:</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn">Close Account</button>
        </form>

        <!-- Home Button -->
        
    </div>

</body>
</html>
