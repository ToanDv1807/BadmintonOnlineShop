/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class Product_Attribute_Stock {

    private int productID;
    private int sizeID;

    private int stock;
    private int hold;
    private float importPrice;
    private float price;
    private String sizeName;

    public Product_Attribute_Stock() {
    }

    public Product_Attribute_Stock(int productID, int sizeID, int stock, int hold, float importPrice, float price) {
        this.productID = productID;
        this.sizeID = sizeID;
        this.stock = stock;
        this.hold = hold;
        this.importPrice = importPrice;
        this.price = price;
    }

    public Product_Attribute_Stock(int productID, int sizeID, int stock, int hold, float importPrice, float price, String sizeName) {
        this.productID = productID;
        this.sizeID = sizeID;
        this.stock = stock;
        this.hold = hold;
        this.importPrice = importPrice;
        this.price = price;
        this.sizeName = sizeName;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getHold() {
        return hold;
    }

    public void setHold(int hold) {
        this.hold = hold;
    }

    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

}
