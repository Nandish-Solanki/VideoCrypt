package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import com.videocrypt.util.DBConnection;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE username=? AND password=?";
            pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                String profilePicPath = rs.getString("profile_pic");

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // ✅ Store profilePic path in session if exists
                if (profilePicPath != null && !profilePicPath.isEmpty()) {
                    session.setAttribute("profilePic", profilePicPath);
                } else {
                    session.setAttribute("profilePic", null);
                }

                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("AdminDashboardServlet");
                } else {
                    response.sendRedirect("ClientDashboardServlet");
                }

            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server");

        } finally {
            // ✅ Close resources
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pst != null) pst.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
