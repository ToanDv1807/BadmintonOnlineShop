package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {

    private int cartID;
    private int customerID;
    List<CartItem> listCartItem = new ArrayList<>();

    public Cart() {
    }

    public Cart(int cartID, int customerID) {
        this.cartID = cartID;
        this.customerID = customerID;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public List<CartItem> getListCartItem() {
        return listCartItem;
    }

    public void setListCartItem(List<CartItem> listCartItem) {
        this.listCartItem = listCartItem;
    }
    


    
}
