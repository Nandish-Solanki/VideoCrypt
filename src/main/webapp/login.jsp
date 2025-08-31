<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sign In - VideoCrypt</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" crossorigin="anonymous" />
  <style>
    *, *::before, *::after {
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #0c0a1f;
      color: #fff;
    }

    body {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .container {
      background-color: #1c1a35;
      padding: 40px;
      border-radius: 16px;
      width: 100%;
      max-width: 400px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    }

    h1 {
      font-size: 28px;
      font-weight: bold;
      margin-bottom: 30px;
      text-align: center;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-size: 14px;
      font-weight: 500;
      color: #ccc;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 12px 14px;
      border: 1px solid #333;
      background-color: #2a2740;
      color: #fff;
      border-radius: 8px;
      font-size: 15px;
    }

    input::placeholder {
      color: #999;
    }

    input[type="submit"] {
      width: 100%;
      padding: 12px;
      margin-top: 10px;
      background-color: #7c3aed;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      transition: background 0.3s;
    }

    input[type="submit"]:hover {
      background-color: #6b21a8;
    }

    .message {
      padding: 10px;
      background-color: #fee2e2;
      color: #b91c1c;
      border-radius: 6px;
      font-size: 14px;
      margin-bottom: 20px;
      text-align: center;
    }

    .center-text {
      text-align: center;
      margin-top: 20px;
      font-size: 14px;
    }

    a {
      color: #a78bfa;
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    .input-wrapper {
      position: relative;
      display: flex;
      align-items: center;
    }

    .input-wrapper input {
      padding-right: 40px;
    }

    .eye-icon {
      position: absolute;
      right: 16px;
      color: #aaa;
      cursor: pointer;
      font-size: 18px;
    }

    .social-login {
      margin-top: 20px;
    }

    .social-login a {
      display: flex;
      align-items: center;
      justify-content: center;
      text-decoration: none;
      padding: 12px;
      background-color: transparent;
      border: 1px solid #fff;
      color: #fff;
      border-radius: 8px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
      width: 100%;
      margin-top: 10px;
    }

    .social-login a:hover {
      background-color: #ffffff22;
      color: #fff;
    }

    .social-login a i {
      margin-right: 8px;
    }

  </style>
</head>
<body>
  <div class="container">
    <h1>Sign in</h1>

    <%-- Server-side feedback messages --%>
    <%
      String error = request.getParameter("error");
      if (error != null) {
          if ("invalid".equals(error)) {
    %>
      <div class="message">Invalid username or password.</div>
    <% } } %>

    <form action="LoginServlet" method="post" autocomplete="off">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" name="username" id="username" placeholder="Enter your username" required>
      </div>

      <div class="form-group">
        <label for="loginPass">Password</label>
        <div class="input-wrapper">
          <input type="password" name="password" id="loginPass" placeholder="Enter your password" required>
          <i class="fa fa-eye eye-icon" id="toggleLoginPass" onclick="togglePassword()"></i>
        </div>
      </div>

      <input type="submit" value="Login">
    </form>

    <!-- Google login button styled -->
    <div class="social-login">
      <a href="https://accounts.google.com/o/oauth2/auth?client_id=345146894059-rvbnje72sfqffilbj9igglg4q0vc7kf0.apps.googleusercontent.com&redirect_uri=http://localhost:9090/VideoCrypt/GoogleCallbackServlet&response_type=code&scope=email%20profile&access_type=offline&prompt=consent">
        <i class="fab fa-google"></i> Continue with Google
      </a>
    </div>

    <p class="center-text">
      Don’t have an account? <a href="register.jsp">Sign up now</a>
    </p>
    <p class="center-text">
      <a href="#">Forgot password?</a>
    </p>
  </div>

  <script>
    function togglePassword() {
      const input = document.getElementById("loginPass");
      const icon = document.getElementById("toggleLoginPass");
      if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
      } else {
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
      }
    }
  </script>
</body>
</html>
