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
import model.Product_Attribute_Stock;
import model.Size;

/**
 *
 * @author Acer
 */
public class SizeDAO extends DBContext {

    // In the DAO class
    public List<Size> getAllSize() {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM Size";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size c = new Size(
                        rs.getInt("sizeID"),
                        rs.getString("sizeName"),
                        rs.getInt("status"),
                        rs.getInt("attributeID"),
                        rs.getInt("catID"),
                        rs.getString("description")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }
    
    public List<Size> getAllSizesByCatID(int catID) {
        List<Size> allSizes = new ArrayList<>();

        // SQL to retrieve sizes based on catID
        String sizesSQL = "SELECT * FROM Size WHERE catID = ? and status = 1 ";
        try (PreparedStatement ps = connection.prepareStatement(sizesSQL)) {
            ps.setInt(1, catID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size size = new Size(
                        rs.getInt("sizeID"),
                        rs.getString("sizeName"),
                        rs.getInt("status"),
                        rs.getInt("attributeID"),
                        rs.getInt("catID"),
                        rs.getString("description")
                );
                allSizes.add(size);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return allSizes;
    }

    // Method to get sizes by attributeID (e.g., 1 for racket sizes, 3 for shoe sizes)
    public List<Size> getSizesByAttributeID(int attributeID) {
        List<Size> list = new ArrayList<>();
        String sql = "SELECT * FROM Size WHERE attributeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, attributeID); // Set the attributeID parameter
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size c = new Size(
                        rs.getInt("sizeID"),
                        rs.getString("sizeName"),
                        rs.getInt("status"),
                        rs.getInt("attributeID"),
                        rs.getInt("catID"),
                        rs.getString("description")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    public List<Size> getAllSizesByProductID(int productID) {
        List<Size> allSizes = new ArrayList<>();

        // Bước 1: Lấy catID từ bảng sản phẩm
        int catID = 0;
        String catIDSQL = "SELECT catID FROM Products WHERE productID = ?";
        try (PreparedStatement ps = connection.prepareStatement(catIDSQL)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                catID = rs.getInt("catID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Bước 2: Xác định attributeID dựa trên catID
        int attributeID = 0; // Mặc định là 0 (không có attributeID)
        if (catID == 1) {
            attributeID = 1; // Vợt
        } else if (catID == 3) {
            attributeID = 3; // Giày
        } else if (catID == 4) {
            attributeID = 2; // Quần áo
        }

        // Bước 3: Lấy tất cả kích thước dựa trên attributeID
        if (attributeID > 0) {
            String sizesSQL = "SELECT * FROM Size WHERE attributeID = ?";
            try (PreparedStatement ps = connection.prepareStatement(sizesSQL)) {
                ps.setInt(1, attributeID);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Size c = new Size(
                            rs.getInt("sizeID"),
                            rs.getString("sizeName"),
                            rs.getInt("status"),
                            rs.getInt("attributeID"),
                            rs.getInt("catID"),
                            rs.getString("description")
                    );

                    allSizes.add(c);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Nếu không tìm thấy kích thước, có thể trả về một kích thước mặc định hoặc danh sách trống
        if (allSizes.isEmpty()) {
            Size defaultSize = new Size();
            defaultSize.setSizeID(0); // Không có kích thước
            defaultSize.setSizeName("No Size Available");
            defaultSize.setStatus(0);
            defaultSize.setAttributeID(0);
            allSizes.add(defaultSize);
        }

        return allSizes;
    }

    public int insertNewSize(int sizeID, String sizeName, int status, int attributeID, int catID, String description) {
        String sql = "INSERT INTO [dbo].[Size] ([sizeID], [sizeName], [status], [attributeID], [catID], [description]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {

            // Set parameters
            statement.setInt(1, sizeID);
            statement.setString(2, sizeName);
            statement.setInt(3, status);
            statement.setInt(4, attributeID);
            statement.setInt(5, catID);
            statement.setString(6, description);

            // Execute the insert operation
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new size was inserted successfully!");
                return sizeID; // Return the sizeID of the newly inserted size
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception occurred while inserting new size: " + e.getMessage());
            // Handle exception (logging, rethrowing, etc.)
        }
        return -1; // Return -1 to indicate failure
    }

    public int generateNewSizeID() {
        String sql = "SELECT ISNULL(MAX(sizeID), 0) + 1 FROM [dbo].[Size]";
        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1); // Return the next available sizeID
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception occurred while generating new sizeID: " + e.getMessage());
        }
        return -1; // Return -1 to indicate failure
    }

    public void insertNewSizesAndPrices(int productID, List<Integer> sizeIDs, List<Integer> stocks, List<Float> importPrices) {
        // Validate input lists
        if (sizeIDs.size() != stocks.size() || stocks.size() != importPrices.size()) {
            throw new IllegalArgumentException("Size IDs, stocks, and import prices must have the same length.");
        }

        // SQL for inserting new sizes and prices
        String sql = "INSERT INTO Product_Attribute_Stock (productID, sizeID, stock, importPrice, hold) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement insertStmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < sizeIDs.size(); i++) {
                int sizeID = sizeIDs.get(i);
                int stock = stocks.get(i);
                float importPrice = importPrices.get(i);

                // First, check if the record already exists
                if (sizeIDExists(sizeID, productID)) {
                    System.out.println("Record already exists for Product ID " + productID + " and Size ID " + sizeID);
                    continue; // Skip inserting if the record exists
                }

                // Set parameters for the insert statement
                insertStmt.setInt(1, productID);
                insertStmt.setInt(2, sizeID);
                insertStmt.setInt(3, stock);
                insertStmt.setFloat(4, importPrice);
                insertStmt.setInt(5, 0); // Assuming hold is always 0

                // Add the insert statement to the batch
                insertStmt.addBatch();
            }

            // Execute the batch
            insertStmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
    }

// Utility method to check if sizeID exists (modify as needed)
    private boolean sizeIDExists(int sizeID, int productID) {
        String sql = "SELECT COUNT(*) FROM Product_Attribute_Stock WHERE productID = ? AND sizeID = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(sql)) {
            checkStmt.setInt(1, productID);
            checkStmt.setInt(2, sizeID);
            ResultSet rs = checkStmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Size> getMinPriceSizes() {
        List<Size> minPriceSizes = new ArrayList<>();
        String sql = "WITH MinPriceSizes AS ( "
                + "    SELECT "
                + "        pas.productID, "
                + "        s.sizeID, "
                + "        s.sizeName, "
                + "        s.status, "
                + "        s.attributeID, "
                + "        s.catID, "
                + "        s.description, "
                + "        pas.importPrice, " // Thêm trường importPrice
                + "        pas.price, " // Thêm trường price
                + "        ROW_NUMBER() OVER (PARTITION BY pas.productID ORDER BY pas.price ASC) AS rn "
                + "    FROM "
                + "        Product_Attribute_Stock pas "
                + "    INNER JOIN "
                + "        Size s ON pas.sizeID = s.sizeID "
                + "    WHERE "
                + "        pas.stock > 0 AND s.status = 1 "
                + ") "
                + "SELECT productID, sizeID, sizeName, status, attributeID, catID, description, "
                + "       importPrice, price " // Thêm các trường importPrice và price vào phần chọn
                + "FROM MinPriceSizes "
                + "WHERE rn = 1";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size size = new Size(
                        rs.getInt("productID"),
                        rs.getInt("sizeID"),
                        rs.getString("sizeName"),
                        rs.getInt("status"),
                        rs.getInt("attributeID"),
                        rs.getInt("catID"),
                        rs.getString("description"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price")
                );
                minPriceSizes.add(size);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving minimum price sizes: " + e.getMessage());
        }
        return minPriceSizes;
    }

    public List<Size> getMinImportPrices() {
        List<Size> minImportPrices = new ArrayList<>();
        String sql = "WITH MinImportPrices AS ( "
                + "    SELECT "
                + "        pas.productID, "
                + "        s.sizeID, "
                + "        s.sizeName, "
                + "        s.status, "
                + "        s.attributeID, "
                + "        s.catID, "
                + "        s.description, "
                + "        pas.importPrice, " // Thêm trường importPrice
                + "        pas.price, " // Thêm trường price
                + "        ROW_NUMBER() OVER (PARTITION BY pas.productID ORDER BY pas.importPrice ASC) AS rn "
                + "    FROM "
                + "        Product_Attribute_Stock pas "
                + "    INNER JOIN "
                + "        Size s ON pas.sizeID = s.sizeID "
                + "    WHERE "
                + "        pas.stock > 0 AND s.status = 1 "
                + ") "
                + "SELECT productID, sizeID, sizeName, status, attributeID, catID, description, "
                + "       importPrice, price " // Thêm các trường importPrice và price vào phần chọn
                + "FROM MinImportPrices "
                + "WHERE rn = 1";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Size size = new Size(
                        rs.getInt("productID"),
                        rs.getInt("sizeID"),
                        rs.getString("sizeName"),
                        rs.getInt("status"),
                        rs.getInt("attributeID"),
                        rs.getInt("catID"),
                        rs.getString("description"),
                        rs.getFloat("importPrice"),
                        rs.getFloat("price")
                );
                minImportPrices.add(size);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving minimum import prices: " + e.getMessage());
        }
        return minImportPrices;
    }

    public static void main(String[] args) {
        System.out.println(new SizeDAO().getAllSize());

    }

}
