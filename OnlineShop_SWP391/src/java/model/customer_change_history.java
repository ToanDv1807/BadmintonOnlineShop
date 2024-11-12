/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENNOVO
 */
public class customer_change_history {

    private int customer_id;
    private String email;
    private String full_name;
    private int gender;
    private String mobile;
    private String address;
    private String updated_by;
    private String updated_date;

    public customer_change_history() {
    }

    public customer_change_history(int customer_id, String email, String full_name, int gender, String mobile, String address, String updated_by, String updated_date) {
        this.customer_id = customer_id;
        this.email = email;
        this.full_name = full_name;
        this.gender = gender;
        this.mobile = mobile;
        this.address = address;
        this.updated_by = updated_by;
        this.updated_date = updated_date;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(String updated_date) {
        this.updated_date = updated_date;
    }

    public String getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }

}
