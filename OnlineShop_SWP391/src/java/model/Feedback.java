/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Tan
 */
public class Feedback {

    //id, customer id,contact full name, email, mobile, product, rated star, feedback, images status
    private int feedbackID, customerID;
    private String customerName, customerEmail, customerPhone, productName;
    private int productID, rated;
    private String content;
    private int status;
    private String feedbackDate;
    private int orderID;
    private String attributeValue;
    private int sizeID;

    public Feedback() {
    }
//    //      ,[customerID]
//      ,[comment]
//      ,[rating]
//      ,[feedbackDate]
//      ,[productID]
//      ,[status]
//name, rate, comment, dateString, attributeValue

    public Feedback(int productID, int rated) {
        this.productID = productID;
        this.rated = rated;
    }

    public Feedback(int productID, String attributeValue) {
        this.productID = productID;
        this.attributeValue = attributeValue;
    }

    public Feedback(String customerName, int rated, String content, String feedbackDate, String attributeValue) {
        this.customerName = customerName;
        this.rated = rated;
        this.content = content;
        this.feedbackDate = feedbackDate;
        this.attributeValue = attributeValue;
    }

    public Feedback(int feedbackID, int customerID, String customerName, String customerEmail, String customerPhone, String productName, int productID, int rated, String content, int status, String feedbackDate) {
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.productName = productName;
        this.productID = productID;
        this.rated = rated;
        this.content = content;
        this.status = status;
        this.feedbackDate = feedbackDate;
    }

    public Feedback(int customerID, int productID, int rated, String content, int status, String feedbackDate, int orderID, int sizeID) {
        this.customerID = customerID;
        this.productID = productID;
        this.rated = rated;
        this.content = content;
        this.status = status;
        this.feedbackDate = feedbackDate;
        this.orderID = orderID;
        this.sizeID = sizeID;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeebackID(int feebackID) {
        this.feedbackID = feebackID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getRated() {
        return rated;
    }

    public void setRated(int rated) {
        this.rated = rated;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(String feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public String getAttributeValue() {
        return attributeValue;
    }

    public void setAttributeValue(String attributeValue) {
        this.attributeValue = attributeValue;
    }

    @Override
    public String toString() {
        return "Feedback{"
                + "feedbackID=" + feedbackID
                + ", customerID=" + customerID
                + ", customerName='" + customerName + '\''
                + ", customerEmail='" + customerEmail + '\''
                + ", customerPhone='" + customerPhone + '\''
                + ", productName='" + productName + '\''
                + ", productID=" + productID
                + ", rated=" + rated
                + ", content='" + content + '\''
                + ", status=" + status
                + '}';
    }

}
