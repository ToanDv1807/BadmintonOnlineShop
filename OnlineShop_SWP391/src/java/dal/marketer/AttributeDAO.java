/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Attributes;

import model.Product_Attribute_Stock;

/**
 *
 * @author Acer
 */
public class AttributeDAO extends DBContext {

    public List<Attributes> getAllAttributes() {
        List<Attributes> list = new ArrayList<>();
        String sql = "SELECT * FROM Attributes";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attributes c = new Attributes(
                        rs.getInt("attributeID"),
                        rs.getString("attributeName")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    // In the DAO class
    public List<Product_Attribute_Stock> getAllProduct_Attribute_Stock() {
        List<Product_Attribute_Stock> list = new ArrayList<>();
        String sql = "SELECT * FROM Product_Attribute_Stock";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product_Attribute_Stock c = new Product_Attribute_Stock(
                        rs.getInt("productID"),
                        rs.getInt("sizeID"),
                        rs.getInt("stock"),
                        rs.getInt("hold"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    public List<Product_Attribute_Stock> getProductAttributesByProductID(int productID) {
        List<Product_Attribute_Stock> list = new ArrayList<>();
        String sql = "SELECT productID, sizeID, stock, hold, importPrice, price "
                + "FROM Product_Attribute_Stock "
                + "WHERE productID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product_Attribute_Stock c = new Product_Attribute_Stock(
                        rs.getInt("productID"),
                        rs.getInt("sizeID"),
                        rs.getInt("stock"),
                        rs.getInt("hold"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    public boolean sizeIDExists(int sizeID, int productID) {
        String sql = "SELECT COUNT(*) FROM [dbo].[Product_Attribute_Stock] WHERE [sizeID] = ? and productID = ?";
        boolean exists = false;

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, sizeID);
            pstmt.setInt(2, productID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    exists = rs.getInt(1) > 0; // If count is greater than 0, sizeID exists
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }

        return exists;
    }

    public void insertNewSizeAndPrice(int productID, int sizeID, int stock, float importPrice, int hold) {
        String sql = "INSERT INTO [dbo].[Product_Attribute_Stock] "
                + "([productID], [sizeID], [stock], [hold], [importPrice]) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, productID);
            pstmt.setInt(2, sizeID);
            pstmt.setInt(3, stock);
            pstmt.setInt(4, hold);
            pstmt.setFloat(5, importPrice);

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
    }

    public void updateStockAndImportPrice(int stock, float importPrice, int productID, int sizeID) {
        String sql = "UPDATE Product_Attribute_Stock SET stock = ?, importPrice = ? WHERE productID = ? AND sizeID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, stock);
            statement.setFloat(2, importPrice);
            statement.setInt(3, productID);
            statement.setInt(4, sizeID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    

    public void updateHold(int hold, int productID, int sizeID) {
        String sql = "UPDATE Product_Attribute_Stock SET hold = ? WHERE productID = ? AND sizeID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, hold);
            statement.setInt(2, productID);
            statement.setInt(3, sizeID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateStock(int stock, int productID, int sizeID) {
        String sql = "UPDATE Product_Attribute_Stock SET Stock = ? WHERE productID = ? AND sizeID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, stock);
            statement.setInt(2, productID);
            statement.setInt(3, sizeID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Product_Attribute_Stock getProduct_Attribute_Stock(int productID, int sizeID) {
        String sql = "SELECT pas.productID, pas.sizeID, pas.stock, pas.hold, pas.importPrice, pas.price\n"
                + "FROM Product_Attribute_Stock pas\n"
                + "WHERE pas.productID = ? AND pas.sizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID);
            ps.setObject(2, sizeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product_Attribute_Stock product = new Product_Attribute_Stock(
                        rs.getInt("productID"),
                        rs.getInt("sizeID"),
                        rs.getInt("stock"),
                        rs.getInt("hold"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price"));
                return product;
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return null;
    }
//    public Product_Attribute_Stock getProduct_Attribute_Stock1(int productID, String attributeValue) {
//        String sql = "SELECT productID, attributeID, attributeValue, stock, hold, importPrice, price "
//                + "FROM Product_Attribute_Stock WHERE productID = ? AND attributeValue = ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setInt(1, productID);
//            ps.setString(2, attributeValue);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return new Product_Attribute_Stock(
//                        rs.getInt("productID"),
//                        rs.getInt("attributeID"),
//                        rs.getString("attributeValue"),
//                        rs.getInt("stock"),
//                        rs.getInt("hold"),
//                        rs.getFloat("importPrice"),
//                        rs.getString("price")
//                );
//            }
//        } catch (SQLException e) {
//            System.err.println(e);
//        }
//        return null;
//    }

    public int getAvailableStock(int productID, String attributeValue) {
        String sql = "SELECT stock, hold FROM Product_Attribute_Stock WHERE productID = ? AND attributeValue = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setString(2, attributeValue);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock") - rs.getInt("hold");
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return 0;
    }

    public int getStock(int productID, String attributeValue) {
        String sql = "SELECT stock FROM Product_Attribute_Stock WHERE productID = ? AND attributeValue = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setString(2, attributeValue);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock");
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return 0;
    }

    public void addAttributeStock(int productID, int attributeID, String attributeValue, int stock, String importPrice, String price) {
        String sql = "INSERT INTO Product_Attribute_Stock (productID, attributeID, attributeValue, stock, hold, importPrice, price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setInt(2, attributeID);
            ps.setString(3, attributeValue);
            ps.setInt(4, stock);
            ps.setInt(5, 0); // Default hold value
            ps.setString(6, importPrice);
            ps.setString(7, price);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e);
        }
    }

    public boolean isAttributeValueExists(int productID, String attributeValue) {
        String sql = "SELECT COUNT(*) FROM Product_Attribute_Stock WHERE productID = ? AND attributeValue = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setString(2, attributeValue);
            ResultSet rs = ps.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("Error checking attribute value existence: " + e.getMessage());
        }
        return false;
    }

    public boolean updateAttributeProduct(int productID, int attributeID, String newAttributeValue, int stock, String importPrice, String price, String oldAttributeValue) {
        String sql = "UPDATE Product_Attribute_Stock SET attributeValue = ?, stock = ?, importPrice = ?, price = ? "
                + "WHERE productID = ? AND attributeValue = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newAttributeValue);
            ps.setInt(2, stock);
            ps.setString(3, importPrice);
            ps.setString(4, price);
            ps.setInt(5, productID);
            ps.setString(6, oldAttributeValue);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating attribute stock: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteProductAttribute(int productID, String attributeValue) {
        String sql = "DELETE FROM Product_Attribute_Stock WHERE productID = ? AND attributeValue = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setString(2, attributeValue);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Exception occurred while deleting attribute: " + e.getMessage());
        }
        return false;
    }
    
    

    public static void main(String[] args) {
        System.out.println(new AttributeDAO().getProduct_Attribute_Stock(1, 1));
    }

}
