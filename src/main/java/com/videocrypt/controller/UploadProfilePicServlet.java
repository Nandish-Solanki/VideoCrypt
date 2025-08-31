package com.videocrypt.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.videocrypt.util.DBConnection;

@WebServlet("/UploadProfilePicServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
                 maxFileSize=1024*1024*10,      // 10MB
                 maxRequestSize=1024*1024*50)   // 50MB
public class UploadProfilePicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");

        Part filePart = request.getPart("profilePic");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        // Set profile pic URL (relative path)
        String profilePicPath = "uploads/" + fileName;

        // Update in database
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement("UPDATE users SET profile_pic = ? WHERE username = ?");
            pst.setString(1, profilePicPath);
            pst.setString(2, username);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Also update in session immediately
        session.setAttribute("profilePic", profilePicPath);

        response.sendRedirect("editProfile.jsp");  // or wherever you want
    }
}
