/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.seller;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author Tan
 */
public class SaleDAO extends DBContext {

    public Map<String, Double> listDailyRevenueByEmployee(int employeeID, String startDate, String endDate) {
        Map<String, Double> revenueMap = new LinkedHashMap<>(); // Use LinkedHashMap for insertion order
        String sql = "SELECT CAST(invoiceDate AS DATE) AS invoiceDate, SUM(totalAmount) AS totalAmount \n"
                + "FROM Invoice i \n"
                + "JOIN OrderAssignment oa ON oa.orderID = i.orderID \n"
                + "WHERE oa.employeeID = ? \n"
                + "AND CAST(invoiceDate AS DATE) BETWEEN ? AND ? \n"
                + "GROUP BY CAST(invoiceDate AS DATE) \n"
                + "ORDER BY invoiceDate asc";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID);  // Set employeeID
            ps.setString(2, startDate);  // Set start date
            ps.setString(3, endDate);  // Set end date
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Use invoiceDate as the key and totalAmount as the value
                revenueMap.put(rs.getString("invoiceDate"), rs.getDouble("totalAmount"));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions
        }
        return revenueMap;
    }

    public Map<String, Integer[]> getOrderTrend(int employeeID, String startDate, String endDate) {
        Map<String, Integer[]> orderTrend = new LinkedHashMap<>();
        String sql = "SELECT CONVERT(VARCHAR, orderDate, 23) AS OrderDay, \n"
                + "                COUNT(o.orderID) AS TotalOrders, \n"
                + "                SUM(CASE WHEN o.statusID = 7 THEN 1 ELSE 0 END) AS SuccessOrders \n"
                + "                FROM Orders o join OrderAssignment oa on o.orderID=oa.orderID\n"
                + "                WHERE oa.employeeID=? AND CAST(orderDate AS DATE) BETWEEN ? AND ? \n"
                + "                GROUP BY CONVERT(VARCHAR, orderDate, 23) \n"
                + "                ORDER BY OrderDay";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID);
            ps.setString(2, startDate);
            ps.setString(3, endDate);
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

    public Map<String, Double> listDailyRevenueByEmployee(String startDate, String endDate) {
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        String sql = "SELECT CAST(invoiceDate AS DATE) AS invoiceDate, SUM(totalAmount) AS totalAmount \n"
                + "FROM Invoice \n"
                + "Where CAST(invoiceDate AS DATE) BETWEEN ? AND ? \n"
                + "GROUP BY CAST(invoiceDate AS DATE)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);  // Set start date
            ps.setString(2, endDate);  // Set end date
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Use invoiceDate as the key and totalAmount as the value
                revenueMap.put(rs.getString("invoiceDate"), rs.getDouble("totalAmount"));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions
        }
        return revenueMap;
    }

    public Map<String, Integer[]> getOrderTrend(String startDate, String endDate) {
        Map<String, Integer[]> orderTrend = new LinkedHashMap<>();
        String sql = "SELECT CONVERT(VARCHAR, orderDate, 23) AS OrderDay, \n"
                + "                COUNT(orderID) AS TotalOrders, \n"
                + "                SUM(CASE WHEN statusID = 7 THEN 1 ELSE 0 END) AS SuccessOrders \n"
                + "                FROM Orders \n"
                + "                WHERE  CAST(orderDate AS DATE) BETWEEN ? AND ? \n"
                + "                GROUP BY CONVERT(VARCHAR, orderDate, 23) \n"
                + "                ORDER BY OrderDay";
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

    public float getTotalRevenueForSeller(int employeeID, String startDate, String endDate) {
        String sql = "SELECT SUM(totalAmount) AS totalAmount\n"
                + "FROM Invoice i \n"
                + "JOIN OrderAssignment oa ON oa.orderID = i.orderID \n"
                + "join Orders o on o.orderID=i.orderID\n"
                + "join Status s on s.statusID=o.statusID\n"
                + "WHERE oa.employeeID = ? and s.statusName like 'Success'\n"
                + "AND CAST(invoiceDate AS DATE) BETWEEN ? AND ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID);
            ps.setString(2, startDate);
            ps.setString(3, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public float getTotalRevenueForSeller(String startDate, String endDate) {
        String sql = "SELECT SUM(totalAmount) AS totalAmount\n"
                + "FROM Invoice i \n"
                + "join Orders o on o.orderID=i.orderID\n"
                + "join Status s on s.statusID=o.statusID\n"
                + "WHERE s.statusName like 'Success'\n"
                + "AND CAST(invoiceDate AS DATE) BETWEEN ? AND ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, startDate);
            ps.setString(2, endDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


}
