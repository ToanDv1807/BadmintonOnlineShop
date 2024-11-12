/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class Slider {

    private int sliderID;
    private String title;
    private String sliderImgUrl;
    private int status;
    private int employeeID;
    private String createdDate;
    private String backlink;
    private String notes;

    public Slider() {
    }

    public Slider(int sliderID, String title, String sliderImgUrl, int status, int employeeID, String createdDate, String backlink, String notes) {
        this.sliderID = sliderID;
        this.title = title;
        this.sliderImgUrl = sliderImgUrl;
        this.status = status;
        this.employeeID = employeeID;
        this.createdDate = createdDate;
        this.backlink = backlink;
        this.notes = notes;
    }

    public int getSliderID() {
        return sliderID;
    }

    public void setSliderID(int sliderID) {
        this.sliderID = sliderID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSliderImgUrl() {
        return sliderImgUrl;
    }

    public void setSliderImgUrl(String sliderImgUrl) {
        this.sliderImgUrl = sliderImgUrl;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getBacklink() {
        return backlink;
    }

    public void setBacklink(String backlink) {
        this.backlink = backlink;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    
}
