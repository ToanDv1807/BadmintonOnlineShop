/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.warehouse;

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
import model.Products;
import model.Slider;
import model.customer_change_history;

/**
 *
 * @author LENNOVO
 */
public class WarehouseDAO extends DBContext {

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

    public List<Order> getOrdersByCreatedDate(String startDate, String endDate) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE orderDate BETWEEN ? AND ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            while (rs.next()) {
                Order o = new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                orders.add(o);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public double getTotalImportCostByDate(String startDate, String endDate) {
        double totalImportCost = 0.0;
        String sql = "SELECT p.importPrice, pa.stock "
                + "FROM Products p "
                + "JOIN Product_Attribute_Stock pa ON p.productID = pa.productID "
                + "WHERE p.createdAt BETWEEN ? AND ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                double importPrice = rs.getDouble("importPrice");
                int stock = rs.getInt("stock");
                totalImportCost += importPrice * stock;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalImportCost;
    }

    public Map<String, Integer> getOrderSuccessLast7Days() {
        Map<String, Integer> orderSuccessData = new HashMap<>();
        String sql = """
        WITH DateRange AS (
            SELECT CAST(GETDATE() AS DATE) AS order_day
            UNION ALL
            SELECT DATEADD(DAY, -1, order_day)
            FROM DateRange
            WHERE order_day > DATEADD(DAY, -6, GETDATE())
        )
        SELECT d.order_day, 
               COUNT(o.orderID) AS successful_orders
        FROM DateRange d
        LEFT JOIN Orders o ON CAST(o.orderDate AS DATE) = d.order_day
        LEFT JOIN OrderAssignment oa ON o.orderID = oa.orderID
        LEFT JOIN Status s ON oa.statusID = s.statusID
        WHERE s.statusName = 'Success'
        GROUP BY d.order_day
        ORDER BY d.order_day
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                String orderDay = rs.getDate("order_day").toString();
                int successCount = rs.getInt("successful_orders");
                orderSuccessData.put(orderDay, successCount);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return orderSuccessData;
    }

    public Map<String, Integer> getOrderStatusDistribution() {
        Map<String, Integer> orderStatusCount = new HashMap<>();
        String sql = """
        SELECT s.statusName, COUNT(oa.orderID) AS orderCount
        FROM OrderAssignment oa
        JOIN Orders o ON oa.orderID = o.orderID
        JOIN Status s ON oa.statusID = s.statusID
        GROUP BY s.statusName
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                String statusName = rs.getString("statusName"); // Retrieve status name
                int count = rs.getInt("orderCount"); // Count of orders per status
                orderStatusCount.put(statusName, count);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return orderStatusCount;
    }

    public static void main(String[] args) {
        WarehouseDAO wd = new WarehouseDAO();
        System.out.println(wd.getOrdersByCreatedDate("2024-10-25 21:27:42.000", "2024-10-27 02:22:36.000").size());
    }
}
