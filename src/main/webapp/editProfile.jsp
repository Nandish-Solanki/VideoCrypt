<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
    String profilePic = (String) session.getAttribute("profilePic");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #0c0a1f;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            background: #1e1a33;
            padding: 30px;
            border-radius: 12px;
            width: 400px;
            box-shadow: 0 0 12px rgba(0,0,0,0.5);
            text-align: center;
        }
        .card h2 {
            color: #c084fc;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-top: 20px;
            text-align: left;
        }
        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            background: #2a273f;
            color: #fff;
            border: 1px solid #444;
            border-radius: 8px;
        }
        .current-pic img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-top: 10px;
            object-fit: cover;
        }
        button {
            margin-top: 25px;
            background: linear-gradient(90deg, #c084fc, #f472b6);
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            width: 100%;
            font-size: 1em;
            cursor: pointer;
        }
        button:hover {
            background: linear-gradient(90deg, #a855f7, #ec4899);
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #c084fc;
            text-decoration: none;
            font-size: 1em;
        }
        .back-link:hover {
            color: #f472b6;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Edit Profile</h2>
    <form method="post" action="UploadProfilePicServlet" enctype="multipart/form-data">
        <label>Username</label>
        <input type="text" value="<%= username %>" disabled>

        <label>Profile Picture</label>
        <div class="current-pic">
            <% if (profilePic != null) { %>
                <img src="<%= profilePic %>" alt="Profile Pic">
            <% } else { %>
                <img src="images/default-avatar.png" alt="Default Pic">
            <% } %>
        </div>
        <input type="file" name="profilePic" accept="image/*" required>

        <button type="submit">Upload Picture</button>
    </form>

    <!-- ✅ Back to Dashboard link -->
    <a href="ClientDashboardServlet" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

</body>
</html>
