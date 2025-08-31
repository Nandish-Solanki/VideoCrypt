package com.videocrypt.dao;

import com.videocrypt.model.Video;
import com.videocrypt.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class VideoDAO {

    // Add a new video
    public boolean addVideo(Video video, int uploadedBy) {
        boolean success = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO videos (title, description, category, file_path, thumbnail_path, visibility, uploaded_by) VALUES (?, ?, ?, ?, ?, ?, ?)"
            );
            pst.setString(1, video.getTitle());
            pst.setString(2, video.getDescription());
            pst.setString(3, video.getCategory());
            pst.setString(4, video.getFilePath());
            pst.setString(5, video.getThumbnailPath());
            pst.setString(6, video.getVisibility() != null ? video.getVisibility() : "Public");
            pst.setInt(7, uploadedBy);

            int row = pst.executeUpdate();
            if (row > 0) success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Admin: get ALL videos (no filters)
    public List<Video> getAllVideosForAdmin() {
        List<Video> videoList = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM videos");
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Video video = new Video();
                video.setId(rs.getInt("id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setCategory(rs.getString("category"));
                video.setFilePath(rs.getString("file_path"));
                video.setThumbnailPath(rs.getString("thumbnail_path"));
                video.setVisibility(rs.getString("visibility"));
                videoList.add(video);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return videoList;
    }

    // Client: get ONLY Public videos + optional filters
    public List<Video> getPublicVideos(String category, String search) {
        List<Video> videoList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            StringBuilder query = new StringBuilder("SELECT * FROM videos WHERE visibility = 'Public'");
            List<Object> parameters = new ArrayList<>();

            if (search != null && !search.trim().isEmpty()) {
                query.append(" AND LOWER(title) LIKE ?");
                parameters.add("%" + search.trim().toLowerCase() + "%");
            }

            if (category != null && !category.trim().isEmpty()) {
                query.append(" AND category = ?");
                parameters.add(category.trim());
            }

            pst = con.prepareStatement(query.toString());

            for (int i = 0; i < parameters.size(); i++) {
                pst.setObject(i + 1, parameters.get(i));
            }

            rs = pst.executeQuery();

            while (rs.next()) {
                Video video = new Video();
                video.setId(rs.getInt("id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setCategory(rs.getString("category"));
                video.setFilePath(rs.getString("file_path"));
                video.setThumbnailPath(rs.getString("thumbnail_path"));
                video.setVisibility(rs.getString("visibility"));
                videoList.add(video);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pst != null) pst.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        return videoList;
    }

    // Get a video by ID
    public Video getVideoById(int id) {
        Video video = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM videos WHERE id=?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                video = new Video();
                video.setId(rs.getInt("id"));
                video.setTitle(rs.getString("title"));
                video.setDescription(rs.getString("description"));
                video.setCategory(rs.getString("category"));
                video.setFilePath(rs.getString("file_path"));
                video.setThumbnailPath(rs.getString("thumbnail_path"));
                video.setVisibility(rs.getString("visibility"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return video;
    }

    // Update video visibility
    public boolean updateVisibility(int videoId, String visibility) {
        boolean updated = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pst = con.prepareStatement(
                "UPDATE videos SET visibility = ? WHERE id = ?"
            );
            pst.setString(1, visibility);
            pst.setInt(2, videoId);

            int rows = pst.executeUpdate();
            if (rows > 0) updated = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
}
