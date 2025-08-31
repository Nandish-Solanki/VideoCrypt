package com.videocrypt.controller;

import java.io.IOException;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private static final String TO_EMAIL = "piyushfreedom1947@gmail.com"; // Receiver
    private static final String FROM_EMAIL = "vermapiyush2978@gmail.com";       // Your Gmail
    private static final String PASSWORD = "iutjfrreflilgpac";           // App password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                    }
                });

        try {
            Message mimeMessage = new MimeMessage(session);
            mimeMessage.setFrom(new InternetAddress(FROM_EMAIL));
            mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(TO_EMAIL));
            mimeMessage.setSubject("Contact Form Message");
            mimeMessage.setText("Name: " + name + "\nEmail: " + email + "\nMessage:\n" + message);

            Transport.send(mimeMessage);
            System.out.println("Email sent successfully.");

            request.setAttribute("status", "Message sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("status", "Message sending failed!");
        }

        request.getRequestDispatcher("contact_success.jsp").forward(request, response);
    }
}
