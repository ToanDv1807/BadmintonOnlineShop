/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Customers {

    private int customerID;
    private String email;
    private String password;
    private String fullName;
    private String img_url;
    private String phone;
    private String address;
    private int gender;
    private String createdDate;
    private int status;
    private String note;
    private String paymentMethod;

    public Customers() {
    }

    public Customers(int customerID, String email, String password, String fullName, String img_url, String phone, String address, int gender, String createdDate, int status, String note, String paymentMethod) {
        this.customerID = customerID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.img_url = img_url;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.createdDate = createdDate;
        this.status = status;
        this.note = note;
        this.paymentMethod = paymentMethod;
    }
    

    public Customers(int customerID, String email, String password, String fullName, String img_url, String phone, String address, int gender, String createdDate, int status, String note) {
        this.customerID = customerID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.img_url = img_url;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.createdDate = createdDate;
        this.status = status;
        this.note = note;
    }

    public Customers(String fullName, int customerID, String email) {
        this.customerID=customerID;
        this.fullName=fullName;
        this.email=email;
    }

    public Customers(String fullName, int gender, String email, String phone, String Address) {
        this.fullName = fullName;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.address = Address;

    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    

    @Override
    public String toString() {
        return "Customers{" + "customerID=" + customerID + ", email=" + email + ", password=" + password + ", fullName=" + fullName + ", img_url=" + img_url + ", phone=" + phone + ", Address=" + address + ", gender=" + gender + '}';
    }

}
