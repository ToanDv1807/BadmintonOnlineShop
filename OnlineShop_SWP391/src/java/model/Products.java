/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Acer
 */
public class Products {

//    SELECT TOP (1000) [productID]
//      ,[productName]
//      ,[price]
//      ,[catID]
//      ,[brandID]
//      ,[description]
//      ,[createdAt]
//      ,[quantity]
//  FROM [SWP391_Project].[dbo].[Products]
    private int productID;
    private String productName;
    private float importPrice;
    private float price;
    private int catID;
    private int brandID;
    private String briefInfo;
    private String attributeValue;
    private String description;
    private Date createdAt;
    private int quantity;
    private int status;
    private int featureStatus;

    public Products() {
    }

    public Products(int productID, String productName, String attributeValue) {
        this.productID = productID;
        this.productName = productName;
        this.attributeValue = attributeValue;
    }

    public Products(int productID, String productName, float price) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
    }

    public Products(int productID, String productName, float importPrice, float price, int catID, int brandID, String briefInfo, String description, Date createdAt, int quantity, int status, int featureStatus) {
        this.productID = productID;
        this.productName = productName;
        this.importPrice = importPrice;
        this.price = price;
        this.catID = catID;
        this.brandID = brandID;
        this.briefInfo = briefInfo;
        this.description = description;
        this.createdAt = createdAt;
        this.quantity = quantity;
        this.status = status;
        this.featureStatus = featureStatus;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getFeatureStatus() {
        return featureStatus;
    }

    public void setFeatureStatus(int featureStatus) {
        this.featureStatus = featureStatus;
    }

    public String getBriefInfo() {
        return briefInfo;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }

    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    public String getAttributeValue() {
        return attributeValue;
    }

    public void setAttributeValue(String attributeValue) {
        this.attributeValue = attributeValue;
    }

}
