package com.videocrypt.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.videocrypt.util.DBConnection;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Handle POST requests from register.jsp
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate inputs (optional)
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkUser = con.prepareStatement("SELECT * FROM users WHERE username=?")) {

            // Check if user already exists
            checkUser.setString(1, username);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) {
                // Username already exists
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            // Insert new user into 'users' table
            PreparedStatement pst = con.prepareStatement("INSERT INTO users (username, password, role) VALUES (?, ?, ?)");
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, "client"); // default role for new registrations

            int result = pst.executeUpdate();

            if (result > 0) {
                // Successful registration, redirect to login page
                response.sendRedirect("login.jsp?success=registered");
            } else {
                // Registration failed
                response.sendRedirect("register.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=exception");
        }
    }
}
