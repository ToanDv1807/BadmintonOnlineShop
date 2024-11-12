/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author MSI1
 */
public class CartItem {

    private int cartItemID;
    private int cartID;
    private int productID;
    private int sizeID;
    private String sizeName;
    private int stock;
    private float price;

    public CartItem() {
    }

    public CartItem(int cartItemID, int cartID, int productID, int sizeID, int stock, float price) {
        this.cartItemID = cartItemID;
        this.cartID = cartID;
        this.productID = productID;
        this.sizeID = sizeID;
        this.stock = stock;
        this.price = price;
    }
    
    

    public CartItem(int cartItemID, int cartID, int productID, String sizeName, int stock) {
        this.cartItemID = cartItemID;
        this.cartID = cartID;
        this.productID = productID;
        this.sizeName = sizeName;
        this.stock = stock;
    }

    public CartItem(int cartItemID, int productID, String sizeName, int stock) {
        this.cartItemID = cartItemID;
        this.productID = productID;
        this.sizeName = sizeName;
        this.stock = stock;
    }

    public CartItem(int cartItemID, int cartID, int productID, int sizeID, int stock) {
        this.cartItemID = cartItemID;
        this.cartID = cartID;
        this.productID = productID;
        this.sizeID = sizeID;
        this.stock = stock;
    }

    public CartItem(int cartItemID, int productID, int sizeID, int stock) {
        this.cartItemID = cartItemID;
        this.productID = productID;
        this.sizeID = sizeID;
        this.stock = stock;
    }
    
    

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
    

    public int getCartItemID() {
        return cartItemID;
    }

    public void setCartItemID(int cartItemID) {
        this.cartItemID = cartItemID;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

}
