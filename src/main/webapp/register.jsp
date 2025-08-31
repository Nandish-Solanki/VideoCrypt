<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - VideoCrypt</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" crossorigin="anonymous" />
    <style>
        /* Global box-sizing for consistency */
        *, *::before, *::after {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0c0a1f;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
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
            text-align: left;
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 30px;
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
            padding-right: 40px; /* space for eye icon */
        }

        .eye-icon {
            position: absolute;
            right: 16px;
            color: #aaa;
            cursor: pointer;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Create an account</h1>

    <%-- Server-side feedback messages --%>
    <%
        String error = request.getParameter("error");
        if (error != null) {
            if ("exists".equals(error)) {
    %>
        <div id="msg" class="message">Username already exists!</div>
    <% } else if ("empty".equals(error)) { %>
        <div id="msg" class="message">Please fill out all fields.</div>
    <% } else if ("failed".equals(error)) { %>
        <div id="msg" class="message">Registration failed, try again.</div>
    <% } %>
    <% } %>

    <form action="RegisterServlet" method="post" autocomplete="off">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" name="username" id="username" placeholder="Enter your username" required>
        </div>

        <div class="form-group">
            <label for="regPass">Password</label>
            <div class="input-wrapper">
                <input type="password" name="password" id="regPass" placeholder="Create a password" required>
                <i class="fa fa-eye eye-icon" id="toggleRegPass" onclick="togglePassword()"></i>
            </div>
        </div>

        <input type="submit" value="Register">
    </form>

    <p class="center-text">Already have an account? <a href="login.jsp">Login here</a></p>
</div>

<script>
    function togglePassword() {
        const input = document.getElementById("regPass");
        const icon = document.getElementById("toggleRegPass");
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

    window.addEventListener("DOMContentLoaded", () => {
        const msg = document.getElementById("msg");
        if (msg) {
            setTimeout(() => {
                msg.style.display = "none";
                const url = new URL(window.location.href);
                url.searchParams.delete("error");
                window.history.replaceState({}, document.title, url.pathname);
            }, 3000);
        }
    });
</script>
</body>
</html>
