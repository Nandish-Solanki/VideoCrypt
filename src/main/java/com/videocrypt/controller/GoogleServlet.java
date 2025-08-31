package com.videocrypt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;
import org.json.JSONObject;
import io.github.cdimascio.dotenv.Dotenv;

@WebServlet("/GoogleCallbackServlet")
public class GoogleServlet extends HttpServlet {

    private String CLIENT_ID;
    private String CLIENT_SECRET;
    private String REDIRECT_URI;

    public void init() throws ServletException {
        Dotenv dotenv = Dotenv.load();

        CLIENT_ID = dotenv.get("GOOGLE_CLIENT_ID");
        CLIENT_SECRET = dotenv.get("GOOGLE_CLIENT_SECRET");
        REDIRECT_URI = dotenv.get("GOOGLE_REDIRECT_URI");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code != null) {
            try {
                String tokenEndpoint = "https://oauth2.googleapis.com/token";
                String params = "code=" + URLEncoder.encode(code, "UTF-8")
                        + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                        + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                        + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                        + "&grant_type=authorization_code";

                URL url = new URL(tokenEndpoint);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("POST");
                con.setDoOutput(true);

                OutputStream os = con.getOutputStream();
                os.write(params.getBytes());
                os.flush();
                os.close();

                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                StringBuilder sb = new StringBuilder();
                String line;

                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();

                JSONObject json = new JSONObject(sb.toString());
                String accessToken = json.getString("access_token");

                URL userInfoUrl = new URL("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken);
                HttpURLConnection userInfoCon = (HttpURLConnection) userInfoUrl.openConnection();
                userInfoCon.setRequestMethod("GET");

                BufferedReader userBr = new BufferedReader(new InputStreamReader(userInfoCon.getInputStream()));
                StringBuilder userSb = new StringBuilder();
                String userLine;

                while ((userLine = userBr.readLine()) != null) {
                    userSb.append(userLine);
                }
                userBr.close();

                JSONObject userJson = new JSONObject(userSb.toString());
                String name = userJson.getString("name");
                String email = userJson.getString("email");

                HttpSession session = request.getSession();
                session.setAttribute("username", name);
                session.setAttribute("email", email);
                session.setAttribute("role", "client");

                response.sendRedirect("clientDashboard.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("login.jsp?error=googleauth");
            }
        } else {
            response.sendRedirect("login.jsp?error=googleauth");
        }
    }
}
