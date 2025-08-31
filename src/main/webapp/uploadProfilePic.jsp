<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
   
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Upload Profile Picture</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    body {
      margin: 0;
      font-family: 'Inter', sans-serif;
      background: #0c0a1f;
      color: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .card {
      background-color: #1c1a35;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 0 12px rgba(0,0,0,0.6);
      width: 100%;
      max-width: 400px;
      text-align: center;
    }
    .card h2 {
      margin-bottom: 25px;
      color: #c084fc;
    }
    input[type="file"] {
      margin-bottom: 20px;
      color: #fff;
    }
    button {
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
  </style>
</head>
<body>
  <div class="card">
    <h2>Upload Profile Picture</h2>
    <form method="post" action="UploadProfilePicServlet" enctype="multipart/form-data">
      <input type="file" name="profilePic" accept="image/*" required>
      <button type="submit">Upload</button>
    </form>
  </div>
</body>
</html>
