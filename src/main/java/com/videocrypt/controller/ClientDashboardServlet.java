package com.videocrypt.controller;

import com.videocrypt.dao.VideoDAO;
import com.videocrypt.model.Video;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ClientDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"client".equalsIgnoreCase(String.valueOf(session.getAttribute("role")))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String selectedCategory = request.getParameter("category");
        String search = request.getParameter("search");

        try {
            VideoDAO videoDAO = new VideoDAO();
            List<Video> videoList = videoDAO.getPublicVideos(selectedCategory, search);

            request.setAttribute("videos", videoList);
            request.setAttribute("selectedCategory", selectedCategory);
            request.setAttribute("search", search);

            RequestDispatcher rd = request.getRequestDispatcher("clientDashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
