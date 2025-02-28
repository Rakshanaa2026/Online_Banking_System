<%-- 
    Document   : logout
    Created on : 27-Feb-2025, 11:59:17 am
    Author     : raksh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession sessionUser = request.getSession(false);
    if (sessionUser != null) {
        sessionUser.invalidate(); // Destroy session
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logging Out...</title>
    <script>
        setTimeout(function() {
            window.location.href = "index.jsp?message=Logged out successfully";
        }, 2000);
    </script>
</head>
<body>
    <div style="text-align: center; margin-top: 100px;">
        <h2>You have been logged out.</h2>
        <p>Redirecting to login page...</p>
    </div>
</body>
</html>

