/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class SubImage {

    private int subImgID;
    private int productImgID;
    private String imgUrl;
    private int productID;

    public SubImage() {
    }

    public SubImage(int subImgID, int productImgID, String imgUrl, int productID) {
        this.subImgID = subImgID;
        this.productImgID = productImgID;
        this.imgUrl = imgUrl;
        this.productID = productID;
    }

   

    public int getSubImgID() {
        return subImgID;
    }

    public void setSubImgID(int subImgID) {
        this.subImgID = subImgID;
    }

    public int getProductImgID() {
        return productImgID;
    }

    public void setProductImgID(int productImgID) {
        this.productImgID = productImgID;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }
    

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
