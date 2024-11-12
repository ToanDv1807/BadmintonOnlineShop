/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Status {
    private int statusID;
    private String statusName;
    private int status;
    private int pre;
    private int post;

    public Status(int statusID, String statusName) {
        this.statusID = statusID;
        this.statusName = statusName;
    }

    public Status(int statusID, String statusName, int status) {
        this.statusID = statusID;
        this.statusName = statusName;
        this.status = status;
    }

    public Status(int statusID, String statusName, int status, int pre, int post) {
        this.statusID = statusID;
        this.statusName = statusName;
        this.status = status;
        this.pre = pre;
        this.post = post;
    }
    

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    

    public Status() {
    }
 
    // Getters and Setters
    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public int getPre() {
        return pre;
    }

    public void setPre(int pre) {
        this.pre = pre;
    }

    public int getPost() {
        return post;
    }

    public void setPost(int post) {
        this.post = post;
    }

    @Override
    public String toString() {
        return "Status{" + "statusID=" + statusID + ", statusName=" + statusName + ", status=" + status + ", pre=" + pre + ", post=" + post + '}';
    }

    
    
}
