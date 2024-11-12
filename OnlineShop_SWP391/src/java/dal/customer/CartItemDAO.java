/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

/**
 *
 * @author MSI1
 */
import dal.db.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;

public class CartItemDAO extends DBContext {

    // Method to get cart items by cartID
    public List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "select c.cartItemID, c.cartID,c.productID, c.stock, c.sizeID, c.price\n"
                + "from CartItem c\n"
                + "where c.cartID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int cartItemId = resultSet.getInt("cartItemID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int stock = resultSet.getInt("stock");
                float price = resultSet.getFloat("price");
                CartItem cartItem = new CartItem(cartItemId, cartId, productID, sizeID, stock, price);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return cartItems;
    }

    // Method to get cart items by cartID
    public CartItem getCartItemsByCartItemId(int cartItemID) {

        CartItem cartItem = null; // Khởi tạo bằng null để kiểm tra xem có sản phẩm được tìm thấy hay không
        String sql = "select c.cartItemID, c.cartID, c.productID, c.stock, c.sizeID\n"
                + "from CartItem c\n"
                + "where c.cartItemID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, cartItemID);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int cartItemId = resultSet.getInt("cartItemID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int stock = resultSet.getInt("stock");

                cartItem = new CartItem(cartItemId, productID, sizeID, stock);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItem;
    }

    public void deleteCartItemFromDB(int cartItemId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "DELETE FROM [CartItem] \n"
                + "      WHERE cartItemID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartItemId);
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

    }

    public void updateCartItemQuantity(int cartItemID, int stock) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "UPDATE [dbo].[CartItem]\n"
                + "   SET [stock] = ?\n"
                + " WHERE cartItemID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, stock);
            statement.setObject(2, cartItemID);
            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
    }

    public int deleteCartItemByCartID(int cartID) {
        int result = 0;
        String sql = "DELETE FROM [dbo].[CartItem]\n"
                + "      WHERE cartID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartID);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public int insertCartItem(CartItem cartItem) {
        int result = 0;
        String sql = "insert into CartItem(cartID,productID,stock,sizeID,price) values (?,?,?,?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartItem.getCartID());
            statement.setObject(2, cartItem.getProductID());
            statement.setObject(3, cartItem.getStock());
            statement.setObject(4, cartItem.getSizeID());
            statement.setObject(5, cartItem.getPrice());

            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public int updateCartItem(CartItem cartItem) {
        int result = 0;
        String sql = "UPDATE CartItem set stock = ? WHERE cartID = ? and productID = ? and sizeID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartItem.getStock());
            statement.setObject(2, cartItem.getCartID());
            statement.setObject(3, cartItem.getProductID());
            statement.setObject(4, cartItem.getSizeID());
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return result;
    }

    public int checkExistingProductInCart(CartItem cartItem) {
        int result = 0;
        String sql = "select count(*)\n"
                + "from CartItem c\n"
                + "where c.cartID = ? and c.productID = ? and c.sizeID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartItem.getCartID());
            statement.setObject(2, cartItem.getProductID());
            statement.setObject(3, cartItem.getSizeID());
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return result;
    }

    public CartItem getCartItem(CartItem cartItem) {

        CartItem ci = null;
        String sql = "select c.cartItemID, c.cartID, c.productID, c.sizeID, c.stock, c.price\n"
                + "from CartItem c\n"
                + "where c.cartItemID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartItem.getCartItemID());
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int cartItemID = resultSet.getInt("cartItemID");
                int cartID = resultSet.getInt("cartID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int stock = resultSet.getInt("stock");
                float price = resultSet.getFloat("price");
                ci = new CartItem(cartItemID, cartID, productID, sizeID, stock, price);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return ci;
    }

    public int getCartItemID(int cartID, int productID, int sizeID) {
        String sql = "select *\n"
                + "from CartItem c\n"
                + "where c.cartID = ? and c.productID = ? and c.sizeID = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, cartID);
            statement.setObject(2, productID);
            statement.setObject(3, sizeID);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("CartItemID");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return -1;
    }

    public float getTotalAmountCartItem(int customerID) {
        String sql = "select sum(ci.price * ci.stock)\n"
                + "from CartItem ci\n"
                + "join Cart c on ci.cartID = c.cartID\n"
                + "where c.customerID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        System.out.println(new CartItemDAO().getTotalAmountCartItem(4));
    }
}
