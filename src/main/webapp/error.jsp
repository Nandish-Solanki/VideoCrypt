<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { 
            background: #0a0a23; 
            color: #fff; 
            font-family: sans-serif; 
            text-align: center; 
            padding: 50px; 
        }
        a {
            color: #c084fc;
            text-decoration: none;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <h1>⚠️ Oops — something went wrong!</h1>
    <p>${exception}</p>
    <a href="AdminDashboardServlet">Back to Dashboard</a>
</body>
</html>
