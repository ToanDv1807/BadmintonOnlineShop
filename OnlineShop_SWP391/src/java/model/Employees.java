/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Employees {

    private int employeeID;
    private String email;
    private String password;
    private String fullName;
    private String Address;
    private int roleID;
    private int status;
    private int gender;
    private String img_url;
    private String phone;
    private int totalOrder;
    public Employees() {
    }

    public Employees(int employeeID, String email, String password, String fullName, String Address, int roleID, int status, int gender, String img_url, String phone) {
        this.employeeID = employeeID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.Address = Address;
        this.roleID = roleID;
        this.status = status;
        this.gender = gender;
        this.img_url = img_url;
        this.phone = phone;
    }

    public Employees(int employeeID, String email, String password, String fullName, String Address, int roleID, int status) {
        this.employeeID = employeeID;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.Address = Address;
        this.roleID = roleID;
        this.status = status;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
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

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
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

    public int getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(int totalOrder) {
        this.totalOrder = totalOrder;
    }
    
    @Override
    public String toString() {
        return "Employees{" + "employeeID=" + employeeID + ", email=" + email + ", password=" + password + ", fullName=" + fullName + ", Address=" + Address + ", roleID=" + roleID + ", status=" + status + '}';
    }

}
