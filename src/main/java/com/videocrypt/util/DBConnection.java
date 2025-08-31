package com.videocrypt.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to your local MySQL DB
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/videocrypt?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "piyush@123456789"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
