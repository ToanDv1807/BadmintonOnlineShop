/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENNOVO
 */
public class DiscountedProducts {
    private int productID;
    private int promotionID;
    private int discountRate;
    private int sizeID;
    public DiscountedProducts() {
    }

    public DiscountedProducts(int productID, int promotionID, int discountRate, int sizeID) {
        this.productID = productID;
        this.promotionID = promotionID;
        this.discountRate = discountRate;
        this.sizeID = sizeID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public int getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(int discountRate) {
        this.discountRate = discountRate;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }
    
}
