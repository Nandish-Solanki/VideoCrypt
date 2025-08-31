package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        HttpSession session = request.getSession(false);
        int userId = (Integer) session.getAttribute("userId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/videocryptdb", "root", "password");

            PreparedStatement ps = con.prepareStatement("UPDATE users SET username=?, email=? WHERE id=?");
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setInt(3, userId);

            ps.executeUpdate();
            con.close();

            session.setAttribute("username", username);
            session.setAttribute("email", email);

            response.sendRedirect("clientDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editProfile.jsp?error=update");
        }
    }
}
