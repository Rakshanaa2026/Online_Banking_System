<%-- 
    Document   : register
    Created on : 26-Feb-2025, 11:45:36 am
    Author     : raksh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Online Banking System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('bg2.png') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            margin-top: 10px;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            margin: 100px auto;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
            text-align: left;
        }

        input[type="text"],
        input[type="password"],
        input[type="number"]{
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background: #ff6600;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: 0.3s;
        }

        input[type="submit"]:hover {
            background: linear-gradient(90deg, #ff4b2b, #ff416c);
        }

        p {
            margin-top: 15px;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create a New Account</h2>
        <% String errorMessage = request.getParameter("error");
           if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>
        <form action="RegisterServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="username">EmailId (UserName):</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirm_password">Confirm Password:</label>
            <input type="password" id="confirm_password" name="confirm_password" required>
            
            <label for="deposit">Initial Deposit:</label>
            <input type="number" id="deposit" name="deposit" step="0.01" required>

            <input type="submit" value="Register">
        </form>
        <p>Already have an account? <a href="index.jsp">Login here</a></p>
    </div>
</body>
</html>

