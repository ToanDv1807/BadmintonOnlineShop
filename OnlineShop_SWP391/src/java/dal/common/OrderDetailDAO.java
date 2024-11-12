/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Customers;
import model.Employees;
import model.Order;
import model.OrderDetail;
import model.Products;

/**
 *
 * @author MSI1
 */
public class OrderDetailDAO extends DBContext {

    public int insertOrderDetail(OrderDetail od) {
        int result = 0;
        String sql = "INSERT INTO [dbo].[OrderDetail]\n"
                + "           ([orderID]\n"
                + "           ,[productID]\n"
                + "           ,[sizeID]\n"
                + "           ,[quantity]\n"
                + "           ,[price])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, od.getOrderID());
            statement.setObject(2, od.getProductID());
            statement.setObject(3, od.getSizeID());
            statement.setObject(4, od.getQuantity());
            statement.setObject(5, od.getPrice());
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public Order getOrderDetails(int orderId) {
        Order order = null;
        String sql = """
        SELECT o.orderID, o.orderDate,o.statusID, s.statusName, o.note, o.addressName AS customerAddress, 
               c.fullName AS customerName, c.email AS customerEmail, c.phone AS customerPhone, 
               c.gender AS customerGender, 
               od.quantity, p.productID, p.productName, od.price AS priceAfterDiscount, p.description, p.quantity AS productQuantity, 
               cat.catName, 
               e.fullName AS salerName, -- Lấy tên nhân viên (saler)
               (od.price * od.quantity) AS lineAmount -- Tính tổng tiền cho từng sản phẩm  
        FROM Orders o
        JOIN Customers c ON o.customerID = c.customerID
        JOIN OrderDetail od ON o.orderID = od.orderID
        JOIN Products p ON od.productID = p.productID
        JOIN Category cat ON p.catID = cat.catID
        JOIN OrderAssignment oa ON o.orderID = oa.orderID
        JOIN Employees e ON oa.employeeID = e.employeeID -- Tham gia với Employees để lấy thông tin nhân viên
        JOIN Status s ON o.statusID = s.statusID -- Join with Status table to get statusName
        WHERE o.orderID = ?
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            List<OrderDetail> orderDetails = new ArrayList<>();
            float totalAmount = 0;  // Biến để tính tổng tiền

            while (rs.next()) {
                if (order == null) {
                    // Khởi tạo đối tượng Order với thông tin cơ bản
                    order = new Order();
                    order.setOrderID(rs.getInt("orderID"));

                    // Chuẩn bị định dạng ngày tháng
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");

                    // Lấy giá trị kiểu Date từ database
                    Date orderDate = rs.getDate("orderDate");

                    // Chuyển đổi kiểu Date thành String với định dạng mong muốn
                    String orderDateString = dateFormat.format(orderDate);

                    // Gán giá trị String vào đối tượng Order
                    order.setOrderDate(orderDateString);

                    // Use statusName instead of orderStatus
                    order.setStatusName(rs.getString("statusName"));  // Fetch statusName instead of integer orderStatus
                    order.setCategory(rs.getString("catName"));
                    order.setSaleName(rs.getString("salerName"));
                    order.setNote(rs.getString("note"));
                    order.setOrderStatus(rs.getInt("statusID"));
                    // Thông tin khách hàng
                    Customers customer = new Customers();
                    customer.setFullName(rs.getString("customerName"));
                    customer.setEmail(rs.getString("customerEmail"));
                    customer.setPhone(rs.getString("customerPhone"));
                    customer.setAddress(rs.getString("customerAddress"));
                    customer.setGender(rs.getInt("customerGender"));

                    // Gán khách hàng vào order
                    order.setCustomer(customer);
                }

                // Thông tin sản phẩm
                Products product = new Products();
                product.setProductID(rs.getInt("productID"));
                product.setProductName(rs.getString("productName"));
                product.setPrice(rs.getFloat("priceAfterDiscount"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("productQuantity"));

                // Tạo đối tượng OrderDetail
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(rs.getInt("orderID"));
                orderDetail.setProductID(rs.getInt("productID"));
                orderDetail.setQuantity(rs.getInt("quantity"));
                orderDetail.setProduct(product);  // Gán thông tin sản phẩm vào orderDetail
                orderDetail.setCategory(rs.getString("catName"));

                // Tính tổng tiền cho dòng sản phẩm hiện tại
                float lineAmount = rs.getFloat("lineAmount");
                totalAmount += lineAmount;  // Cộng dồn vào tổng tiền của đơn hàng

                // Thêm vào danh sách chi tiết đơn hàng
                orderDetails.add(orderDetail);
            }

            if (order != null) {
                order.setOrderDetails(orderDetails);  // Gán danh sách chi tiết đơn hàng vào order
                order.setTotalAmount(totalAmount);  // Gán tổng tiền vào order
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }

    public List<Employees> getAllEmployees() {
        List<Employees> employees = new ArrayList<>();
        String sql = "SELECT e.employeeID, e.fullName, "
                + "(SELECT COUNT(*) FROM orderAssignment o WHERE o.employeeID = e.employeeID AND o.statusID = 2) AS orderCount "
                + "FROM Employees e "
                + "WHERE e.roleID = 3";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Employees emp = new Employees();
                emp.setEmployeeID(rs.getInt("employeeID"));
                emp.setFullName(rs.getString("fullName"));
                emp.setTotalOrder(rs.getInt("orderCount")); // Thêm thuộc tính orderCount vào class Employees
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    public int getEmployeeIDByName(String employeeName) {
        String sql = "SELECT employeeID FROM Employees WHERE fullName = ?";
        int employeeID = -1;  // Giá trị mặc định nếu không tìm thấy

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, employeeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                employeeID = rs.getInt("employeeID");  // Lấy employeeID nếu tìm thấy
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employeeID;
    }

    public void updateOrderSaler(int orderID, String employeeName) {
        // Gọi hàm lấy employeeID từ tên
        int employeeID = getEmployeeIDByName(employeeName);

        if (employeeID != -1) {  // Chỉ tiếp tục nếu tìm thấy employeeID
            String sql = "UPDATE OrderAssignment SET employeeID = ? WHERE orderID = ?";

            try {
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, employeeID);
                ps.setInt(2, orderID);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Không tìm thấy nhân viên với tên: " + employeeName);
        }
    }

    public List<OrderDetail> getOrderDetailByOrderID(int OrderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "select od.orderDetailID, od.orderID, od.productID, od.quantity, od.sizeID, od.price\n"
                + "from OrderDetail od\n"
                + "where od.orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, OrderID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int orderDetailID = resultSet.getInt("orderDetailID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int quantity = resultSet.getInt("quantity");
                float price = resultSet.getInt("price");

                OrderDetail orderDetail = new OrderDetail(orderDetailID, OrderID, productID, quantity, sizeID, price);
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return orderDetails;
    }

    public List<OrderDetail> getOrderDetailInStatusDeliveringByOrderID(int OrderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "select od.orderDetailID, od.orderID, od.productID, od.quantity, od.sizeID\n"
                + "from OrderDetail od\n"
                + "join Orders o on o.orderID = od.orderID\n"
                + "where o.statusID = 6 and o.orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, OrderID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int orderDetailID = resultSet.getInt("orderDetailID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int quantity = resultSet.getInt("quantity");

                OrderDetail orderDetail = new OrderDetail(orderDetailID, OrderID, productID, quantity, sizeID);
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return orderDetails;
    }
    
    public List<OrderDetail> getOrderDetailInStatusCancelByOrderID(int OrderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "select od.orderDetailID, od.orderID, od.productID, od.quantity, od.sizeID\n"
                + "from OrderDetail od\n"
                + "join Orders o on o.orderID = od.orderID\n"
                + "where o.statusID = 8 and o.orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, OrderID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int orderDetailID = resultSet.getInt("orderDetailID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int quantity = resultSet.getInt("quantity");

                OrderDetail orderDetail = new OrderDetail(orderDetailID, OrderID, productID, quantity, sizeID);
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return orderDetails;
    }
    
    public List<OrderDetail> getOrderDetailInStatusCancelBySellerByOrderID(int OrderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "select od.orderDetailID, od.orderID, od.productID, od.quantity, od.sizeID\n"
                + "from OrderDetail od\n"
                + "join Orders o on o.orderID = od.orderID\n"
                + "where o.statusID = 1 and o.orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, OrderID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int orderDetailID = resultSet.getInt("orderDetailID");
                int productID = resultSet.getInt("productID");
                int sizeID = resultSet.getInt("sizeID");
                int quantity = resultSet.getInt("quantity");

                OrderDetail orderDetail = new OrderDetail(orderDetailID, OrderID, productID, quantity, sizeID);
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return orderDetails;
    }

    public int deleteListOrderDetailByOrderID(int orderID) {
        int result = 0;
        String sql = "DELETE FROM OrderDetail\n"
                + "      WHERE orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, orderID);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public static void main(String[] args) {
        System.out.println(new OrderDetailDAO().getOrderDetailInStatusCancelByOrderID(1068));
    }

}
