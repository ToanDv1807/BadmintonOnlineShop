/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class Size {
    private int productID;
    private int sizeID;
    private String sizeName;
    private int status;
    private int attributeID;
    private int catID;
    private String description;
   private float importPrice;
   private float price;
    public Size() {
    }

    public Size(int productID, int sizeID, String sizeName, int status, int attributeID, int catID, String description) {
        this.productID = productID;
        this.sizeID = sizeID;
        this.sizeName = sizeName;
        this.status = status;
        this.attributeID = attributeID;
        this.catID = catID;
        this.description = description;
    }

    
    
    public Size(int sizeID, String sizeName, int status, int attributeID, int catID, String description) {
        this.sizeID = sizeID;
        this.sizeName = sizeName;
        this.status = status;
        this.attributeID = attributeID;
        this.catID = catID;
        this.description = description;
    }

    public Size(int productID, int sizeID, String sizeName, int status, int attributeID, int catID, String description, float importPrice, float price) {
        this.productID = productID;
        this.sizeID = sizeID;
        this.sizeName = sizeName;
        this.status = status;
        this.attributeID = attributeID;
        this.catID = catID;
        this.description = description;
        this.importPrice = importPrice;
        this.price = price;
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

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getAttributeID() {
        return attributeID;
    }

    public void setAttributeID(int attributeID) {
        this.attributeID = attributeID;
    }

    public int getCatID() {
        return catID;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
    
     
    
    
}
