<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.*, com.videocrypt.model.Video" %>
<%

    if (session == null || session.getAttribute("role") == null || !"client".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String profilePic = (String) session.getAttribute("profilePic");

    List<Video> videos = (List<Video>) request.getAttribute("videos");
    String searchParam = request.getParameter("search") != null ? request.getParameter("search") : "";
    String categoryParam = request.getParameter("category") != null ? request.getParameter("category") : "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Client Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(180deg, #0f0f20 0%, #1c1128 100%);
            color: #f3f3f3;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background-color: #0a091a;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar .logo span {
            color: #c084fc;
            font-size: 1.5em;
            font-weight: bold;
        }
        .user-menu {
            position: relative;
        }
        .profile-icon {
            cursor: pointer;
        }
        .profile-icon img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        .profile-icon i {
            font-size: 34px;
            color: #c084fc;
        }
        .dropdown {
            position: absolute;
            right: 0;
            top: 50px;
            background-color: #1e1a33;
            border: 1px solid #333;
            border-radius: 8px;
            overflow: hidden;
            min-width: 160px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
            z-index: 1001;
            display: none;
        }
        .dropdown a {
            display: block;
            padding: 12px 16px;
            color: #f3f3f3;
            text-decoration: none;
            border-bottom: 1px solid #333;
        }
        .dropdown a:hover {
            background-color: #2a273f;
        }
        .container {
            padding: 60px 20px;
            max-width: 1200px;
            margin: auto;
        }
        .container h2 {
            font-size: 32px;
            text-align: center;
            margin-bottom: 40px;
        }
        .search-panel {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            background-color: #1e1a33;
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 40px;
        }
        .search-panel input, .search-panel select, .search-panel button {
            padding: 12px;
            border-radius: 8px;
            font-size: 1em;
        }
        .search-panel input, .search-panel select {
            flex: 1;
            background-color: #2a273f;
            color: #fff;
            border: 1px solid #444;
        }
        .search-panel button {
            background: linear-gradient(90deg, #c084fc, #f472b6);
            border: none;
            color: white;
            cursor: pointer;
        }
        .search-panel button:hover {
            background: linear-gradient(90deg, #a855f7, #ec4899);
        }
        .videos {
    display: flex; /* Changed from grid */
    flex-wrap: wrap;
    gap: 25px;
    justify-content: flex-start; /* Align items to the left */
}
        .video-card {
    background-color: #1c1a35;
    padding: 20px;
    border-radius: 16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
    max-width: 350px;
    width: 100%;
    /* remove margin: auto */
}

        .video-card h3 {
            color: #a78bfa;
            margin-top: 10px;
        }
        .custom-video-wrapper {
            position: relative;
            overflow: hidden;
            border-radius: 12px;
        }
        .custom-video-wrapper video {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 12px;
            display: block;
            background-color: #000;
        }
        .no-videos {
            text-align: center;
            margin-top: 50px;
            font-size: 1.2rem;
            color: #ccc;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo">
        <svg width="32" height="32" viewBox="0 0 1600 1600" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M1250.12 576.498c-.11 89.997-36 176.267-99.79 239.83l-.01-.007-226.282 225.489c-7.841 7.82-20.58 7.84-27.927-.44-55.015-61.995-85.587-142.175-85.49-225.478.106-89.997 36-176.267 99.787-239.83l.007.007 206.745-206.014c18.63-18.569 49.12-18.702 64.92 2.324 43.99 58.525 68.12 130.089 68.04 204.119zM440.552 817.702c-63.787-63.563-99.682-149.833-99.787-239.83-.087-74.03 24.048-145.594 68.035-204.119 15.803-21.026 46.294-20.893 64.928-2.324l206.741 206.016.006-.007c63.787 63.564 99.681 149.833 99.787 239.831.097 83.302-30.475 163.483-85.49 225.471-7.347 8.28-20.086 8.26-27.927.45L440.558 817.696l-.006.006zM1141.82 1221.19c-16.63 20.39-47.04 20.21-65.63 1.59l-127.698-127.84c-7.836-7.85-7.821-20.56.033-28.39l212.095-211.345c7.84-7.813 20.62-7.859 27.54.784 36.81 45.996 51.29 109.566 40.34 179.551-10.01 64.06-40.65 129.19-86.68 185.65zM514.696 1224.16c-18.594 18.61-49.002 18.79-65.626-1.6-46.036-56.46-76.672-121.58-86.687-185.64-10.943-69.992 3.531-133.562 40.342-179.558 6.916-8.642 19.703-8.597 27.544-.784l212.092 211.352c7.854 7.82 7.868 20.54.033 28.38l-127.698 127.85z" fill="#fff"/>
        </svg>
        <span>VideoCrypt</span>
    </div>
    <div class="user-menu">
        <div class="profile-icon" onclick="toggleDropdown()">
            <% if (profilePic != null) { %>
                <img src="<%= profilePic %>" alt="Profile">
            <% } else { %>
                <i class="fas fa-user-circle"></i>
            <% } %>
        </div>
        <div class="dropdown" id="profileDropdown">
            <a href="editProfile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
            <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <h2>Welcome, <%= username %> (Client)</h2>

    <form class="search-panel" method="get" action="ClientDashboardServlet">
        <input type="text" name="search" placeholder="Search for videos..." value="<%= searchParam %>">
        <select name="category">
            <option value="" <%= categoryParam.equals("") ? "selected" : "" %>>All</option>
            <option value="Action" <%= categoryParam.equals("Action") ? "selected" : "" %>>Action</option>
            <option value="Drama" <%= categoryParam.equals("Drama") ? "selected" : "" %>>Drama</option>
            <option value="Comedy" <%= categoryParam.equals("Comedy") ? "selected" : "" %>>Comedy</option>
            <option value="Documentary" <%= categoryParam.equals("Documentary") ? "selected" : "" %>>Documentary</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <% if (videos != null && !videos.isEmpty()) { %>
    <div class="videos">
        <% for (Video v : videos) { %>
        <div class="video-card">
            <h3><%= v.getTitle() %></h3>
            <p>Category: <%= v.getCategory() %></p>
            <p><%= v.getDescription() %></p>
            <% if (v.getFilePath() != null && !v.getFilePath().isEmpty()) { %>
            <div class="custom-video-wrapper">
                <video poster="<%=v.getThumbnailPath()%>" preload="metadata" controls controlsList="nodownload" oncontextmenu="return false;">
                    <source src="<%=v.getFilePath()%>" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } else { %>
        <div class="no-videos">No videos available.</div>
    <% } %>
</div>

<script>
function toggleDropdown() {
    const dropdown = document.getElementById("profileDropdown");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
}
document.addEventListener("click", function(e) {
    const dropdown = document.getElementById("profileDropdown");
    const icon = document.querySelector(".profile-icon");
    if (!icon.contains(e.target) && !dropdown.contains(e.target)) {
        dropdown.style.display = "none";
    }
});
</script>

</body>
</html>
