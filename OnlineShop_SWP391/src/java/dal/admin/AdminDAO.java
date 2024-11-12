/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.admin;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Employees;
import model.Role;

/**
 *
 * @author Tan
 */
public class AdminDAO extends DBContext {

    public Employees getEmployeesByEmail(String email) {
        String sql = "select * from Employees where email =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("employeeID");
                String password = rs.getString("password");
                String name = rs.getString("fullname");
                String address = rs.getString("address");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                String phone = rs.getString("phone");
                int gender = rs.getInt("gender");
                String img_url = rs.getString("img_url");
                return new Employees(id, email, password, name, address, role, status, gender, img_url, phone);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return null;
    }

    public Employees getEmployeesByID(int employeeID) {
        String sql = "select * from Employees where email =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String email = rs.getString("email");
                String password = rs.getString("password");
                String name = rs.getString("fullname");
                String address = rs.getString("address");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                String phone = rs.getString("phone");
                int gender = rs.getInt("gender");
                String img_url = rs.getString("img_url");
                return new Employees(employeeID, email, password, name, address, role, status, gender, img_url, phone);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return null;
    }

    public void updateEmployee(int id, String img_url, String phone, String address, String fullName, int gender, int role, int status) {
        String sql = "UPDATE [dbo].[Employees]\n"
                + "   SET "
                + "     [img_url] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[fullName] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[roleID] = ?\n"
                + "      ,[status] = ?\n"
                + " WHERE employeeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, img_url);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, fullName);
            ps.setInt(5, gender);
            ps.setInt(6, role);
            ps.setInt(7, status);
            ps.setInt(8, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Employees getEmployeeByID(int ID) {
        String sql = "select * from Employees where employeeID =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, ID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String password = rs.getString("password");
                String name = rs.getString("fullname");
                String email = rs.getString("email");
                String address = rs.getString("address");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                String phone = rs.getString("phone");
                int gender = rs.getInt("gender");
                String img_url = rs.getString("img_url");
                return new Employees(ID, email, password, name, address, role, status, gender, img_url, phone);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return null;
    }

    public int getTotalEmployees() {
        String sql = "SELECT COUNT (*) FROM Employees WHERE roleID !=1";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Employees> pagingEmployees(int index, String order) {
        List<Employees> list = new ArrayList<>();
        String sql = "SELECT * FROM Employees "
                + "WHERE roleID !=1 "
                + "ORDER BY " + order + " "
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 10); // Thay đổi vị trí của tham số `OFFSET`
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("employeeID");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String name = rs.getString("fullname");
                String address = rs.getString("address");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                String phone = rs.getString("phone");
                int gender = rs.getInt("gender");
                String img_url = rs.getString("img_url");
                Employees e = new Employees(id, email, password, name, address, role, status, gender, img_url, phone);
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return list;
    }

// Phân trang và tìm kiếm cho Employees
    public List<Employees> searchEmployees(String keyword, int pageIndex, String order) {
        List<Employees> list = new ArrayList<>();
        // Sử dụng tên cột trực tiếp trong câu lệnh SQL
        String sql = "SELECT * FROM Employees WHERE (fullName LIKE ? OR email LIKE ? or phone like ?) AND roleID != 1 "
                + "ORDER BY " + order + " "
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setInt(4, (pageIndex - 1) * 10);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("employeeID");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String name = rs.getString("fullname");
                String address = rs.getString("address");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                String phone = rs.getString("phone");
                int gender = rs.getInt("gender");
                String img_url = rs.getString("img_url");
                Employees e = new Employees(id, email, password, name, address, role, status, gender, img_url, phone);
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return list;
    }

// Đếm tổng số nhân viên theo từ khóa tìm kiếm và loại bỏ các nhân viên có roleID = 1
    public int getTotalEmployeesBySearch(String keyword) {
        String sql = "SELECT COUNT(*) FROM Employees WHERE roleID != 1 AND fullName LIKE ? OR email LIKE ? or phone like ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return 0;
    }

    public List<Employees> filterEmployees(String keyword, int pageIndex, String order, String gender, String role, String status) {
        List<Employees> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Employees WHERE (fullName LIKE ? OR email LIKE ? or phone like ?) AND roleID != 1 ");

        // Thêm điều kiện lọc theo giới tính, vai trò và trạng thái
        if (gender != null && !gender.isEmpty()) {
            sql.append("AND gender = ").append(gender).append(" ");
        }
        if (role != null && !role.isEmpty()) {
            sql.append("AND roleID = ").append(role).append(" ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND status = ").append(status).append(" ");
        }

        sql.append("ORDER BY ").append(order).append(" OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ps.setInt(4, (pageIndex - 1) * 10);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Employees e = new Employees(rs.getInt("employeeID"), rs.getString("email"), rs.getString("password"),
                        rs.getString("fullname"), rs.getString("address"), rs.getInt("roleID"),
                        rs.getInt("status"), rs.getInt("gender"), rs.getString("img_url"), rs.getString("phone"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalEmployeesByFilter(String keyword, String gender, String role, String status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Employees WHERE roleID != 1 AND (fullName LIKE ? OR email LIKE ? or phone like ?) ");
        if (gender != null && !gender.isEmpty()) {
            sql.append("AND gender = ").append(gender).append(" ");
        }
        if (role != null && !role.isEmpty()) {
            sql.append("AND roleID = ").append(role).append(" ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append("AND status = ").append(status).append(" ");
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void deleteEmployee(int id) {
        String sql = "DELETE FROM [dbo].[Employees]\n"
                + "      WHERE employeeID = ?\n";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public float totalAmount(String startDate, String endDate) {
        String sql = "select sum(totalAmount)\n"
                + "from Invoice i join Orders o on i.orderID=o.orderID\n"
                + "join Status s on o.statusID=s.statusID\n"
                + "where CAST(invoiceDate AS DATE) BETWEEN ? AND ?  and  s.statusName like 'Success'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return 0;
    }

    public int totalCustomers(String startDate, String endDate) {
        String sql = "SELECT COUNT(customerID) "
                + "FROM Customers "
                + "WHERE CAST(createDate AS DATE) BETWEEN ? AND ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public float getAvgOfAllFB(String startDate, String endDate) {
        String sql = "select avg(rating)\n"
                + "from Feedback\n"
                + "where CAST(feedbackDate AS DATE) BETWEEN ? AND ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Integer> listOrderCountByStatus(String startDate, String endDate) {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT s.statusName, COUNT(o.orderID) \n"
                + "FROM Orders o \n"
                + "JOIN [Status] s ON o.statusID = s.statusID \n"
                + "WHERE CAST(o.orderDate AS DATE) BETWEEN ? AND ? \n"
                + "GROUP BY s.statusName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Use statusName as the key and order count as the value
                map.put(rs.getString(1), rs.getInt(2));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions
        }
        return map;
    }

    public int totalCustomerBuy(String startDate, String endDate) {
        String sql = "SELECT COUNT(DISTINCT customerID) "
                + "FROM Orders "
                + "WHERE CAST(orderDate AS DATE) BETWEEN ? AND ? AND statusID = 7";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Float> listRate(String startDate, String endDate) {
        Map<String, Float> map = new HashMap<>();
        String sql = "SELECT c.catName, AVG(fb.rating) \n"
                + "FROM Feedback fb \n"
                + "JOIN Products p ON fb.productID = p.productID \n"
                + "join Category c on p.catID=c.catID\n"
                + "WHERE CAST(fb.feedbackDate AS DATE) BETWEEN ? AND ? \n"
                + "GROUP BY c.catName,c.catID";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Use catID as the key and average rating as the value
                map.put(rs.getString(1), rs.getFloat(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public Map<String, Float> listAmount(String startDate, String endDate) {
        Map<String, Float> map = new HashMap<>();
        String sql = "SELECT c.catName,SUM(od.quantity * od.price) AS totalRevenue\n"
                + "FROM OrderDetail od JOIN Products p ON od.productID = p.productID\n"
                + "JOIN Category c ON p.catID = c.catID\n"
                + "JOIN Orders o ON od.orderID = o.orderID\n"
                + "WHERE o.statusID = 7 AND CAST(o.orderDate AS DATE) BETWEEN ? AND ?\n"
                + "GROUP BY c.catName";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Use catName as the key and the sum of the total amount as the value
                map.put(rs.getString(1), rs.getFloat(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public Map<String, Integer[]> getOrderTrend(String startDate, String endDate) {
        Map<String, Integer[]> orderTrend = new LinkedHashMap<>();
        String sql = "SELECT CONVERT(VARCHAR, orderDate, 23) AS OrderDay, "
                + "COUNT(orderID) AS TotalOrders, "
                + "SUM(CASE WHEN statusID = 7 THEN 1 ELSE 0 END) AS SuccessOrders "
                + "FROM Orders "
                + "WHERE CAST(orderDate AS DATE) BETWEEN ? AND ? "
                + "GROUP BY CONVERT(VARCHAR, orderDate, 23) "
                + "ORDER BY OrderDay";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String day = rs.getString("OrderDay");
                Integer totalOrders = rs.getInt("TotalOrders");
                Integer successOrders = rs.getInt("SuccessOrders");
                orderTrend.put(day, new Integer[]{totalOrders, successOrders});
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderTrend;
    }

    public void createEmployee(String email, String fullName, String password, String phone, String address, int gender, String imgFileName, int role) {
        String sql = "INSERT INTO [dbo].[Employees]\n"
                + "           ([email]\n"
                + "           ,[password]\n"
                + "           ,[fullName]\n"
                + "           ,[address]\n"
                + "           ,[roleID]\n"
                + "           ,[status]\n"
                + "           ,[phone]\n"
                + "           ,[gender]\n"
                + "           ,[img_url])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, address);
            ps.setInt(5, role);
            ps.setInt(6, 1);
            ps.setString(7, phone);
            ps.setInt(8, gender);
            ps.setString(9, imgFileName);
            int rowsAffected = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Role> listRole() {
        List<Role> list = new ArrayList<>();
        String sql = "select *\n"
                + "from [Role]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int roleID = rs.getInt("roleID");
                String roleName = rs.getString("roleName");
                Role role = new Role(roleID, roleName);
                list.add(role);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean resetPassword(int employeeID, String password) {
        String sql = "UPDATE [dbo].[Employees] SET [password] = ? WHERE [employeeID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setInt(2, employeeID);

            // Execute the update and check if it affected any rows
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0; // Return true if at least one row was updated
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if an exception occurred
    }

    public static void main(String[] args) {
        AdminDAO ad = new AdminDAO();
        System.out.println(ad.getEmployeeByID(1).getRoleID());
    }
}
