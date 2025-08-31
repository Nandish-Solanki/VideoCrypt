package com.videocrypt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.videocrypt.util.DBConnection;

@WebServlet("/UpdateVisibilityServlet")
public class UpdateVisibilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String videoId = request.getParameter("videoId"); // ✅ Use the name "videoId" for consistency
        String visibility = request.getParameter("visibility");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE videos SET visibility = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, visibility);
            pstmt.setInt(2, Integer.parseInt(videoId));

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Visibility updated successfully for video ID: " + videoId);
            }

            // ✅ Best practice: Redirect to a servlet that reloads fresh data
            response.sendRedirect("VideoListServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp?msg=error");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
