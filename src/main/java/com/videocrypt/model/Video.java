package com.videocrypt.model;

public class Video {
    private int id;
    private String title;
    private String description;
    private String category;
    private String filePath;
    private String visibility;
    private String thumbnailPath; // ✅ New field

    public Video() {
        // Default constructor
    }

    public Video(int id, String title, String description, String category, String filePath, String visibility, String thumbnailPath) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.category = category;
        this.filePath = filePath;
        this.visibility = visibility;
        this.thumbnailPath = thumbnailPath;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }

    public String getThumbnailPath() {  // ✅ Getter for thumbnailPath
        return thumbnailPath;
    }

    public void setThumbnailPath(String thumbnailPath) {  // ✅ Setter for thumbnailPath
        this.thumbnailPath = thumbnailPath;
    }

    @Override
    public String toString() {
        return "Video { " +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", filePath='" + filePath + '\'' +
                ", visibility='" + visibility + '\'' +
                ", thumbnailPath='" + thumbnailPath + '\'' +
                " }";
    }
}
