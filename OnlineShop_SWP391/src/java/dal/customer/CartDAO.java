/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import dal.marketer.ProductDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Cart;
import model.CartItem;
import model.Order;
import model.Products;

/**
 *
 * @author MSI1
 */
public class CartDAO extends DBContext {

    ProductDAO dao = new ProductDAO();

    public Cart getCartIdByUserId(int customerID) {
        Cart cart = null;
        String sql = "SELECT cartID FROM Cart WHERE customerID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, customerID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int cartID = resultSet.getInt("cartID");
                cart = new Cart(cartID, customerID);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return cart;
    }

    public int deleteCartByCustomerID(int customerID) {
        int result = 0;
        String sql = "DELETE FROM CART WHERE customerID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, customerID);
            result = statement.executeUpdate();

            
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }
    
    public int insertCart(Cart cart){
        int result = 0;
        String sql = "insert into Cart(customerID) values (?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cart.getCustomerID());

            result = statement.executeUpdate();

   
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }
    public static void main(String[] args) {
        Cart cart = new Cart();
        cart.setCustomerID(5);
        System.out.println(new CartDAO().insertCart(cart));
    }

}



