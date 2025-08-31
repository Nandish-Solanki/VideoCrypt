package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import com.videocrypt.util.DBConnection;
import com.videocrypt.model.Video;

public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        // ✅ Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // ✅ Establish DB connection
            con = DBConnection.getConnection();

            // ✅ Fetch all videos
            String query = "SELECT * FROM videos";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            // ✅ Prepare list to hold video objects
            ArrayList<Video> videoList = new ArrayList<>();

            while (rs.next()) {
                Video v = new Video();
                v.setId(rs.getInt("id"));
                v.setTitle(rs.getString("title"));
                v.setDescription(rs.getString("description"));
                v.setCategory(rs.getString("category"));
                v.setFilePath(rs.getString("file_path"));
                v.setVisibility(rs.getString("visibility"));

                // ✅ Fetch thumbnail path from DB
                String thumbnailPath = rs.getString("thumbnail_path");

                // ✅ If null/empty, fallback to default thumbnail
                if (thumbnailPath == null || thumbnailPath.trim().isEmpty()) {
                    thumbnailPath = "images/default-thumb.jpg";
                }

                v.setThumbnailPath(thumbnailPath);

                videoList.add(v);
            }

            // ✅ Pass video list to JSP
            request.setAttribute("videos", videoList);

            // ✅ Forward to adminDashboard.jsp
            RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // optional friendly error page
        } finally {
            // ✅ Clean up resources
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pst != null) pst.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
