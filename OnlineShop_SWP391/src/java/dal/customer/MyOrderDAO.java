/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.customer;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author Tan
 */
public class MyOrderDAO extends DBContext {

    public List<Order> getOrderOfCusByID(int customerID, int index) {
        List<Order> list = new ArrayList<>();
        MyOrderDAO mod = new MyOrderDAO();
        String sql = "SELECT \n"
                + "    o.orderID, \n"
                + "    o.orderDate, \n"
                + "    s.statusName, \n"
                + "    Max(p.productName) AS firstProductName,\n"
                + "    SUM(od.price * od.quantity) AS totalAmount\n"
                + "FROM Orders o \n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID\n"
                + "JOIN Status s ON o.statusID = s.statusID\n"
                + "WHERE o.customerID = ?\n"
                + "GROUP BY o.orderID, o.orderDate, s.statusName\n"
                + "ORDER BY o.orderDate desc \n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, (index - 1) * 10); // Correct parameter order
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                String statusName = rs.getString("statusName");
                int quantity = mod.numberOfOtherProducts(customerID, orderID) - 1;
                Date orderDate = rs.getDate("orderDate");
                String productName = rs.getString("firstProductName");
                float price = rs.getFloat("totalAmount");
                String orderDateString = dateFormat.format(orderDate);
                Order o = new Order(orderID, orderDateString, statusName, price, quantity, productName);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Replace with proper logging
        }
        return list;
    }

    public int getTotalOfOrder(int customerID) {
        String sql = "select count (*)\n"
                + "from Orders \n"
                + "where customerID =?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return 0;
    }

    public List<Order> searchOrder(int customerID, int index, String keyword) {
        List<Order> list = new ArrayList<>();
        MyOrderDAO mod = new MyOrderDAO();
        String sql = "SELECT \n"
                + "    o.orderID, \n"
                + "    o.orderDate, \n"
                + "    s.statusName, \n"
                + "    MAX(p.productName) AS firstProductName,\n"
                + "    SUM(od.price * od.quantity) AS totalAmount\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID\n"
                + "JOIN Status s ON o.statusID = s.statusID\n"
                + "WHERE o.customerID = ? AND EXISTS (\n"
                + "        SELECT 1 \n"
                + "        FROM OrderDetail od2 \n"
                + "        JOIN Products p2 ON od2.productID = p2.productID \n"
                + "        WHERE od2.orderID = o.orderID AND p2.productName LIKE ?\n"
                + "    )\n"
                + "GROUP BY  o.orderID, o.orderDate, s.statusName\n"
                + "ORDER BY o.orderDate desc \n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;";

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);  // Đặt customerID vào tham số đầu tiên
            ps.setString(2, "%" + keyword + "%");  // Truyền keyword vào LIKE
            ps.setInt(3, (index - 1) * 10);  // Tính toán OFFSET

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                String statusName = rs.getString("statusName");
                int quantity = mod.numberOfOtherProducts(customerID, orderID) - 1;
                Date orderDate = rs.getDate("orderDate");
                String productName = rs.getString("firstProductName");
                float price = rs.getFloat("totalAmount");
                String orderDateString = dateFormat.format(orderDate);
                Order o = new Order(orderID, orderDateString, statusName, price, quantity, productName);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return list;
    }

    public int getTotalSearch(int customerID, String keyword) {
        String sql = "SELECT COUNT(DISTINCT o.orderID) AS totalOrders\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID\n"
                + "WHERE o.customerID = ? \n"
                + "    AND EXISTS (\n"
                + "        SELECT 1 \n"
                + "        FROM OrderDetail od2 \n"
                + "        JOIN Products p2 ON od2.productID = p2.productID \n"
                + "        WHERE od2.orderID = o.orderID AND p2.productName LIKE ?\n"
                + "    );";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return 0;
    }

    public float getToTalAmount(int customerID) {
        String sql = "SELECT Sum(od.price * od.quantity) AS totalAmount\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Status s on s.statusID=o.statusID\n"
                + "WHERE o.customerID =? AND s.statusName like 'Success';";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exception properly in production code

        }
        return 0;
    }

    public int numberOfOtherProducts(int customerID, int orderID) {
        String sql = "SELECT COUNT(od.productID)\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "WHERE o.customerID = ? AND o.orderID = ?\n"
                + "GROUP BY o.orderID";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerID);
            ps.setInt(2, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Replace with proper logging
        }
        return 0;
    }

    public boolean cancelOrder(int orderID) {
        String sql = "UPDATE Orders SET statusID = 1 WHERE orderID = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            int rowsUpdated = ps.executeUpdate();

            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public String getStatusByOrderID(int orderID) {
        String sql = "Select s.statusName\n"
                + "From Orders o join Status s on o.statusID=s.statusID\n"
                + "where o.orderID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("statusName");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public List<OrderDetail> getOrderDetailByOrderID(int orderID) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "Select productID, sizeID,quantity\n"
                + "From OrderDetail\n"
                + "where orderID=?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(rs.getInt("productID"), rs.getInt("sizeID"), rs.getInt("quantity")));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return null;
    }

    public void updateHoldAfterCancel(int productID, int sizeID, int quantity) {
        String sql = "UPDATE [dbo].[Product_Attribute_Stock]\n"
                + " Set hold =hold- ?\n"
                + " WHERE productID=? and sizeID=?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productID);
            ps.setInt(3, sizeID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        MyOrderDAO od = new MyOrderDAO();
        System.out.println(od.getTotalSearch(1, "V"));
    }
}
