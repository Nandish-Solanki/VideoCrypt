package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import com.videocrypt.util.DBConnection;

public class DeleteVideoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String videoId = request.getParameter("id");
        System.out.println("Video ID to delete: " + videoId);

        if (videoId == null || videoId.trim().isEmpty()) {
            response.getWriter().println("Invalid video ID.");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            // 1. Get file path
            PreparedStatement pstSelect = con.prepareStatement("SELECT file_path FROM videos WHERE id = ?");
            pstSelect.setString(1, videoId);
            ResultSet rs = pstSelect.executeQuery();
            String filePath = null;
            if (rs.next()) {
                filePath = rs.getString("file_path");
                System.out.println("File path: " + filePath);
            } else {
                response.getWriter().println("Video not found.");
                return;
            }

            // 2. Delete video row
            PreparedStatement pstDelete = con.prepareStatement("DELETE FROM videos WHERE id = ?");
            pstDelete.setString(1, videoId);
            int rowsDeleted = pstDelete.executeUpdate();
            System.out.println("Rows deleted: " + rowsDeleted);

            // 3. Delete file if DB delete was successful
            if (rowsDeleted > 0 && filePath != null) {
                File file = new File(filePath);
                System.out.println("Deleting file: " + file.getAbsolutePath());
                if (file.exists()) {
                    boolean deleted = file.delete();
                    System.out.println("File deleted: " + deleted);
                }
            }

            response.sendRedirect("AdminDashboardServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting video: " + e.getMessage());
        }
    }

    // ✅ Support GET requests too if you want to use links instead of forms
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
