package model;

public class Account {
    private String email;
    private String password;
    private String userType; // Employee hoặc Customer
    private int roleID; // Sử dụng roleID chỉ cho Employee
    private int employeeID;
    private int status;
    public Account() {
    }

    public Account(String email, String password, String userType, int roleID) {
        this.email = email;
        this.password = password;
        this.userType = userType;
        this.roleID = roleID;
    }

    public Account(String email, String password, String userType, int roleID, int employeeID, int status) {
        this.email = email;
        this.password = password;
        this.userType = userType;
        this.roleID = roleID;
        this.employeeID = employeeID;
        this.status= status;
    }
    

    // Getter và Setter cho roleID
    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    // Getter và Setter cho các thuộc tính khác
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

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
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

    @Override
    public String toString() {
        return "Account{" + "email=" + email + ", password=" + password + ", userType=" + userType + ", roleID=" + roleID + ", employeeID=" + employeeID + ", status=" + status + '}';
    }
    


}
