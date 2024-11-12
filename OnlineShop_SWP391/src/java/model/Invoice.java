/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author MSI1
 */
public class Invoice {
    private int invoiceID;
    private int orderID;
    private String invoiceDate;
    private float totalAmount;
    private String paymentMethod;

    public Invoice() {
    }

    public Invoice(int orderID, String invoiceDate, float totalAmount, String paymentMethod) {
        this.orderID = orderID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
    }
    
    

    public Invoice(int invoiceID, int orderID, String invoiceDate, float totalAmount, String paymentMethod) {
        this.invoiceID = invoiceID;
        this.orderID = orderID;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
    }
    
    

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(String invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    
    
}
