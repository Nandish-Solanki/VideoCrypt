package com.videocrypt.controller;

import java.io.IOException;
import java.util.List;

import com.videocrypt.dao.VideoDAO;
import com.videocrypt.model.Video;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VideoListServlet")
public class VideoListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        VideoDAO videoDAO = new VideoDAO();
        List<Video> videos;

        if ("admin".equalsIgnoreCase(role)) {
            videos = videoDAO.getAllVideosForAdmin();
        } else {
            // Get optional filters
            String category = request.getParameter("category");
            String search = request.getParameter("search");
            
            videos = videoDAO.getPublicVideos(category, search);

            // Keep filter values for form retention
            request.setAttribute("selectedCategory", category);
            request.setAttribute("search", search);
        }

        request.setAttribute("videos", videos);

        if ("admin".equalsIgnoreCase(role)) {
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("clientDashboard.jsp").forward(request, response);
        }
    }
}
