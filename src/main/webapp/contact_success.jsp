<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Contact Submitted</title>
</head>
<body style="font-family: sans-serif; text-align: center; padding: 50px;">
  <h2>Thank You!</h2>
  <p><%= request.getAttribute("status") %></p>
  <a href="index.jsp">Return to Home</a>
</body>
</html>
