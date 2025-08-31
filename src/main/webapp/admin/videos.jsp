<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.videocrypt.model.Video" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Videos - VideoCrypt</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="container">
    <h1>All Uploaded Videos</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Category</th>
                <th>Video</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Video> videos = (List<Video>) request.getAttribute("videos");
            if (videos != null && !videos.isEmpty()) {
                for (Video video : videos) {
        %>
            <tr>
                <td><%= video.getId() %></td>
                <td><%= video.getTitle() %></td>
                <td><%= video.getDescription() %></td>
                <td><%= video.getCategory() %></td>
                <td>
                    <video width="250" controls>
                        <source src="<%= video.getFilePath() %>" type="video/mp4">
                        Your browser does not support the video tag.
                    </video>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" style="text-align:center;">No videos available.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <br>
    <a href="adminDashboard.jsp"><button>Back to Dashboard</button></a>
</div>

</body>
</html>
