/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class Category {
    private int catID;
    private String catName, description;
    private String url_size_guide;
    private int status;
    
    public Category() {
    }

    public Category(int catID, String catName, String description, String url_size_guide, int status) {
        this.catID = catID;
        this.catName = catName;
        this.description = description;
        this.url_size_guide = url_size_guide;
        this.status = status;
    }

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public String getCatName() {
        return catName;
    }

    public void setCatName(String catName) {
        this.catName = catName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl_size_guide() {
        return url_size_guide;
    }

    public void setUrl_size_guide(String url_size_guide) {
        this.url_size_guide = url_size_guide;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    

    

    

    
    
    
    
}
