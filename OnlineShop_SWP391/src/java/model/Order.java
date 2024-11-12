/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Tan
 */
public class Order {

    private int orderID;
    private int customerID;
    private String orderDate;
    private int orderStatus;
    private String productName;
    private String note;
    private float totalAmount;
    private int quantity;
    private String fullName;
    private Customers customer;  // Đối tượng Customers
    private List<OrderDetail> orderDetails;  // Danh sách chi tiết đơn hàng
    private String category;
    private String saleName;
    private String statusName;
    private String paymentMethod;
    private int employeeID;
    private String addressName;
    
    public Order() {
    }

    public Order(int orderID, int employeeID) {
        this.orderID = orderID;
        this.employeeID = employeeID;
    } 

    public Order(int orderID, int customerID, String orderDate, int orderStatus, String note, String paymentMethod, String addressName) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.note = note;
        this.paymentMethod = paymentMethod;
        this.addressName = addressName;
    }
    
    public Order(int orderID, int customerID, String orderDate, int orderStatus, String note) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.note = note;
    }

    public Order(int orderID, int customerID, String orderDate, int orderStatus, String productName, String note, float totalAmount, int quantity) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.productName = productName;
        this.note = note;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
    }

//o.orderID, o.orderDate, o.orderStatus, o.totalAmount, p.productName,
    public Order(int orderID, String orderDate, int orderStatus, float totalAmount, int quantity, String productName) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
        this.productName = productName;
    }

    public Order(int orderID, String orderDate, String statusName, float totalAmount, int quantity, String productName) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.statusName = statusName;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
        this.productName = productName;
    }

    public Order(int orderID, int customerID, String orderDate, int orderStatus, String productName, String note, float totalAmount, int quantity, String fullName) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.productName = productName;
        this.note = note;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
        this.fullName = fullName;
    }

    public Order(int orderID, String orderDate, int orderStatus, String productName, int quantity, float totalAmount) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.productName = productName;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
    }

    public Order(int orderID, String orderDate, int orderStatus, String productName, int quantity, float totalAmount, String fullName) {
        this(orderID, orderDate, orderStatus, productName, quantity, totalAmount);  // Gọi constructor cũ
        this.fullName = fullName;  // Gán thêm fullName
    }

    // Constructor mới - thêm đối tượng customer
    public Order(int orderID, String orderDate, int orderStatus, String productName, int quantity, float totalAmount, Customers customer, List<OrderDetail> orderDetails, String category, String saleName) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.productName = productName;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.customer = customer;
        this.orderDetails = orderDetails;  // Gán danh sách chi tiết đơn hàng
        this.category = category;
        this.saleName = saleName;
    }
        public Order(int orderID, String orderDateString,int orderStatus, String statusName, String productName, int quantity, float totalAmount, String fullName) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.orderStatus= orderStatus;
        this.statusName = statusName;
        this.productName = productName;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.fullName = fullName;  // Gán thêm fullName
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSaleName() {
        return saleName;
    }

    public void setSaleName(String saleName) {
        this.saleName = saleName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }
    
}
