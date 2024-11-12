/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.DiscountedProducts;
import model.Product_Attribute_Stock;
import model.Products;
import model.Promotion;

/**
 *
 * @author Acer
 */
public class PromotionDAO extends DBContext {

    public List<Promotion> getAllPromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "select * from Promotion";
        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Promotion promotion = new Promotion(
                        rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getString(7)
                );
                promotions.add(promotion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }

    public Promotion getActivePromotion() {
        String sql = "SELECT * FROM Promotion WHERE StartDate <= ? AND EndDate >= ? And Status = 1";
        String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, currentDate);
            pstmt.setString(2, currentDate);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    return new Promotion(
                            rs.getInt(1), rs.getString(2),
                            rs.getString(3), rs.getString(4),
                            rs.getString(5), rs.getInt(6), rs.getString(7)
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Promotion getPromotionByProductId(int productID) {
        String sql = "select * from Promotion WHERE productID = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, productID);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Promotion(
                        rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getString(7)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Promotion> getFilteredPromotion(String status, String searchTitle) {
        List<Promotion> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Promotion WHERE 1=1");

        // List to store parameters
        List<Object> parameters = new ArrayList<>();

        // Add filters based on provided parameters
        if (status != null && !status.isEmpty()) {
            try {
                // Convert status to integer and add to parameters
                int statusInt = Integer.parseInt(status);
                sql.append(" AND Status = ?");
                parameters.add(statusInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid status format: " + status); // Log invalid status
                return list; // Return empty list if status is invalid
            }
        }
        if (searchTitle != null && !searchTitle.isEmpty()) {
            sql.append(" AND (Name LIKE ? OR Description LIKE ?)");
            String searchParam = "%" + searchTitle + "%"; // Use LIKE for searching
            parameters.add(searchParam);
            parameters.add(searchParam);
        }

        try {
            PreparedStatement stm = connection.prepareStatement(sql.toString());

            // Set parameters in PreparedStatement
            for (int i = 0; i < parameters.size(); i++) {
                stm.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Promotion(
                        rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }

        return list;
    }

    public List<Promotion> getPaginatedPromotionList(int index) {
        List<Promotion> list = new ArrayList<>();
        String sql = "select * from Promotion\n"
                + "order by PromotionID\n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Promotion(
                        rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public void addPromotion(String promotionName, String startDate, String endDate, String description, String status, String note) {
        String sql = "INSERT INTO Promotion (Name, StartDate, EndDate, Description, Status, Note) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, promotionName);
            stm.setString(2, startDate);
            stm.setString(3, endDate);
            stm.setString(4, description);
            stm.setString(5, status);
            stm.setString(6, note);

            // Use executeUpdate for INSERT, UPDATE, DELETE statements
            int rowsInserted = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
    }

    public void setAllStatusPromotion(int promotionID) {
        String sql = "UPDATE Promotion SET Status = '0' WHERE PromotionID != ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);

            // Execute the update
            int rowsUpdated = stm.executeUpdate();
            System.out.println(rowsUpdated + " rows updated to status 0.");
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
    }

    public void addProductToPromotion(int promotionId, int productID, int discountRate, int size) {
        String sql = "Insert into DiscountedProducts (ProductID, PromotionID, DiscountRate, sizeID) values (?, ?, ?, ?)";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, productID);
            stm.setInt(2, promotionId);
            stm.setInt(3, discountRate);
            stm.setInt(4, size);
            // Use executeUpdate for INSERT, UPDATE, DELETE statements
            int rowsInserted = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
    }

    public Promotion getPromotionByPromotionID(int promotionID) {
        String sql = "Select * from Promotion where PromotionID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Promotion(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6),
                        rs.getString(7));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }

        return null;
    }

    public List<DiscountedProducts> getDiscountedProductsByPromotionID(int promotionID) {
        List<DiscountedProducts> list = new ArrayList<>();
        String sql = "select * from DiscountedProducts\n"
                + " where PromotionID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new DiscountedProducts(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<DiscountedProducts> getDiscountedProductsByPromotionIDAndProductID(int promotionID, int productID) {
        List<DiscountedProducts> list = new ArrayList<>();
        String sql = "select * from DiscountedProducts\n"
                + " where PromotionID = ? and productID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            stm.setInt(2, productID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new DiscountedProducts(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<DiscountedProducts> getUniqueDiscountedProductsByPromotionID(int promotionID) {
        List<DiscountedProducts> list = new ArrayList<>();
        Set<Integer> uniqueProductIds = new HashSet<>();
        String sql = "SELECT * FROM DiscountedProducts WHERE PromotionID = ? ORDER BY ProductID";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, promotionID);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("ProductID"); // replace with actual column name

                    // Only add if this productID hasn't been added before
                    if (!uniqueProductIds.contains(productId)) {
                        int sizeId = rs.getInt("SizeID");       // replace with actual column name
                        int discountRate = rs.getInt("DiscountRate"); // replace with actual column name
                        int promotionId = rs.getInt("PromotionID");   // replace with actual column name

                        list.add(new DiscountedProducts(productId, sizeId, discountRate, promotionId));
                        uniqueProductIds.add(productId); // Mark this productID as added
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public boolean DeletePromotionByProID(int proId) {
        String sql = "Delete from Promotion where PromotionID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, proId);

            // Use executeUpdate for INSERT, UPDATE, DELETE statements
            int rowsInserted = stm.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public List<Product_Attribute_Stock> getAllProductAttributeStock() {
        List<Product_Attribute_Stock> list = new ArrayList<>();
        String sql = "select * from Product_Attribute_Stock";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Product_Attribute_Stock(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<Integer> getAllSizeOfProduct(int productID) {
        List<Integer> list = new ArrayList<>();
        String sql = "select * from Product_Attribute_Stock\n"
                + "where productID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, productID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public boolean updatePromotion(Promotion promotion) {
        String sql = "Update Promotion set Name = ?, StartDate = ?, EndDate = ?, Description = ?, Status = ?, Note = ? where PromotionID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, promotion.getName()); // Assuming Name is a String
            stm.setString(2, promotion.getStartDate()); // Assuming StartDate is a String (formatted as 'YYYY-MM-DD')
            stm.setString(3, promotion.getEndDate()); // Assuming EndDate is a String (formatted as 'YYYY-MM-DD')
            stm.setString(4, promotion.getDescription()); // Assuming Description is a String
            stm.setInt(5, promotion.getStatus()); // Assuming Status is an int (0 for inactive, 1 for active)
            stm.setString(6, promotion.getNote()); // Assuming Note is a String
            stm.setInt(7, promotion.getPromotionID()); // Assuming ID is an int to specify which promotion to update
            int rowUpdated = stm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public boolean UpdateDiscountRate(int promotionID, int productID, int discountRate) {
        String sql = "  Update DiscountedProducts\n"
                + "  set DiscountRate = ?\n"
                + "  where promotionID = ? and productID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, discountRate);
            stm.setInt(2, promotionID);
            stm.setInt(3, productID);
            int rowUpdated = stm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public boolean UpdateDiscountRateSize(int promotionID, int productID, int discountRate, int size) {
        String sql = "  Update DiscountedProducts\n"
                + "  set DiscountRate = ?\n"
                + "  where promotionID = ? and productID = ? and sizeID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, discountRate);
            stm.setInt(2, promotionID);
            stm.setInt(3, productID);
            stm.setInt(4, size);
            int rowUpdated = stm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public boolean deleteDiscountedProduct(int productID, int promotionID) {
        String sql = "Delete from DiscountedProducts where promotionID = ? and productID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            stm.setInt(2, productID);
            int rowUpdated = stm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public boolean deleteDiscountedProductWithSize(int productID, int promotionID, int sizeID) {
        String sql = "Delete from DiscountedProducts where promotionID = ? and productID = ? and sizeID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            stm.setInt(2, productID);
            stm.setInt(3, sizeID);
            int rowUpdated = stm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return false;
    }

    public List<Products> getProductForAddToPromotion(int promotionID) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT *\n"
                + "FROM Products p\n"
                + "WHERE p.productID NOT IN (\n"
                + "    SELECT dp.productID \n"
                + "    FROM DiscountedProducts dp \n"
                + "    WHERE dp.PromotionID = ?\n"
                + ")";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, promotionID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Products c = new Products(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price"),
                        rs.getInt("catID"),
                        rs.getInt("brandID"),
                        rs.getString("briefInfo"),
                        rs.getString("description"),
                        rs.getDate("createdAt"),
                        rs.getInt("quantity"),
                        rs.getInt("status"),
                        rs.getInt("featureStatus")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public List<Products> getComingSoonProduct() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * \n"
                + "            FROM Products p \n"
                + "           WHERE NOT EXISTS (\n"
                + "                 SELECT 1\n"
                + "              FROM Product_Attribute_Stock pas \n"
                + "               WHERE pas.productID = p.productID\n"
                + "               );";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Products c = new Products(rs.getInt("productID"),
                        rs.getString("productName"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price"),
                        rs.getInt("catID"),
                        rs.getInt("brandID"),
                        rs.getString("briefInfo"),
                        rs.getString("description"),
                        rs.getDate("createdAt"),
                        rs.getInt("quantity"),
                        rs.getInt("status"),
                        rs.getInt("featureStatus")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return list;
    }

    public int getLastPromotionID() {
        String sql = "select top 1 PromotionID from Promotion\n"
                + "order by PromotionID desc";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging purposes
        }
        return -1;
    }

    public static void main(String[] args) {
        PromotionDAO pd = new PromotionDAO();
        List<DiscountedProducts> list = pd.getUniqueDiscountedProductsByPromotionID(7);
        for (int i = 0; i < list.size(); i++) {
            DiscountedProducts get = list.get(i);
            System.out.println(get.getProductID());
        }
    }
}
