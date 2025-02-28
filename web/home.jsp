<%-- 
    Document   : home
    Created on : 26-Feb-2025, 11:34:17 am
    Author     : raksh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Online Banking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #d5f5e3;
        }
        .navbar {
            background-color: #007b5e;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar .logo {
            font-size: 26px;
            font-weight: bold;
        }
        .navbar .icons a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin-left: 20px;
            transition: color 0.3s;
        }
        .navbar .icons a:hover {
            color: #1abc9c;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 50px;
        }
        .card {
            background: white;
            padding: 25px;
            margin: 15px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 230px;
            height: 170px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .card h3 {
            margin-bottom: 15px;
            color: #2c3e50;
        }
        .card a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
            font-size: 16px;
            transition: color 0.3s;
        }
        .card a:hover {
            color: #1abc9c;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo">Online Banking</div>
        <div class="icons">
            <a href="settings.jsp">⚙ Settings</a>
            <a href="logout.jsp">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="card">
            <h2>View Balance</h2>
            <a href="view_balance.jsp">Check Now</a>
        </div>
        <div class="card">
            <h2>Deposit</h2>
            <a href="deposit.jsp">Deposit Funds</a>
        </div>
        <div class="card">
            <h2>Withdraw</h2>
            <a href="withdraw.jsp">Withdraw Money</a>
        </div>
        <div class="card">
            <h2>Transfer</h2>
            <a href="transfer.jsp">Send Money</a>
        </div>
        <div class="card">
            <h2>Close Account</h2>
            <a href="closeAccount.jsp">Close</a>
        </div>
    </div>
</body>
</html>
