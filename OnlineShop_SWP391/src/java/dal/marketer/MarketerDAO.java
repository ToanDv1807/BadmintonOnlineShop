/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.marketer;

import dal.db.DBContext;
import com.sun.net.httpserver.Authenticator;
import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Address;
import model.Blog;
import model.BlogSubtitles;
import model.Customers;
import model.Employees;
import model.Feedback;
import model.Order;
import model.OrderDetail;
import model.Products;
import model.Slider;
import model.customer_change_history;

/**
 *
 * @author LENNOVO
 */
public class MarketerDAO extends DBContext {

    public Employees getEmployeeByEmail(String email) {
        String sql = "select * from Employees\n"
                + "where email like ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Employees(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7));
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public List<Customers> getCustomersByCreatedDate(String startDate, String endDate) {
        List<Customers> list = new ArrayList<>();
        String sql = "select * from Customers\n"
                + "where createdDate between ? and ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Customers(rs.getInt(1),
                        rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7),
                        rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getString(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Products> getProductsByCreatedDate(String startDate, String endDate) {
        List<Products> list = new ArrayList<>();
        String sql = "select * from Products\n"
                + "where createdAt between ? and ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
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
        }
        return list;
    }

    public List<Blog> getBlogsByCreatedDate(String startDate, String endDate) {
        List<Blog> list = new ArrayList<>();
        String sql = "select * from Blog\n"
                + "where createdDate between ? and ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8), rs.getInt(9), rs.getInt(10), rs.getInt(11)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Slider> getSlidersByCreatedDate(String startDate, String endDate) {
        List<Slider> list = new ArrayList<>();
        String sql = "select * from Sliders\n"
                + "where createdDate between ? and ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Slider(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getString(6),
                        rs.getString(7), rs.getString(8)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public Map<String, Integer> getNewCustomersLast7Days() {
        Map<String, Integer> newCustomersData = new HashMap<>();
        String sql = "WITH DateRange AS (\n"
                + "    -- Tạo chuỗi ngày từ 7 ngày trước đến ngày hiện tại\n"
                + "    SELECT CAST(GETDATE() AS DATE) AS created_day\n"
                + "    UNION ALL\n"
                + "    SELECT DATEADD(DAY, -1, created_day)\n"
                + "    FROM DateRange\n"
                + "    WHERE created_day > DATEADD(DAY, -7, GETDATE())\n"
                + ")\n"
                + "SELECT d.created_day, \n"
                + "       ISNULL(COUNT(c.createdDate), 0) AS new_customers\n"
                + "FROM DateRange d\n"
                + "LEFT JOIN Customers c \n"
                + "    ON CAST(c.createdDate AS DATE) = d.created_day\n"
                + "GROUP BY d.created_day\n"
                + "ORDER BY d.created_day";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                // Get the date and new customers count
                String createdDay = rs.getDate("created_day").toString(); // Get date as String
                int newCustomersCount = rs.getInt("new_customers");

                // Store in the HashMap
                newCustomersData.put(createdDay, newCustomersCount);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return newCustomersData;
    }

    public Map<String, Integer> getProductCountByCategory() {
        Map<String, Integer> productCountMap = new HashMap<>();
        String sql = "SELECT c.catName, COUNT(*) AS productCount \n"
                + "FROM Category c\n"
                + "JOIN Products p ON p.catID = c.catID\n"
                + "GROUP BY c.catName";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                String category = rs.getString(1);
                int count = rs.getInt(2);
                productCountMap.put(category, count);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return productCountMap;
    }

    public List<Employees> getAllEmployees() {
        List<Employees> list = new ArrayList<>();
        String sql = "select * from Employees";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                list.add(new Employees(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return list;
    }

    public List<Employees> getAllEmployeesIsMarketer() {
        List<Employees> list = new ArrayList<>();
        String sql = "select * from Employees\n"
                + "where roleID = 2";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                list.add(new Employees(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return list;
    }

    public List<Blog> getFilteredBlogs(String category, String author, String status, String searchTitle) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Blog WHERE 1=1");

        // List to store parameters
        List<Object> parameters = new ArrayList<>();

        // Add filters based on provided parameters
        if (category != null && !category.isEmpty()) {
            sql.append(" AND categoryID = ?");
            parameters.add(Integer.parseInt(category)); // Assuming category is the ID
        }
        if (author != null && !author.isEmpty()) {
            sql.append(" AND employeeID = ?");
            parameters.add(Integer.parseInt(author));
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            parameters.add(Integer.parseInt(status));
        }
        if (searchTitle != null && !searchTitle.isEmpty()) {
            sql.append(" AND title LIKE ?");
            parameters.add("%" + searchTitle + "%"); // Use LIKE for searching
        }

        try {
            PreparedStatement stm = connection.prepareStatement(sql.toString());

            // Set parameters in PreparedStatement
            for (int i = 0; i < parameters.size(); i++) {
                stm.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Blog(
                        rs.getInt(1), // Assuming the first column is ID
                        rs.getString(2), // Assuming the second column is title
                        rs.getString(3), // Assuming the third column is content
                        rs.getString(4), // Assuming the fourth column is author
                        rs.getString(5), // And so on...
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9),
                        rs.getInt(10),
                        rs.getInt(11)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }

        return list;
    }

    public boolean AddPost(Blog b) {
        String sql = "INSERT INTO Blog (blogID ,title, content, briefInfor, blogImgUrl, createdDate, updatedDate, categoryID, employeeID, status, featureStatus) VALUES (? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, b.getBlogId());
            stm.setString(2, b.getTitle());
            stm.setString(3, b.getContent());
            stm.setString(4, b.getBriefInfo());
            stm.setString(5, b.getBlogImgUrl());
            stm.setDate(6, java.sql.Date.valueOf(b.getCreatedDate())); // Assuming createdDate is of type LocalDate
            stm.setDate(7, java.sql.Date.valueOf(b.getUpdatedDate())); // Assuming updatedDate is of type LocalDate
            stm.setInt(8, b.getCategoryID());
            stm.setInt(9, b.getEmployeeID());
            stm.setInt(10, b.getStatus());
            stm.setInt(11, b.getFeatureStatus());

            int rowsAffected = stm.executeUpdate(); // Thực hiện cập nhật
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 hàng được chèn
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Log the exception for debugging
        }
    }

    public boolean AddSubtitle(BlogSubtitles bs) {
        String sql = "Insert into BlogSubtitles (subtitleID, blogID, subtitle, imgUrl, content)\n"
                + "values(?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, bs.getSubtitleID()); // Assuming subtitleID is an int
            stm.setInt(2, bs.getBlogID());     // Assuming blogID is an int
            stm.setString(3, bs.getSubtitle()); // Assuming subtitle is a String
            if (bs.getImgUrl() == null) {
                stm.setNull(4, java.sql.Types.VARCHAR);
            } else {
                stm.setString(4, bs.getImgUrl());
            }
            stm.setString(5, bs.getContent()); // Assuming content is a String

            int rowsAffected = stm.executeUpdate(); // Execute the insert operation
            return rowsAffected > 0; // Return true if at least one row is inserted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void SetShowOrHideForBlog(int status, int bid) {
        String sql = "update Blog\n"
                + "set Blog.status = ?\n"
                + "where blogID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, status);
            stm.setInt(2, bid);
            int rowsAffected = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updatePost(Blog blog) {
        String sql = "UPDATE Blog SET title = ?, content = ?, briefInfor = ?, blogImgUrl = ?, updatedDate = ?, categoryID = ?, employeeID = ?, status = ?, featureStatus = ? WHERE blogID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setString(1, blog.getTitle()); // Assuming title is a String
            stm.setString(2, blog.getContent()); // Assuming content is a String
            stm.setString(3, blog.getBriefInfo()); // Assuming briefInfo is a String
            stm.setString(4, blog.getBlogImgUrl()); // Assuming blogImgUrl is a String
            stm.setString(5, blog.getUpdatedDate()); // Assuming updatedDate is a String
            stm.setInt(6, blog.getCategoryID()); // Assuming categoryID is an int
            stm.setInt(7, blog.getEmployeeID()); // Assuming employeeID is an int
            stm.setInt(8, blog.getStatus()); // Assuming status is an int
            stm.setInt(9, blog.getFeatureStatus()); // Assuming featureStatus is an int
            stm.setInt(10, blog.getBlogId()); // Assuming blogID is an int and it's the unique identifier

            int rowsAffected = stm.executeUpdate(); // Execute the update operation
            return rowsAffected > 0; // Return true if at least one row is updated
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework for production
            return false;
        }
    }

    public boolean updateSubtitle(BlogSubtitles bs) {
        String sql = "Update BlogSubtitles set subtitleID = ?, blogID = ?, "
                + "subtitle = ?, imgUrl = ?, content = ?\n"
                + "where subtitleID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, bs.getSubtitleID());
            stm.setInt(2, bs.getBlogID());
            stm.setString(3, bs.getSubtitle());
            if (bs.getImgUrl() == null) {
                stm.setNull(4, java.sql.Types.VARCHAR);
            } else {
                stm.setString(4, bs.getImgUrl());
            }
            stm.setString(5, bs.getContent());
            stm.setInt(6, bs.getSubtitleID());
            int rowsAffected = stm.executeUpdate(); // Execute the update operation
            return rowsAffected > 0; // Return true if at least one row is updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteSubtitle(int id) {
        String sql = "DELETE FROM BlogSubtitles WHERE subtitleID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set the parameter for the PreparedStatement
            stm.setInt(1, id); // Chỉ định subtitleID cần xóa
            int rowsAffected = stm.executeUpdate(); // Thực hiện lệnh DELETE
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public boolean deleteAllSubtitleByBlogID(int blogId) {
        String sql = "DELETE FROM BlogSubtitles WHERE blogID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set the parameter for the PreparedStatement
            stm.setInt(1, blogId); // Chỉ định subtitleID cần xóa
            int rowsAffected = stm.executeUpdate(); // Thực hiện lệnh DELETE
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public boolean deleteBlogByBlogID(int blogId) {
        String sql = "DELETE FROM Blog WHERE blogID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set the parameter for the PreparedStatement
            stm.setInt(1, blogId); // Chỉ định subtitleID cần xóa
            int rowsAffected = stm.executeUpdate(); // Thực hiện lệnh DELETE
            return rowsAffected > 0; // Trả về true nếu có ít nhất 1 dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public List<Feedback> getAllFeedBacks(int index, String filterfr, String filterfp, String search) {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT f.feedbackID, f.customerID, c.fullName, c.email, c.phone, p.productName, \n"
                + "p.productID, f.rating, f.comment, f.status ,f.feedbackDate\n"
                + "FROM Feedback f \n"
                + "JOIN Customers c ON f.customerID = c.customerID \n"
                + "JOIN Products p ON f.productID = p.productID ";

        boolean hasWhereClause = false;

        // Add search condition if applicable
        if (search != null && !search.isEmpty()) {
            sql += "WHERE (c.fullName LIKE ? OR f.comment LIKE ?) ";
            hasWhereClause = true;
        }

        // Add filter by product name if applicable
        if (filterfp != null && !filterfp.isEmpty()) {
            sql += (hasWhereClause ? "AND " : "WHERE ") + "p.productName LIKE ? ";
            hasWhereClause = true;
        }

        // Add filter by rating star if applicable
        if (filterfr != null && !filterfr.isEmpty()) {
            sql += (hasWhereClause ? "AND " : "WHERE ") + "f.rating = ? ";
        }

        // Add sorting (optional, you can change the field based on your needs)
        sql += "ORDER BY f.feedbackID ";

        // Add pagination
        sql += "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Set search parameter if applicable
            if (search != null && !search.isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            // Set product name filter parameter if applicable
            if (filterfp != null && !filterfp.isEmpty()) {
                String productPattern = "%" + filterfp + "%";
                ps.setString(paramIndex++, productPattern);
            }

            // Set rating star filter parameter if applicable
            if (filterfr != null && !filterfr.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(filterfr));
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            // Set pagination parameter
            ps.setInt(paramIndex, (index - 1) * 10);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int fID = rs.getInt("feedbackID");
                int cID = rs.getInt("customerID");
                String name = rs.getString("fullName");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String pname = rs.getString("productName");
                String comment = rs.getString("comment");
                int pID = rs.getInt("productID");
                int rate = rs.getInt("rating");
                int status = rs.getInt("status");
                Date feedbackDate = rs.getDate("feedbackDate");
                String fDateStr = dateFormat.format(feedbackDate);
                // Add to feedback list
                list.add(new Feedback(fID, cID, name, email, phone, pname, pID, rate, comment, status, fDateStr));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions
        }
        return list;
    }

    public int countFeedback(String filterfr, String filterfp, String search) {
        String sql = "SELECT COUNT(*) FROM (SELECT f.feedbackID "
                + "FROM Feedback f "
                + "JOIN Customers c ON f.customerID = c.customerID "
                + "JOIN Products p ON f.productID = p.productID ";

        boolean hasWhereClause = false;

        // Add search condition if applicable
        if (search != null && !search.isEmpty()) {
            sql += "WHERE (c.fullName LIKE ? OR f.comment LIKE ?) ";
            hasWhereClause = true;
        }

        // Add product name filter if applicable
        if (filterfp != null && !filterfp.isEmpty()) {
            sql += (hasWhereClause ? "AND " : "WHERE ") + "p.productName LIKE ? ";
            hasWhereClause = true;
        }

        // Add rating filter if applicable
        if (filterfr != null && !filterfr.isEmpty()) {
            sql += (hasWhereClause ? "AND " : "WHERE ") + "f.rating = ? ";
        }

        // Close the group query
        sql += "GROUP BY f.feedbackID) AS GroupedFeedback";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Set search parameters if applicable
            if (search != null && !search.isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }

            // Set product name filter parameter if applicable
            if (filterfp != null && !filterfp.isEmpty()) {
                String productPattern = "%" + filterfp + "%";
                ps.setString(paramIndex++, productPattern);
            }

            // Set rating filter parameter if applicable
            if (filterfr != null && !filterfr.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(filterfr));
            }

            // Execute the query and return the result
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Return the count of feedbacks
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception
        }
        return 0; // Return 0 if an error occurs
    }

    public void updateStatusFb(int feedbackID, int status) {
        String sql = "UPDATE Feedback SET status = ? WHERE feedbackID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, feedbackID);
            ps.executeUpdate(); // Trả về true nếu cập nhật thành công
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ (log, thông báo lỗi, v.v.)
        }
    }

    public Feedback getFeedbackByID(int feedbackID) {
        String sql = "SELECT f.feedbackID, f.customerID, c.fullName, c.email, c.phone, p.productName, p.productID, f.rating, f.comment, f.status, f.feedbackDate "
                + "FROM Feedback f "
                + "JOIN Customers c ON f.customerID = c.customerID "
                + "JOIN Products p ON f.productID = p.productID "
                + "WHERE f.feedbackID = ?";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, feedbackID);

            // Thực thi câu lệnh SQL và lấy kết quả
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Date feedbackDate = rs.getDate("feedbackDate");
                String fDateStr = dateFormat.format(feedbackDate);
                return new Feedback(
                        feedbackID,
                        rs.getInt("customerID"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("productName"),
                        rs.getInt("productID"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getInt("status"),
                        fDateStr
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM Customers";
        int totalCustomer = 0;
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                totalCustomer = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return totalCustomer;
    }

    public List<Customers> getCustomersPaginated(int index) {
        List<Customers> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customers ORDER BY customerID OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 10);

            // Execute the SQL query and get the result set
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Create customer objects and add them to the list
                customers.add(new Customers(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getString(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<Customers> getFilteredCustomers(String status, String searchTitle) {
        List<Customers> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Customers WHERE 1=1");

        // List to store parameters
        List<Object> parameters = new ArrayList<>();

        // Add filters based on provided parameters
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
            parameters.add(Integer.parseInt(status));
        }
        if (searchTitle != null && !searchTitle.isEmpty()) {
            sql.append(" AND (fullName LIKE ? OR email LIKE ? OR phone LIKE ?)");
            String searchParam = "%" + searchTitle + "%"; // Use LIKE for searching
            parameters.add(searchParam);
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
                list.add(new Customers(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getString(11)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }

        return list;
    }

    public Customers getCustomerByCid(int cid) {
        String sql = "select * from Customers where customerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);

            // Execute the SQL query and get the result set
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Create customer objects and add them to the list
                return new Customers(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getInt(8), rs.getString(9), rs.getInt(10), rs.getString(11));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<customer_change_history> getCustomerChangesHistory(int cid) {
        String sql = "select * from customer_change_history where customer_id = ?";
        List<customer_change_history> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);

            // Execute the SQL query and get the result set
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Create customer objects and add them to the list
                list.add(new customer_change_history(rs.getInt("customer_Id"),
                        rs.getString("email"), rs.getString("full_name"),
                        rs.getInt("gender"), rs.getString("mobile"),
                        rs.getString("address"), rs.getString("updated_by"), rs.getString("updated_date")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Address> getAllAddressByCid(int cid) {
        String sql = "select * from Address\n"
                + "where customerID = ?";
        List<Address> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cid);

            // Execute the SQL query and get the result set
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Address(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updatedCustomer(String status, String note, int cid) {
        // Initialize SQL query
        String sql = "UPDATE Customers SET note = ?, status = ? WHERE customerID = ?";

        try {
            // Prepare the SQL statement
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setString(1, note);  // Set the 'note' parameter
            ps.setInt(2, Integer.parseInt(status));    // Set the 'status' parameter
            ps.setInt(3, cid);       // Set the 'customerID' parameter

            // Execute the update query
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Return true if rows were updated

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void addCustomerChangeHistory(int id, String email, String fullName, int gender, String phone, String address, String updated_by) {
        String sql = "Insert into customer_change_history (customer_Id, email, full_name, gender, mobile, address, updated_by, updated_date) values (?, ?, ?, ?, ?, ?, ?,CURRENT_TIMESTAMP)";
        try {
            // Prepare the SQL statement
            PreparedStatement ps = connection.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setInt(1, id);
            ps.setString(2, email);
            ps.setString(3, fullName);
            ps.setInt(4, gender);
            ps.setString(5, phone);
            ps.setString(6, address);
            ps.setString(7, updated_by);
            // Execute the update query
            int rowsUpdated = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Slider> getFilteredSliders(String status, String searchTitle) {
        List<Slider> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Sliders WHERE 1=1");

        // List to store parameters
        List<Object> parameters = new ArrayList<>();

        // Add filters based on provided parameters
        if (status != null && !status.isEmpty()) {
            try {
                // Convert status to integer and add to parameters
                int statusInt = Integer.parseInt(status);
                sql.append(" AND status = ?");
                parameters.add(statusInt);
            } catch (NumberFormatException e) {
                System.err.println("Invalid status format: " + status); // Log invalid status
                return list; // Return empty list if status is invalid
            }
        }
        if (searchTitle != null && !searchTitle.isEmpty()) {
            sql.append(" AND (title LIKE ? OR backlink LIKE ?)");
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
                list.add(new Slider(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getString(6),
                        rs.getString(7), rs.getString(8)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }

        return list;
    }

    public void SetShowOrHideForSlider(int status, int sidToSetStatus) {
        String sql = "update Sliders\n"
                + "set status = ?\n"
                + "where sliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, status);
            stm.setInt(2, sidToSetStatus);
            int rowsAffected = stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Slider getSliderBySID(int sid) {
        String sql = "select * from Sliders where sliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set parameters for the PreparedStatement
            stm.setInt(1, sid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Slider(rs.getInt(1), rs.getString(2),
                        rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getString(6),
                        rs.getString(7), rs.getString(8));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSlider(Slider slider) {
        String sql = "UPDATE Sliders SET title = ?, backlink = ?, status = ?, sliderImgUrl = ?, notes = ? WHERE sliderID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, slider.getTitle());
            stm.setString(2, slider.getBacklink());
            stm.setInt(3, slider.getStatus());
            stm.setString(4, slider.getSliderImgUrl());
            stm.setString(5, slider.getNotes());
            stm.setInt(6, slider.getSliderID());
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public BlogSubtitles getSubtitleById(int parsedSubtitleId) {
        String sql = "select * from BlogSubtitles where subtitleID = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, parsedSubtitleId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new BlogSubtitles(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> getProductName() {
        List<String> list = new ArrayList<>();
        String sql = "select distinct p.productName\n"
                + "from Feedback f join Products p on f.productID=p.productID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return list;
    }

    public static void main(String[] args) {
        MarketerDAO md = new MarketerDAO();
        System.out.println(md.getFeedbackByID(1).getRated());
    }

    public boolean isPasswordCorrect(String email, String oldPassword) {
        String sql = "SELECT * FROM Employees WHERE email = ? AND password = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, email);
            stm.setString(2, oldPassword);
            // Execute the query
            try (ResultSet rs = stm.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE Employees SET password = ? WHERE email = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Set the parameters for the prepared statement
            stm.setString(1, newPassword); // Set the new password
            stm.setString(2, email);       // Set the email

            // Execute the update and check the number of affected rows
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0; // Return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if there was an exception or no rows were updated
    }

    public List<Feedback> getFeebackByFeedbackDate(String startDate, String endDate) {
        List<Feedback> list = new ArrayList<>();
        String sql = "select * from Feedback\n"
                + "where feedbackDate between ? and ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Feedback(rs.getInt(2), rs.getInt(6), rs.getInt(4), rs.getString(3), rs.getInt(7), rs.getString(5), rs.getInt(9), rs.getInt(8)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Order> getOrderSuccessByDate(String startDate, String endDate) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from Orders\n"
                + "where orderDate >= ? and orderDate <= ? and statusID = 7"; //status = 7 means order success
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public float getPriceByOrderID(int orderID) {
        String sql = "SELECT * FROM OrderDetail WHERE orderID = ?";
        float totalPrice = 0;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    totalPrice += rs.getInt(5) * rs.getFloat(6);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging or handling the exception
        }
        return totalPrice;
    }

    public List<OrderDetail> getOrderDetailByOrderID(int orderID) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select * from OrderDetail where orderID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(5), rs.getInt(4)));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public float getImportPriceByProductIdAndSizeID(int productID, int sizeID) {
        String sql = "select * from Product_Attribute_Stock where productID = ? and sizeID = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, productID);
            stm.setInt(2, sizeID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getFloat(5);
            }
        } catch (SQLException e) {
        }
        return 0;
    }
}


