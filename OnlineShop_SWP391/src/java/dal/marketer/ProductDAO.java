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
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Blog;
import model.Category;
import model.ProductImage;
import model.Product_Attribute_Stock;
import model.Products;

/**
 *
 * @author Acer
 */
public class ProductDAO extends DBContext {

    //doc tat ca bang categories :
    public List<Products> getAllProducts() {
        List<Products> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT * FROM Products  ";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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
            System.err.println(e);
        }
        return list;
    }

    //Lay ra anh cua san pham
    public List<ProductImage> getAllProductImage() {
        List<ProductImage> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT TOP (1000) [productImgID]\n"
                + "      ,[productImgUrl]\n"
                + "      ,[productID]\n"
                + "  FROM ProductImage";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductImage c = new ProductImage(
                        rs.getInt("productImgID"),
                        rs.getString("productImgUrl"),
                        rs.getInt("productID")
                );

                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return list;
    }

    // Phương thức để lấy danh sách sản phẩm "coming soon"
    public List<Products> getComingSoonProducts() {
        List<Products> comingSoonProducts = new ArrayList<>();
        String sql = "SELECT top 10 * \n"
                + "                FROM Products p \n"
                + "                WHERE  NOT EXISTS (\n"
                + "                    SELECT 1 \n"
                + "                    FROM Product_Attribute_Stock pas \n"
                + "                    WHERE pas.productID = p.productID\n"
                + "                );";

        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

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

                comingSoonProducts.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }

        return comingSoonProducts;
    }

    //Lay ra 10 san pham moi nhat
    public List<Products> getLatestProducts() {
        List<Products> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT TOP 10 *\n"
                + "FROM Products p\n"
                + "WHERE p.status = 1\n" // Di chuyển điều kiện status vào phần chính
                + "AND EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Product_Attribute_Stock pas\n"
                + "    WHERE pas.productID = p.productID\n"
                + ")\n"
                + "ORDER BY p.createdAt DESC;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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
            System.err.println(e);
        }
        return list;
    }

    public List<Products> get3LatestProducts() {
        List<Products> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT TOP 3 *\n"
                + "FROM Products p\n"
                + "WHERE p.status = 1\n" // Di chuyển điều kiện status vào phần chính
                + "AND EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Product_Attribute_Stock pas\n"
                + "    WHERE pas.productID = p.productID\n"
                + ")\n"
                + "ORDER BY p.createdAt DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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
            System.err.println(e);
        }
        return list;
    }

    public List<Products> get1LatestProducts() {
        List<Products> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT top 1 * \n"
                + "FROM products \n"
                + "ORDER BY createdAt DESC where status = 1 ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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
            System.err.println(e);
        }
        return list;
    }

    public List<Products> getFeaturedProducts() {
        List<Products> list = new ArrayList<>();
        //Lenh sql: select * from category
        String sql = "SELECT TOP 10 *\n"
                + "FROM Products p\n"
                + "WHERE status = 1 and featureStatus = 1\n"
                + "AND EXISTS (\n"
                + "    SELECT 1\n"
                + "    FROM Product_Attribute_Stock pas\n"
                + "    WHERE pas.productID = p.productID\n"
                + ")\n"
                + "ORDER BY p.createdAt DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
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
            System.err.println(e);
        }
        return list;
    }

    public Products getProductById(int productID) {
        Products c = new Products();
        String sql = "select *\n"
                + "from Products\n"
                + "where Products.productID = ?  ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Products(rs.getInt("productID"),
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
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return c;
    }

    public List<Products> getProductsByFilter(int[] catID, int[] brandID, List<int[]> priceRanges) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1 and  status = 1 ");

        if (catID != null && catID.length > 0) {
            sql.append(" AND catID IN (");
            for (int i = 0; i < catID.length; i++) {
                sql.append(catID[i]).append(",");
            }
            sql.setLength(sql.length() - 1); // Remove last comma
            sql.append(")");
        }

        if (brandID != null && brandID.length > 0) {
            sql.append(" AND brandID IN (");
            for (int i = 0; i < brandID.length; i++) {
                sql.append(brandID[i]).append(",");
            }
            sql.setLength(sql.length() - 1); // Remove last comma
            sql.append(")");
        }

        // Add conditions for price ranges
        if (!priceRanges.isEmpty()) {
            sql.append(" AND (");
            for (int i = 0; i < priceRanges.size(); i++) {
                int[] range = priceRanges.get(i);
                sql.append("price BETWEEN ").append(range[0]).append(" AND ").append(range[1]);

                if (i < priceRanges.size() - 1) {
                    sql.append(" OR "); // Use OR between multiple price ranges
                }
            }
            sql.append(")");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ResultSet rs = ps.executeQuery();

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
            e.printStackTrace();
        }
        return list;
    }

    public List<Products> getFilteredProductManagement(String category, String brand, String status) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE 1=1  ");

        // List to store parameters
        List<Object> parameters = new ArrayList<>();

        // Add filters based on provided parameters
        if (category != null && !category.isEmpty()) {
            sql.append(" AND catID = ?");
            parameters.add(Integer.parseInt(category)); // Assuming category is the ID
        }
        if (brand != null && !brand.isEmpty()) {
            sql.append(" AND brandID = ?");
            parameters.add(Integer.parseInt(brand));
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            parameters.add(Integer.parseInt(status));
        }

        try {
            PreparedStatement stm = connection.prepareStatement(sql.toString());

            // Set parameters in PreparedStatement
            for (int i = 0; i < parameters.size(); i++) {
                stm.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Products(rs.getInt("productID"),
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
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }

        return list;
    }

    public int getTotalProducts() {
        String sql = "select count(*) from Products where status = 1 ";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }

    public List<Products> pagingProducts(int index, int catID, int brandID) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products p WHERE 1=1 and status = 1 ");

        // Append conditions based on provided catID and brandID
        // Assuming that 0 means "no filter"
        if (catID > 0) { // Filter by catID only if it's greater than 0
            sql.append(" AND p.catID = ?");
        }
        if (brandID > 0) { // Filter by brandID only if it's greater than 0
            sql.append(" AND p.brandID = ?");
        }

        // Add a condition to exclude "Coming Soon" products
        sql.append(" AND EXISTS (SELECT 1 FROM Product_Attribute_Stock pas WHERE pas.productID = p.productID)");

        sql.append(" ORDER BY p.createdAt DESC OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;");

        try {
            PreparedStatement stm = connection.prepareStatement(sql.toString());

            int paramIndex = 1;

            // Set the parameters for catID and brandID if they are greater than 0
            if (catID > 0) {
                stm.setInt(paramIndex++, catID);
            }
            if (brandID > 0) {
                stm.setInt(paramIndex++, brandID);
            }

            // Set the index for pagination
            stm.setInt(paramIndex++, (index - 1) * 10);

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

    public int getTotalProductsByCatAndBrand(int catID, int brandID) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1 and status = 1 ");

        // Append conditions based on catID and brandID
        if (catID > 0) {
            sql.append(" AND catID = ?");
        }
        if (brandID > 0) {
            sql.append(" AND brandID = ?");
        }

        try (PreparedStatement stm = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            // Set parameters for catID and brandID
            if (catID > 0) {
                stm.setInt(paramIndex++, catID);
            }
            if (brandID > 0) {
                stm.setInt(paramIndex++, brandID);
            }

            // Execute query and get the count
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1); // Get the count from the result set
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log exception for debugging
        }
        return count; // Return the total count
    }

    public List<Products> getProductsByFilterByPaging(int[] catID, int[] brandID, List<int[]> priceRanges, int index) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products p WHERE 1=1 and status = 1 ");

        // Thêm điều kiện lọc cho danh mục (catID)
        if (catID != null && catID.length > 0) {
            sql.append(" AND p.catID IN (");
            for (int i = 0; i < catID.length; i++) {
                sql.append("?").append(",");
            }
            sql.setLength(sql.length() - 1); // Xóa dấu phẩy cuối cùng
            sql.append(")");
        }

        // Thêm điều kiện lọc cho thương hiệu (brandID)
        if (brandID != null && brandID.length > 0) {
            sql.append(" AND p.brandID IN (");
            for (int i = 0; i < brandID.length; i++) {
                sql.append("?").append(",");
            }
            sql.setLength(sql.length() - 1); // Xóa dấu phẩy cuối cùng
            sql.append(")");
        }

        // Thêm điều kiện cho khoảng giá
        if (priceRanges != null && !priceRanges.isEmpty()) {
            sql.append(" AND (");
            for (int i = 0; i < priceRanges.size(); i++) {
                int[] range = priceRanges.get(i);
                sql.append("p.price BETWEEN ? AND ?");

                if (i < priceRanges.size() - 1) {
                    sql.append(" OR "); // Sử dụng OR giữa các khoảng giá
                }
            }
            sql.append(")");
        }

        // Thêm điều kiện để loại trừ sản phẩm "Coming Soon"
        sql.append(" AND EXISTS (SELECT 1 FROM Product_Attribute_Stock pas WHERE pas.productID = p.productID)");

        // Thêm điều kiện phân trang
        sql.append(" ORDER BY p.createdAt DESC OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;"); // Lấy 10 sản phẩm mỗi trang

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());

            int paramIndex = 1;

            // Thiết lập tham số cho catID
            if (catID != null && catID.length > 0) {
                for (Integer id : catID) {
                    ps.setInt(paramIndex++, id);
                }
            }

            // Thiết lập tham số cho brandID
            if (brandID != null && brandID.length > 0) {
                for (Integer id : brandID) {
                    ps.setInt(paramIndex++, id);
                }
            }

            // Thiết lập tham số cho khoảng giá
            if (priceRanges != null && !priceRanges.isEmpty()) {
                for (int[] range : priceRanges) {
                    ps.setInt(paramIndex++, range[0]);
                    ps.setInt(paramIndex++, range[1]);
                }
            }

            // Thiết lập chỉ số phân trang
            ps.setInt(paramIndex++, (index - 1) * 10); // Thiết lập chỉ số phân trang

            ResultSet rs = ps.executeQuery();

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
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalProductsByFilter(int[] catID, int[] brandID, List<int[]> priceRanges) {
        int total = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE 1=1 and  status = 1 ");

        // Thêm điều kiện lọc cho danh mục (catID)
        if (catID != null && catID.length > 0) {
            sql.append(" AND catID IN (");
            for (int i = 0; i < catID.length; i++) {
                sql.append(catID[i]).append(",");
            }
            sql.setLength(sql.length() - 1); // Xóa dấu phẩy cuối cùng
            sql.append(")");
        }

        // Thêm điều kiện lọc cho thương hiệu (brandID)
        if (brandID != null && brandID.length > 0) {
            sql.append(" AND brandID IN (");
            for (int i = 0; i < brandID.length; i++) {
                sql.append(brandID[i]).append(",");
            }
            sql.setLength(sql.length() - 1); // Xóa dấu phẩy cuối cùng
            sql.append(")");
        }

        // Thêm điều kiện cho khoảng giá
        if (!priceRanges.isEmpty()) {
            sql.append(" AND (");
            for (int i = 0; i < priceRanges.size(); i++) {
                int[] range = priceRanges.get(i);
                sql.append("price BETWEEN ").append(range[0]).append(" AND ").append(range[1]);

                if (i < priceRanges.size() - 1) {
                    sql.append(" OR "); // Sử dụng OR giữa các khoảng giá
                }
            }
            sql.append(")");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Lấy tổng số lượng sản phẩm
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Products> getProductsBySearch(int catID, String name) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE 1=1 and status = 1 "; // Base query

        // Add conditions based on inputs
        if (catID != 0) {
            sql += " AND catID = ?";
        }
        if (name != null && !name.isEmpty()) {
            sql += " AND productName LIKE ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1; // To track the parameter index for PreparedStatement

            // Set parameters based on input
            if (catID != 0) {
                ps.setInt(paramIndex++, catID); // Set category ID
            }
            if (name != null && !name.isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%"); // Set product name
            }

            ResultSet rs = ps.executeQuery();
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
            System.out.println(e);
        }
        return list;
    }

    public List<Products> getProductsByCatIDAndNamePage(int catID, String name, int page) {
        List<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products p WHERE 1=1 and status = 1 ");

        // Nếu tên không trống, thêm điều kiện tìm kiếm
        if (name != null && !name.isEmpty()) {
            sql.append(" AND p.productName LIKE ?");
        }

        // Nếu catID khác 0, thêm điều kiện lọc theo danh mục
        if (catID != 0) {
            sql.append(" AND p.catID = ?");
        }

        // Thêm điều kiện để loại trừ sản phẩm "Coming Soon"
        sql.append(" AND EXISTS (SELECT 1 FROM Product_Attribute_Stock pas WHERE pas.productID = p.productID)");

        // Sắp xếp và phân trang
        sql.append(" ORDER BY p.createdAt DESC ")
                .append(" OFFSET ? ROWS ")
                .append(" FETCH NEXT 10 ROWS ONLY"); // Đảm bảo SQL này hợp lệ cho DBMS của bạn

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int paramIndex = 1; // Để theo dõi chỉ số tham số

            // Thiết lập tham số dựa trên đầu vào
            if (name != null && !name.isEmpty()) {
                // Loại bỏ khoảng trắng từ tên và tìm kiếm
                String processedName = name.replace(" ", ""); // Bỏ khoảng trắng
                ps.setString(paramIndex++, "%" + processedName + "%"); // Thiết lập tên sản phẩm
            }

            if (catID != 0) {
                ps.setInt(paramIndex++, catID); // Thiết lập ID danh mục
            }

            ps.setInt(paramIndex++, (page - 1) * 10); // Thiết lập độ lệch phân trang

            ResultSet rs = ps.executeQuery();
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
            e.printStackTrace(); // In lỗi ra console
        }
        return list;
    }

    public Products getProductByAfterID(int id) {

        String sql = "select * from Products"
                + " where 1=1 and status = 1 ";
        if (id != 0) {
            sql += " and productID=" + (id + 1);
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            //ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
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
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Products getProductByPreID(int id) {

        String sql = "select * from Products"
                + " where 1=1 and status = 1 ";
        if (id != 0) {
            sql += " and productID=" + (id - 1);
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            //ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
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

                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Products getProductByID(int id) {

        String sql = "select * from Products"
                + " where 1=1  ";
        if (id != 0) {
            sql += " and productID=" + id;
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            //ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
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

                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Products> getProductsByCatID(int catID) {
        List<Products> list = new ArrayList<>();
        String sql = "select * from Products"
                + " where 1=1  ";
        if (catID != 0) {
            sql += " and catID=" + catID;

        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
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
            System.out.println(e);
        }
        return list;
    }

    public boolean updateProductStatus(int productID, int status) {
        String sql = "UPDATE Products SET status = ? WHERE productID = ? ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, productID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public int updateQuantityProduct(Products product) {
        int result = 0;
        String sql = "Update Products set quantity = ? where productID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setObject(1, product.getQuantity());
            ps.setObject(2, product.getProductID());
            result = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }

    public void addProduct(Products product, String productImgUrl) throws SQLException {
        String sql = "INSERT INTO Products (productName, importPrice, price, catID, brandID, briefInfo, description, createdAt, quantity, status, featureStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String idSql = "SELECT TOP 1 productID FROM Products ORDER BY productID DESC"; // Lấy productID lớn nhất

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, product.getProductName());
            ps.setFloat(2, product.getImportPrice());
            ps.setFloat(3, product.getPrice());
            ps.setInt(4, product.getCatID());
            ps.setInt(5, product.getBrandID());
            ps.setString(6, product.getBriefInfo());
            ps.setString(7, product.getDescription());
            ps.setTimestamp(8, new java.sql.Timestamp(product.getCreatedAt().getTime()));
            ps.setInt(9, product.getQuantity());
            ps.setInt(10, product.getStatus());
            ps.setInt(11, product.getFeatureStatus());

            // Thực hiện câu lệnh INSERT
            ps.executeUpdate();

            // Bây giờ lấy productID mới nhất
            try (PreparedStatement idPs = connection.prepareStatement(idSql); ResultSet generatedKeys = idPs.executeQuery()) {
                if (generatedKeys.next()) {
                    int productID = generatedKeys.getInt("productID"); // Lấy productID
                    System.out.println("Product added successfully with ID: " + productID);
                    // Gọi phương thức để thêm hình ảnh sản phẩm
                    addProductImage(productID, productImgUrl);
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error when adding product: " + e.getMessage());
        }
    }

// Thêm phương thức lưu ảnh vào bảng ProductImage
    public void addProductImage(int productID, String productImgUrl) {
        String sql = "INSERT INTO ProductImage (productImgUrl, productID) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productImgUrl);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("SQL Error when adding product image: " + e.getMessage());
        }
    }

    public boolean delete(int id) {
        String deleteProductAttributeStockSQL = "DELETE FROM Product_Attribute_Stock WHERE productID = ?";
        String deleteProductsSQL = "DELETE FROM Products WHERE productID = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction để đảm bảo cả hai lệnh thành công hoặc rollback

            try (PreparedStatement ps1 = connection.prepareStatement(deleteProductAttributeStockSQL); PreparedStatement ps2 = connection.prepareStatement(deleteProductsSQL)) {

                ps1.setInt(1, id);
                ps2.setInt(1, id);

                ps1.executeUpdate(); // Xóa trong Product_Attribute_Stock trước
                int rowsAffected = ps2.executeUpdate(); // Xóa trong Products

                connection.commit(); // Commit transaction nếu cả hai lệnh thành công

                return rowsAffected > 0;
            } catch (SQLException e) {
                connection.rollback(); // Rollback nếu xảy ra lỗi
                System.out.println("Error while deleting product: " + e.getMessage());
            }
        } catch (SQLException e) {
            System.out.println("Transaction error: " + e.getMessage());
        }
        return false;
    }

    // Phương thức lấy số lượng (quantity) của sản phẩm
    public int getProductQuantity(int productID) throws SQLException {
        String query = "SELECT quantity FROM Products WHERE productID = ?";
        int quantity = 0;

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error while getting product quantity: " + e.getMessage());
        }

        return quantity;
    }

    public void setShowOrHideForProduct(int status, int productID) {
        String sql = "UPDATE Products "
                + "SET Products.status = ? "
                + "WHERE productID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, status);
            stm.setInt(2, productID);
            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product status updated successfully.");
            } else {
                System.out.println("No product found with the given ID.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Products product, Map<Integer, Float> priceMap) {
        String sql = "UPDATE Products "
                + "SET productName = ?, catID = ?, brandID = ?, briefInfo = ?, description = ?, status = ?, featureStatus = ? "
                + "WHERE productID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setString(1, product.getProductName());
            stm.setInt(2, product.getCatID());
            stm.setInt(3, product.getBrandID());
            stm.setString(4, product.getBriefInfo());
            stm.setString(5, product.getDescription());
            stm.setInt(6, product.getStatus());
            stm.setInt(7, product.getFeatureStatus());
            stm.setInt(8, product.getProductID());

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product updated successfully.");
            } else {
                System.out.println("No product found with productID " + product.getProductID());
            }

            // Update prices in Product_Attribute_Stock
            for (Map.Entry<Integer, Float> entry : priceMap.entrySet()) {
                int sizeID = entry.getKey();
                float price = entry.getValue();
                updatePriceInStock(product.getProductID(), sizeID, price);
            }

        } catch (SQLException e) {
            System.err.println("Error updating product: " + e.getMessage());
            e.printStackTrace(); // Xem chi tiết lỗi
        }
    }

    private void updatePriceInStock(int productID, int sizeID, float price) {
        String sql = "UPDATE Product_Attribute_Stock "
                + "SET price = ? "
                + "WHERE productID = ? AND sizeID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setFloat(1, price);
            stm.setInt(2, productID);
            stm.setInt(3, sizeID);

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Price updated for productID " + productID + " and sizeID " + sizeID);
            } else {
                System.out.println("No price found for productID " + productID + " and sizeID " + sizeID);
            }
        } catch (SQLException e) {
            System.err.println("Error updating price in stock: " + e.getMessage());
            e.printStackTrace(); // Xem chi tiết lỗi
        }
    }

// Method to update the product image URL
    public void updateProductImage(int productID, String productImgUrl) throws SQLException {
        String sql = "UPDATE ProductImage SET productImgUrl = ? WHERE productID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productImgUrl);
            ps.setInt(2, productID);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product image updated successfully.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error when updating product image: " + e.getMessage());
            throw e; // Rethrow the exception for higher-level handling
        }
    }

    public void updateSubImage(int subImgID, String subImageUrl) throws SQLException {
        String sql = "UPDATE SubImage SET imgUrl = ? WHERE subImgID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, subImageUrl);
            ps.setInt(2, subImgID);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Sub-image updated successfully.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error when updating sub-image: " + e.getMessage());
            throw e;
        }
    }

    public void addSubImage(String subImageUrl, int productID) throws SQLException {
        String sql = "INSERT INTO SubImage (imgUrl, productID) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, subImageUrl);
            ps.setInt(2, productID);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("SQL Error when adding sub-image: " + e.getMessage());
            throw e;
        }
    }

    public boolean deleteSubImage(int subImgID) throws SQLException {
        String sql = "DELETE FROM SubImage WHERE subImgID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, subImgID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng bị ảnh hưởng
        } catch (SQLException e) {
            System.out.println("SQL Error when deleting sub-image: " + e.getMessage());
            throw e;
        }
    }

    // Method to update the import price of a product
    public boolean updateImportPriceAndStock(int productID, double importPrice, int stock) {
        String sql = "UPDATE [dbo].[Products] SET [importPrice] = ?, [quantity] = ? WHERE [productID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setDouble(1, importPrice); // Set the import price
            ps.setInt(2, stock);           // Set the stock
            ps.setInt(3, productID);       // Set the product ID

            int rowsAffected = ps.executeUpdate(); // Execute the update
            return rowsAffected > 0; // Return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception (consider logging)
            return false; // Return false if there was an error
        }
    }

    public List<Product_Attribute_Stock> getListProductAttribute() {
        List<Product_Attribute_Stock> listProductAttribute = new ArrayList<>();
        String sql = "select *\n"
                + "from Product_Attribute_Stock";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int stock = resultSet.getInt("stock");
                int hold = resultSet.getInt("hold");
                float importPrice = resultSet.getFloat("importPrice");
                float price = resultSet.getFloat("price");
                Product_Attribute_Stock pas = new Product_Attribute_Stock(productID, sizeID, stock, hold, importPrice, price);
                listProductAttribute.add(pas);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return listProductAttribute;
    }

    public List<Products> getTopBestSellingProducts() {
        List<Products> listProduct = new ArrayList<>();
        String sql = "SELECT TOP 10 p.productID,p.productName,p.importPrice,p.brandID,p.catID, p.price, p.briefInfo, \n"
                + "p.description, p.createdAt, p.quantity, p.status, p.featureStatus  , COUNT(*) AS purchase_count\n"
                + "FROM Products p\n"
                + "JOIN OrderDetail od ON p.productID = od.productID\n"
                + "JOIN Orders o ON o.orderID = od.orderID\n"
                + "WHERE o.statusID = 7\n"
                + "GROUP BY p.productID,p.productName,p.importPrice,p.brandID,p.catID, p.price, p.briefInfo, \n"
                + "p.description, p.createdAt, p.quantity, p.status, p.featureStatus\n"
                + "ORDER BY purchase_count DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products product = new Products(rs.getInt("productID"),
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
                listProduct.add(product);
            }
        } catch (SQLException e) {
            System.err.println(e);
        }
        return listProduct;

    }

    public static void main(String[] args) {
        int productID = 59;
        ProductDAO pd = new ProductDAO();
        System.out.println(pd.getProductByID(productID).getProductName());
    }

}
