<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.videocrypt.model.Video" %>
<%
    List<Video> videoList = (List<Video>) request.getAttribute("videos");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - VideoCrypt</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(180deg, #0f0f20 0%, #1c1128 100%);
            color: #f3f3f3;
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 260px;
            background-color: #0a091a;
            display: flex;
            flex-direction: column;
            padding: 30px 20px;
            box-shadow: 2px 0 10px rgba(0,0,0,0.3);
        }
        .sidebar h1 {
            font-size: 24px;
            background: linear-gradient(90deg, #c084fc, #f472b6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 30px;
        }
        .sidebar a {
            text-decoration: none;
            color: white;
            background: linear-gradient(90deg, #c084fc, #f472b6);
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 16px;
            text-align: center;
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background: linear-gradient(90deg, #a855f7, #ec4899);
        }
        .main-content {
            flex: 1;
            padding: 40px 60px;
            overflow-y: auto;
        }
        h2 {
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #a78bfa;
            padding-bottom: 10px;
        }
.video-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
    justify-content: flex-start;
}       .card {
    background-color: #1c1a35;
    padding: 20px;
    border-radius: 16px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
    max-width: 350px;
    width: 100%;
   margin: 0; /* ✅ This lets the flex container handle alignment */

    transition: transform 0.3s;
}
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 20px rgba(124, 58, 237, 0.3);
        }
        .card h3 {
            color: #a78bfa;
            margin-top: 0;
        }
        .card p {
            margin: 6px 0;
            font-size: 14px;
            color: #ccc;
        }
        .empty-message {
            font-size: 18px;
            margin-top: 20px;
            color: #ccc;
        }
        .delete-button {
            background: linear-gradient(90deg, #f472b6, #c084fc);
            color: white;
            padding: 8px 14px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            margin-top: 10px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .delete-button:hover {
            background: linear-gradient(90deg, #ec4899, #a855f7);
        }
        .visibility-select {
            appearance: none;
            background: #2a273f;
            border: 1px solid #3f3a5a;
            border-radius: 8px;
            color: #fff;
            padding: 6px 30px 6px 12px;
            font-size: 14px;
            cursor: pointer;
            position: relative;
        }
        label.visibility-label {
            position: relative;
            display: inline-block;
            font-size: 14px;
        }
        label.visibility-label i.fa-chevron-down {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            color: #c084fc;
            font-size: 12px;
        }
        .thumbnail {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    margin-bottom: 10px;
}

video {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    margin-top: 8px;
}
        #toast {
            visibility: hidden;
            min-width: 250px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 8px;
            padding: 16px;
            position: fixed;
            z-index: 1000;
            top: 20px;
            right: 20px;
            font-size: 17px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
        }
        #toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }
        @keyframes fadein { from { top: 0; opacity: 0; } to { top: 20px; opacity: 1; } }
        @keyframes fadeout { from { top: 20px; opacity: 1; } to { top: 0; opacity: 0; } }
    </style>
</head>
<body>

<div class="sidebar">
    <h1>VideoCrypt Admin</h1>
    <a href="uploadVideo.jsp"><i class="fas fa-upload"></i> Upload Video</a>
    <a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
</div>

<div class="main-content">
    <h2>Uploaded Videos</h2>

    <% if (videoList == null || videoList.isEmpty()) { %>
        <p class="empty-message">🚫 No videos uploaded yet.</p>
    <% } else { %>
        <div class="video-grid">
            <% for (Video v : videoList) { %>
                <div class="card">
                    <h3><%= v.getTitle() %></h3>
                    <p><strong>Category:</strong> <%= v.getCategory() %></p>
                    <p><strong>Description:</strong> <%= v.getDescription() %></p>

                   
                    <%-- Video player --%>
                    <video controls poster="<%= v.getThumbnailPath() != null ? v.getThumbnailPath() : "images/default-thumb.jpg" %>">
                        <source src="<%= v.getFilePath() %>" type="video/mp4">
                        Your browser does not support the video tag.
                    </video>

                    <%-- Visibility dropdown --%>
                    <form action="UpdateVisibilityServlet" method="post" style="margin-top: 10px;">
                        <input type="hidden" name="videoId" value="<%= v.getId() %>">
                        <label class="visibility-label">
                            Visibility:
                            <select name="visibility" onchange="this.form.submit()" class="visibility-select">
                                <option value="Public" <%= "Public".equalsIgnoreCase(v.getVisibility()) ? "selected" : "" %>>Public</option>
                                <option value="Private" <%= "Private".equalsIgnoreCase(v.getVisibility()) ? "selected" : "" %>>Private</option>
                            </select>
                            <i class="fas fa-chevron-down"></i>
                        </label>
                    </form>

                    <%-- Delete button --%>
                    <form action="DeleteVideoServlet" method="post" style="margin-top: 10px;">
                        <input type="hidden" name="id" value="<%= v.getId() %>">
                        <button type="submit" class="delete-button">🗑️ Delete</button>
                    </form>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<div id="toast"></div>

<script>
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        var toast = document.getElementById("toast");

        if (urlParams.has('msg')) {
            if (urlParams.get('msg') === 'uploaded') {
                toast.innerHTML = "✅ Video Uploaded!";
            } else if (urlParams.get('msg') === 'visibilityUpdated') {
                toast.innerHTML = "👁️ Visibility Updated!";
            } else if (urlParams.get('msg') === 'deleted') {
                toast.innerHTML = "🗑️ Video Deleted!";
            }
            toast.className = "show";
            setTimeout(() => { toast.className = toast.className.replace("show", ""); }, 3000);
        }
    }
</script>

</body>
</html>
