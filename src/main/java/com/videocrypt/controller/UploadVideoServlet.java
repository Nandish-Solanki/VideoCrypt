package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import com.videocrypt.util.DBConnection;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
    maxFileSize = 1024 * 1024 * 500,       // 500MB
    maxRequestSize = 1024 * 1024 * 600     // 600MB
)
public class UploadVideoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String thumbPath = uploadPath + File.separator + "thumbnails";
        File thumbDir = new File(thumbPath);
        if (!thumbDir.exists()) thumbDir.mkdir();

        try {
            String title = request.getParameter("title");
            String desc = request.getParameter("description");
            String category = request.getParameter("category");
            String visibility = request.getParameter("visibility");
            if (visibility == null || visibility.trim().isEmpty()) {
                visibility = "Private";
            }

            // Get uploaded video
            Part videoPart = request.getPart("file");
            if (videoPart == null || videoPart.getSize() == 0) {
                response.getWriter().println("No video file uploaded.");
                return;
            }
            String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
            String videoFilePath = uploadPath + File.separator + videoFileName;
            videoPart.write(videoFilePath);

            // Get uploaded thumbnail
            Part thumbnailPart = request.getPart("thumbnail");
            String thumbnailFileName = "";
            String thumbnailFilePath = "";
            if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
                thumbnailFileName = Paths.get(thumbnailPart.getSubmittedFileName()).getFileName().toString();
                thumbnailFilePath = thumbPath + File.separator + thumbnailFileName;
                thumbnailPart.write(thumbnailFilePath);
            } else {
                // Optionally assign a default thumbnail
                thumbnailFileName = "default-thumb.jpg";
            }

            HttpSession session = request.getSession(false);
            int uploadedBy = 1; // fallback to admin
            if (session != null && session.getAttribute("userId") != null) {
                uploadedBy = (Integer) session.getAttribute("userId");
            }

            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO videos (title, description, category, file_path, thumbnail_path, visibility, uploaded_by) VALUES (?, ?, ?, ?, ?, ?, ?)"
            );
            pst.setString(1, title);
            pst.setString(2, desc);
            pst.setString(3, category);
            pst.setString(4, "uploads/" + videoFileName);
            pst.setString(5, "uploads/thumbnails/" + thumbnailFileName);
            pst.setString(6, visibility);
            pst.setInt(7, uploadedBy);

            pst.executeUpdate();

            response.sendRedirect("AdminDashboardServlet?msg=uploaded");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Upload Error: " + e.getMessage());
        }
    }
}
