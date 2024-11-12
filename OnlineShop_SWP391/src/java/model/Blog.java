/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENNOVO
 */
public class Blog {

    public int blogId;
    public String title;
    public String content;
    public String briefInfo;
    public String blogImgUrl;
    public String createdDate;
    public String updatedDate;
    public int categoryID;
    public int employeeID;
    public int status;
    public int featureStatus;

    public Blog() {
    }

    public Blog(int blogId, String title, String content, String briefInfo,
            String blogImgUrl, String createdDate, String updatedDate,
            int categoryID, int employeeID, int status, int featureStatus) {
        this.blogId = blogId;
        this.title = title;
        this.content = content;
        this.briefInfo = briefInfo;
        this.blogImgUrl = blogImgUrl;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.categoryID = categoryID;
        this.employeeID = employeeID;
        this.status = status;
        this.featureStatus = featureStatus;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getBriefInfo() {
        return briefInfo;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }

    public String getBlogImgUrl() {
        return blogImgUrl;
    }

    public void setBlogImgUrl(String BlogImgUrl) {
        this.blogImgUrl = BlogImgUrl;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getFeatureStatus() {
        return featureStatus;
    }

    public void setFeatureStatus(int featureStatus) {
        this.featureStatus = featureStatus;
    }

}
