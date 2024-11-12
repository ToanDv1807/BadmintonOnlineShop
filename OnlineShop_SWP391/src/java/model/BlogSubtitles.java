/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENNOVO
 */
public class BlogSubtitles {
    private int subtitleID;
    private int blogID;
    private String subtitle;
    private String imgUrl;
    private String content;

    public BlogSubtitles() {
    }

    public BlogSubtitles(int subtitleID, int blogID, String subtitle, String imgUrl, String content) {
        this.subtitleID = subtitleID;
        this.blogID = blogID;
        this.subtitle = subtitle;
        this.imgUrl = imgUrl;
        this.content = content;
    }

    public int getSubtitleID() {
        return subtitleID;
    }

    public void setSubtitleID(int subtitleID) {
        this.subtitleID = subtitleID;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
}
