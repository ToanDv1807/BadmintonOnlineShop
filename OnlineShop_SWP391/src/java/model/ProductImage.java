/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Acer
 */
public class ProductImage {
//    SELECT TOP (1000) [productImgID]
//      ,[productImgUrl]
//      ,[productID]
//  FROM [SWP391_Project].[dbo].[ProductImage]

    private int productImgID;
    private String productImgUrl;
    private int productID;

    public ProductImage() {
    }

    public ProductImage(int productImgID, String productImgUrl, int productID) {
        this.productImgID = productImgID;
        this.productImgUrl = productImgUrl;
        this.productID = productID;
    }

    public ProductImage(String productImgUrl, int productID) {
        this.productImgUrl = productImgUrl;
        this.productID = productID;
    }
    

    public int getProductImgID() {
        return productImgID;
    }

    public void setProductImgID(int productImgID) {
        this.productImgID = productImgID;
    }

    public String getProductImgUrl() {
        return productImgUrl;
    }

    public void setProductImgUrl(String productImgUrl) {
        this.productImgUrl = productImgUrl;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }
    

}
