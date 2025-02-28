<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IFCI Online Bank </title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .header {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #007b5e;
            color: white;
            margin-bottom: 35px;
        }
        .content {
            display: flex;
            justify-content: space-between;
            padding: 20px;
        }
        .login-box {
            width: 40%;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f8f8f8;
        }
        .secure-section {
            width: 50%;
        }
        input[type="text"], input[type="password"] {
            margin-top: 10px;
            width: 80%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            margin-left: 90px;
            margin-top: 20px;
            background-color: #ff6600;
            color: white;
            padding: 10px;
            border: none;
            width: 40%;
            cursor: pointer;
        }
        .footer {
            text-align: center;
            padding: 10px;
            background: #ddd;
            margin-top: 30px;
        }
        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="header">
        <marquee direction="right" scrollamount="5"><h2 style="padding-left:70px;">Welcome to IFCI Online Banking !!</h2></marquee>
    </div>
    <div class="container">
        <div class="content">
            <div class="login-box">
                <% String errorMessage = request.getParameter("error");
                   if (errorMessage != null) { %>
                    <p class="error"><%= errorMessage %></p>
                <% } %>
                <form action="LoginServlet" method="post">
                    <label for="loginID">Your Login ID:</label><br>
                    <input type="text" id="loginID" name="username" required><br>
                    <label for="password">Password:</label><br>
                    <input type="password" id="password" name="password" required><br>
                    <input type="submit" value="Login"><br>
                </form>
                <p style="margin-left:60px;"><a href="register.jsp">First Time User? Register Now</a></p>
            </div>
            <div class="secure-section">
                <img src="bank_bg.png" width="450px" height="350px">
            </div>
        </div>
    </div>
    <div class="footer">
        <p>&copy; 2025 IFCI Bank Ltd. All rights reserved.</p>
    </div>
</body>
</html>