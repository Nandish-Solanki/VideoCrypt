<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Video - VideoCrypt</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(180deg, #0f0f20 0%, #1c1128 100%);
            color: #f3f3f3;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        form {
            background-color: #1c1a35;
            padding: 40px;
            border-radius: 16px;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 26px;
            background: linear-gradient(90deg, #c084fc, #f472b6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        label {
            display: block;
            margin-top: 18px;
            font-weight: 600;
            color: #ccc;
        }

        input[type="text"],
        input[type="file"],
        select {
            width: 100%;
            padding: 12px;
            background: #2a273f;
            border: 1px solid #3f3a5a;
            border-radius: 8px;
            color: #fff;
            margin-top: 6px;
            font-size: 15px;
        }

        input[type="file"] {
            padding: 10px;
        }

        input[type="submit"] {
            margin-top: 30px;
            width: 100%;
            background: linear-gradient(90deg, #c084fc, #f472b6);
            color: white;
            font-size: 16px;
            padding: 14px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(90deg, #a855f7, #ec4899);
        }

        .back-button {
            margin-top: 20px;
            text-align: center;
        }

        .back-button a {
            color: #a78bfa;
            text-decoration: none;
            font-size: 14px;
        }

        .back-button a:hover {
            color: #f472b6;
        }

        .select-wrapper {
            position: relative;
        }

        .select-wrapper select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
        }

        .select-wrapper::after {
            content: "\f078"; /* Font Awesome chevron-down */
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            top: 50%;
            right: 16px;
            pointer-events: none;
            color: #ccc;
            transform: translateY(-50%);
            font-size: 14px;
        }
    </style>
</head>
<body>

    <form action="UploadVideoServlet" method="post" enctype="multipart/form-data">
    <h2><i class="fas fa-upload" style="margin-right: 10px;"></i>Upload New Video</h2>

    <label for="title">Title</label>
    <input type="text" name="title" id="title" required>

    <label for="description">Description</label>
    <input type="text" name="description" id="description" required>

    <label for="category">Category</label>
    <input type="text" name="category" id="category" required>

    <label for="visibility">Visibility</label>
    <div class="select-wrapper">
        <select name="visibility" id="visibility" required>
            <option value="Public">Public</option>
            <option value="Private">Private</option>
        </select>
    </div>

    <label for="file">Select Video File</label>
    <input type="file" name="file" id="file" accept="video/*" required>

    <label for="thumbnail">Select Thumbnail Image</label>
    <input type="file" name="thumbnail" id="thumbnail" accept="image/*" required>

    <input type="submit" value="Upload Video">

    <div class="back-button">
        <a href="AdminDashboardServlet"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</form>


</body>
</html>
