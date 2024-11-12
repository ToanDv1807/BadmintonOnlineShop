/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.common;

import dal.db.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import model.Customers;
import model.Invoice;
import model.Order;
import model.OrderDetail;
import model.Status;

/**
 *
 * @author MSI1
 */
public class OrderDAO extends DBContext {

    public int insertOrder(Order order) {
        int result = 0;
        String sql = "insert into Orders(customerID, orderDate, statusID, note, paymentMethod, addressName) values (?,?,?,?,?,?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, order.getCustomerID());
            statement.setObject(2, order.getOrderDate());
            statement.setObject(3, order.getOrderStatus());
            statement.setObject(4, order.getNote());
            statement.setObject(5, order.getPaymentMethod());
            statement.setObject(6, order.getAddressName());
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public List<Order> getOrdersByIndex(int index, int pageSize) {
        List<Order> list = new ArrayList<>();

        // Câu lệnh SQL sử dụng ROW_NUMBER() để chọn chỉ một bản ghi đại diện cho mỗi orderID
        String sql = """
    WITH RankedOrders AS (
        -- This CTE ranks the rows for each order based on orderID and orderDetailID
        SELECT o.orderID, o.orderDate, o.statusID, s.statusName, p.productName, c.fullName, od.quantity,
               -- Calculate lineAmount with the discount applied
               (od.price * od.quantity ) AS lineAmount,
               e.fullName AS salerName,
               ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num -- Select only the first row for each orderID
        FROM Orders o
        JOIN OrderDetail od ON o.orderID = od.orderID
        JOIN Products p ON od.productID = p.productID
        JOIN Customers c ON o.customerID = c.customerID
        JOIN Status s ON o.statusID = s.statusID
        JOIN OrderAssignment oa ON o.orderID = oa.orderID
        JOIN Employees e ON oa.employeeID = e.employeeID -- Join Employees to get the sales representative info
    ),
    OrderTotals AS (
        -- This CTE calculates the total amount for all products in each order
        SELECT orderID, SUM(lineAmount) AS totalAmount
        FROM RankedOrders
        GROUP BY orderID -- Group by orderID to calculate the total amount for the whole order
    )
    SELECT r.orderID, r.orderDate, r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName, r.quantity, r.salerName
    FROM RankedOrders r
    JOIN OrderTotals t ON r.orderID = t.orderID
    WHERE r.row_num = 1 -- Display only the first row for each orderID
    ORDER BY r.orderID
    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            // Thiết lập phân trang
            ps.setInt(1, (index - 1) * pageSize);  // Tính OFFSET dựa trên trang hiện tại và số bản ghi mỗi trang
            ps.setInt(2, pageSize);  // Số lượng bản ghi mỗi trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Order và thêm vào danh sách
                Order o = new Order();
                o.setOrderID(rs.getInt("orderID"));
                o.setOrderDate(rs.getString("orderDate"));  // Lấy giá trị của orderDate từ ResultSet
                o.setStatusName(rs.getString("statusName"));  // Lấy statusName từ ResultSet
                o.setTotalAmount(rs.getFloat("totalAmount"));  // Lấy tổng số tiền từ ResultSet
                o.setProductName(rs.getString("productName"));  // Lấy productName từ ResultSet
                o.setFullName(rs.getString("fullName"));  // Lấy tên khách hàng từ ResultSet
                o.setQuantity(rs.getInt("quantity"));  // Lấy quantity từ ResultSet
                o.setSaleName(rs.getString("salerName"));
                o.setOrderStatus(rs.getInt("statusID"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getOrdersByEmployee(int employeeID, int index, int pageSize) {
        List<Order> list = new ArrayList<>();

        // Câu lệnh SQL sử dụng CTE để xử lý dữ liệu, thêm statusID
        String sql = """
    WITH RankedOrders AS (
        SELECT o.orderID, o.orderDate, o.statusID, s.statusName, p.productName, c.fullName, od.quantity,
               -- Tính tổng tiền cho mỗi sản phẩm có tính đến khuyến mãi nếu có
               (od.price * od.quantity) AS lineAmount, 
               -- Đánh số thứ tự cho từng sản phẩm trong đơn hàng
               ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num 
        FROM Orders o
        JOIN OrderDetail od ON o.orderID = od.orderID
        JOIN Products p ON od.productID = p.productID
        JOIN Customers c ON o.customerID = c.customerID
        JOIN OrderAssignment oa ON o.orderID = oa.orderID -- Liên kết với OrderAssignment để lấy đơn hàng theo nhân viên
        JOIN Status s ON o.statusID = s.statusID -- Join với bảng Status để lấy statusName và statusID
        WHERE oa.employeeID = ? -- Lọc theo employeeID của nhân viên
    ),
    OrderTotals AS (
        -- Tính tổng tiền cho toàn bộ sản phẩm trong đơn hàng
        SELECT orderID, SUM(lineAmount) AS totalAmount
        FROM RankedOrders
        GROUP BY orderID
    )
    -- Chọn dòng cần hiển thị và tính tổng tiền của đơn hàng
    SELECT r.orderID, r.orderDate, r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName, r.quantity
    FROM RankedOrders r
    JOIN OrderTotals t ON r.orderID = t.orderID
    WHERE r.row_num = 1 -- Chỉ hiển thị dòng đầu tiên của mỗi đơn hàng
    ORDER BY r.orderID
    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try {
            // Thiết lập PreparedStatement và truyền các tham số
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID);  // Truyền employeeID vào câu truy vấn
            ps.setInt(2, (index - 1) * pageSize);  // Tính toán OFFSET dựa trên trang hiện tại và số bản ghi mỗi trang
            ps.setInt(3, pageSize);  // Số lượng bản ghi mỗi trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Order và thêm vào danh sách
                Order o = new Order();
                o.setOrderID(rs.getInt("orderID"));
                o.setOrderDate(rs.getString("orderDate"));
                o.setOrderStatus(rs.getInt("statusID"));  // Fetch statusID from result set
                o.setStatusName(rs.getString("statusName"));  // Fetch statusName from result set
                o.setTotalAmount(rs.getFloat("totalAmount"));
                o.setProductName(rs.getString("productName"));
                o.setFullName(rs.getString("fullName"));
                o.setQuantity(rs.getInt("quantity"));  // Fetch quantity from result set
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Handle exception properly
        }
        return list;
    }

    public int getTotalOfOrder() {
        String sql = "SELECT COUNT(DISTINCT o.orderID) -- Count distinct order IDs\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Trả về tổng số đơn hàng
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return 0;
    }

    public List<Order> searchOrder(int index, String keyword) {
        List<Order> list = new ArrayList<>();
        String sql = "WITH RankedOrders AS (\n"
                + "    SELECT o.orderID, o.orderDate, o.orderStatus, i.totalAmount, p.productName, c.fullName,\n" // Thêm cột fullName từ bảng Customers
                + "           ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num\n"
                + "    FROM Orders o\n"
                + "    JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "    JOIN Products p ON od.productID = p.productID\n"
                + "    JOIN Invoice i ON i.orderID = o.orderID\n"
                + "    JOIN Customers c ON o.customerID = c.customerID\n" // Thực hiện JOIN với bảng Customers
                + "    WHERE p.productName LIKE ?\n"
                + ")\n"
                + "SELECT orderID, orderDate, orderStatus, totalAmount, productName, fullName\n" // Bao gồm fullName trong kết quả
                + "FROM RankedOrders\n"
                + "WHERE row_num = 1\n"
                + "ORDER BY orderID\n"
                + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;";

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");  // Truyền keyword vào LIKE
            ps.setInt(2, (index - 1) * 10);  // Tính toán OFFSET

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                int orderStatus = rs.getInt("orderStatus");
                Date orderDate = rs.getDate("orderDate");
                String productName = rs.getString("productName");
                String fullName = rs.getString("fullName");  // Lấy tên khách hàng
                String orderDateString = dateFormat.format(orderDate);
                float price = rs.getFloat("totalAmount");

                // Tạo đối tượng Order với thông tin đầy đủ
                Order o = new Order(orderID, orderDateString, orderStatus, productName, 0, price, fullName);  // Gán fullName vào đối tượng Order
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return list;
    }

    public int getTotalSearch(String keyword) {
        String sql = "SELECT COUNT(DISTINCT o.orderID) -- Count distinct orders\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID\n"
                + "JOIN Invoice i ON i.orderID = o.orderID\n"
                + "WHERE p.productName LIKE ?;";  // Search for product name matching keyword

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");  // Use the keyword for product name search
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Return the count of matching orders
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return 0;
    }

    public float getToTalAmount() {
        String sql = "SELECT SUM(totalAmount)\n"
                + "FROM Orders o JOIN Invoice i ON o.orderID = i.orderID\n"
                + "WHERE o.statusID = 7";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat(1);
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return 0;
    }

    // Phương thức cập nhật trạng thái đơn hàng
    public void updateOrderStatus(int orderID, String newStatus) {
        String sql = "UPDATE Orders SET statusID = ? WHERE orderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderAssignmentStatus(int orderID, String newStatus) {
        String sql = "UPDATE OrderAssignment SET statusID = ? WHERE orderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, orderID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalOfOrdersByEmployee(int employeeID) {
        String sql = """
    SELECT COUNT(DISTINCT orderID)
    FROM OrderAssignment
    WHERE employeeID = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employeeID); // Bind employeeID
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the total number of orders
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the full stack trace
            System.err.println("Error executing query: " + e.getMessage());
        }
        return 0;
    }

    public List<Order> searchOrdersByEmployee(int employeeID, int index, String keyword) {
        List<Order> list = new ArrayList<>();
        String sql = """
        WITH RankedOrders AS (
            SELECT o.orderID, o.orderDate,o.statusID s.statusName, i.totalAmount, p.productName, c.fullName,
                   ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num
            FROM Orders o
            JOIN OrderDetail od ON o.orderID = od.orderID
            JOIN Products p ON od.productID = p.productID
            JOIN Invoice i ON i.orderID = o.orderID
            JOIN Customers c ON o.customerID = c.customerID
            JOIN OrderAssignment oa ON o.orderID = oa.orderID
            JOIN Status s ON o.statusID = s.statusID
            WHERE oa.employeeID = ? AND p.productName LIKE ?
        )
        SELECT orderID, orderDate,statusID, statusName, totalAmount, productName, fullName
        FROM RankedOrders
        WHERE row_num = 1
        ORDER BY orderID
        OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;
    """;

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID); // Bind employeeID
            ps.setString(2, "%" + keyword + "%");  // Bind keyword
            ps.setInt(3, (index - 1) * 10);  // Pagination

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                String statusName = rs.getString("statusName"); // Fetch statusName
                Date orderDate = rs.getDate("orderDate");
                String productName = rs.getString("productName");
                String fullName = rs.getString("fullName");
                String orderDateString = dateFormat.format(orderDate);
                float price = rs.getFloat("totalAmount");
                int statusID = rs.getInt("statusID");

                // Create Order object
                Order o = new Order(orderID, orderDateString, statusID, statusName, productName, 0, price, fullName);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSearchOrdersByEmployee(int employeeID, String keyword) {
        String sql = """
        WITH RankedOrders AS (
            SELECT o.orderID, o.orderDate, s.statusName, i.totalAmount, p.productName,
                   ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num
            FROM Orders o
            JOIN OrderDetail od ON o.orderID = od.orderID
            JOIN Products p ON od.productID = p.productID
            JOIN Invoice i ON i.orderID = o.orderID
            JOIN OrderAssignment oa ON o.orderID = oa.orderID
            JOIN Status s ON o.statusID = s.statusID
            WHERE oa.employeeID = ? AND p.productName LIKE ?
        )
        SELECT COUNT(*)
        FROM RankedOrders
        WHERE row_num = 1;
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, employeeID); // Bind employeeID
            ps.setString(2, "%" + keyword + "%"); // Bind keyword
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Return total number of matching orders
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> getOrders(String query, String fromDate, String toDate, String status, int employeeID, int index, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = """
    WITH RankedOrders AS (
        SELECT o.orderID, o.orderDate,o.statusID, s.statusName, p.productName, c.fullName, od.quantity,
               (od.price * od.quantity) AS lineAmount,
               ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY o.orderID) AS rowNum
        FROM Orders o
        JOIN OrderDetail od ON o.orderID = od.orderID
        JOIN Products p ON od.productID = p.productID
        JOIN Customers c ON o.customerID = c.customerID
        JOIN OrderAssignment oa ON o.orderID = oa.orderID
        JOIN Status s ON o.statusID = s.statusID
        WHERE oa.employeeID = ?
    """;

        // Thêm các điều kiện tìm kiếm
        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? ";
        }

        sql += """
    ),
    FilteredOrders AS (
        SELECT * FROM RankedOrders WHERE rowNum = 1
    ),
    OrderTotals AS (
        SELECT orderID, SUM(lineAmount) AS totalAmount
        FROM RankedOrders
        GROUP BY orderID
    )
    SELECT r.orderID, r.orderDate,r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName
    FROM FilteredOrders r
    JOIN OrderTotals t ON r.orderID = t.orderID
    WHERE r.rowNum = 1 -- Chỉ hiển thị một dòng cho mỗi orderID
    ORDER BY r.orderID
    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, employeeID); // Bind employeeID

            // Đặt các tham số tìm kiếm
            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            // Đặt phân trang
            ps.setInt(paramIndex++, (index - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderID(rs.getInt("orderID"));
                o.setOrderDate(rs.getString("orderDate"));
                o.setStatusName(rs.getString("statusName"));  // Lấy statusName
                o.setTotalAmount(rs.getFloat("totalAmount"));
                o.setProductName(rs.getString("productName"));
                o.setFullName(rs.getString("fullName"));
                o.setOrderStatus(rs.getInt("statusID"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOrders(String query, String fromDate, String toDate, String status, int employeeID) {
        String sql = """
        SELECT COUNT(DISTINCT o.orderID)
        FROM Orders o
        JOIN OrderAssignment oa ON o.orderID = oa.orderID
        JOIN Customers c ON o.customerID = c.customerID
        JOIN Status s ON o.statusID = s.statusID
        WHERE oa.employeeID = ?
    """;

        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? ";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            ps.setInt(paramIndex++, employeeID); // Bind employeeID

            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Return total count
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> getOrders2(String query, String fromDate, String toDate, String status, int index, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = """
    WITH RankedOrders AS (
        SELECT o.orderID, o.orderDate, o.statusID, s.statusName, p.productName, c.fullName, od.quantity, e.fullName AS salerName,
               (od.price * od.quantity) AS lineAmount,
               ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY o.orderDate) AS rn -- Phân số hàng theo orderID
        FROM Orders o
        JOIN OrderDetail od ON o.orderID = od.orderID
        JOIN Products p ON od.productID = p.productID
        JOIN Customers c ON o.customerID = c.customerID
        JOIN Status s ON o.statusID = s.statusID
        JOIN OrderAssignment oa ON o.orderID = oa.orderID
        JOIN Employees e ON oa.employeeID = e.employeeID
        WHERE 1=1
    """;

        // Add search conditions
        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ? OR e.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? "; // Ensure this is the correct ID
        }

        sql += """
    ),
    OrderTotals AS (
        SELECT orderID, SUM(lineAmount) AS totalAmount -- Tính tổng tiền cho mỗi Order
        FROM RankedOrders
        GROUP BY orderID -- Gom nhóm theo orderID để tính tổng tiền của đơn hàng
    )
    SELECT r.orderID, r.orderDate, r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName, r.salerName
    FROM RankedOrders r
    JOIN OrderTotals t ON r.orderID = t.orderID
    WHERE r.rn = 1 -- Chỉ hiển thị một dòng cho mỗi orderID
    ORDER BY r.orderID
    OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;

            // Set search parameters
            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status); // Bind statusID
            }

            // Set pagination parameters
            ps.setInt(paramIndex++, (index - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Create Order object and add to list
                    Order o = new Order();
                    o.setOrderID(rs.getInt("orderID"));
                    o.setOrderDate(rs.getString("orderDate"));
                    o.setStatusName(rs.getString("statusName"));
                    o.setTotalAmount(rs.getFloat("totalAmount"));
                    o.setProductName(rs.getString("productName"));
                    o.setFullName(rs.getString("fullName"));
                    o.setSaleName(rs.getString("salerName"));
                    o.setOrderStatus(rs.getInt("statusID"));
                    list.add(o);
                }
            }
        } catch (SQLException e) {
            // Consider using a logging framework
            e.printStackTrace();
        }
        return list;

    }

    public int getTotalOrders2(String query, String fromDate, String toDate, String status) {
        String sql = """
        SELECT COUNT(DISTINCT o.orderID)
        FROM Orders o
        JOIN Customers c ON o.customerID = c.customerID
        JOIN Status s ON o.statusID = s.statusID -- Join to get statusName
        WHERE 1=1
    """;

        // Add search conditions
        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ? OR e.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? ";  // Compare with statusName
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Set query search parameters
            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);  // Bind the statusName
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Return the total number of orders
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Customers getCustomerByOrderID(int orderID) {
        String sql = "select distinct c.fullName, c.customerID,c.email\n"
                + "from Orders o join Customers c on o.customerID =c.customerID\n"
                + "where o.orderID =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customers(rs.getString("fullName"), rs.getInt("customerID"), rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Integer> getProductIDByOIDAndCID(int orderID, int customerID) {
        List<Integer> list = new ArrayList<>();
        String sql = "select od.productID\n"
                + "from Orders o join OrderDetail od on o.orderID=od.orderID\n"
                + "where o.customerID=? and o.orderID =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerID);
            ps.setInt(2, orderID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Status> getAllStatuses() {
        List<Status> statusList = new ArrayList<>();
        String sql = "SELECT statusID, statusName, status,pre,post FROM Status";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Create a new Status object for each row
                Status status = new Status();
                status.setStatusID(rs.getInt("statusID"));
                status.setStatusName(rs.getString("statusName"));
                status.setStatus(rs.getInt("status"));
                status.setPre(rs.getInt("pre"));
                status.setPost(rs.getInt("post"));
                // Add the status to the list
                statusList.add(status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusList;
    }

    public int getOrderIdByCustomerID(int customerID) {
        String sql = "select top 1 o.orderID\n"
                + "from Orders o\n"
                + "where o.customerID = ?\n"
                + "order by o.orderID desc";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return 0;
    }

    public float getTotalAmountOfOrderByOrderID(int orderID) {
        String sql = "select sum(od.quantity * od.price)\n"
                + "from OrderDetail od\n"
                + "where od.orderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderID); // Bind employeeID
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Return the total number of orders
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Order getOrderByOrderID(int orderID) {
        Order order = null;
        String sql = "select *\n"
                + "from Orders o\n"
                + "where o.orderID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int customerID = rs.getInt("customerID");
                String orderDate = rs.getString("orderDate");
                int statusID = rs.getInt("statusID");
                String note = rs.getString("note");
                String paymentMethod = rs.getString("paymentMethod");
                String addressName = rs.getString("addressName");
                order = new Order(orderID, customerID, orderDate, statusID, note, paymentMethod, addressName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public int insertOrderAssignment(Order order) {
        int result = 0;
        String sql = "INSERT INTO OrderAssignment (orderID, employeeID, statusID)\n"
                + "VALUES (\n"
                + "?,\n"
                + "COALESCE(\n"
                + "(\n"
                + "SELECT employeeID\n"
                + "FROM (\n"
                + "SELECT e.employeeID, COALESCE(COUNT(oa.orderID), 0) AS orderCount\n"
                + "FROM Employees e\n"
                + "LEFT JOIN OrderAssignment oa ON e.employeeID = oa.employeeID AND oa.statusID = 2\n"
                + "join Role r on e.roleID = r.roleID\n"
                + "WHERE r.roleID = 3\n"
                + "GROUP BY e.employeeID\n"
                + ") AS subquery\n"
                + "ORDER BY orderCount ASC\n"
                + "OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY\n"
                + "),\n"
                + "CASE WHEN RAND() < 0.5 THEN 3 ELSE 6 END\n"
                + "),\n"
                + "2\n"
                + ");";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, order.getOrderID());
            result = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }

        return result;
    }

    public List<Status> getAllStatuses2() {
        List<Status> statusList = new ArrayList<>();
        String sql = "SELECT statusID, statusName, status FROM Status";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Create a new Status object for each row
                Status status = new Status();
                status.setStatusID(rs.getInt("statusID"));
                status.setStatusName(rs.getString("statusName"));
                status.setStatus(rs.getInt("status"));
                // Add the status to the list
                statusList.add(status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusList;
    }

    public List<Order> getOrdersForWarehouseByIndex(int index, int pageSize) {
        List<Order> list = new ArrayList<>();

        // Câu lệnh SQL sử dụng ROW_NUMBER() để chọn chỉ một bản ghi đại diện cho mỗi orderID
        String sql = """
      WITH RankedOrders AS (
                      SELECT o.orderID, o.orderDate,o.statusID, s.statusName, p.productName, c.fullName, od.quantity,
                             
                             ROW_NUMBER() OVER (PARTITION BY o.orderID ORDER BY od.orderDetailID) AS row_num
                      FROM Orders o
                      JOIN OrderDetail od ON o.orderID = od.orderID
                      JOIN Products p ON od.productID = p.productID
                      JOIN Customers c ON o.customerID = c.customerID
                      JOIN Status s ON o.statusID = s.statusID
                  	where o.statusID >=3 and o.statusID <= 8
                  ),
                  OrderTotals AS (
                      SELECT o.orderID, SUM(od.quantity * od.price) AS totalAmount
                      FROM OrderDetail od
                      JOIN Products p ON od.productID = p.productID
                      JOIN Orders o ON od.orderID = o.orderID
                      JOIN Customers c ON o.customerID = c.customerID
                      WHERE o.orderID IN (SELECT orderID FROM RankedOrders WHERE row_num = 1)  -- Đảm bảo chỉ tính cho các orderID hợp lệ
                      GROUP BY o.orderID
                  )
                  SELECT r.orderID, r.orderDate,r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName, r.quantity
                  FROM RankedOrders r
                  JOIN OrderTotals t ON r.orderID = t.orderID
                  WHERE r.row_num = 1
                  ORDER BY r.orderID
                  OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            // Thiết lập phân trang
            ps.setInt(1, (index - 1) * pageSize);  // Tính OFFSET dựa trên trang hiện tại và số bản ghi mỗi trang
            ps.setInt(2, pageSize);  // Số lượng bản ghi mỗi trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Order và thêm vào danh sách
                Order o = new Order();
                o.setOrderID(rs.getInt("orderID"));
                o.setOrderDate(rs.getString("orderDate"));  // Lấy giá trị của orderDate từ ResultSet
                o.setStatusName(rs.getString("statusName"));  // Lấy statusName từ ResultSet
                o.setTotalAmount(rs.getFloat("totalAmount"));  // Lấy tổng số tiền từ ResultSet
                o.setProductName(rs.getString("productName"));  // Lấy productName từ ResultSet
                o.setFullName(rs.getString("fullName"));  // Lấy tên khách hàng từ ResultSet
                o.setQuantity(rs.getInt("quantity"));  // Lấy quantity từ ResultSet
                o.setOrderStatus(rs.getInt("statusID"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOfOrderForWarehouse() {
        String sql = "SELECT COUNT(DISTINCT o.orderID) \n"
                + "FROM Orders o\n"
                + "JOIN OrderDetail od ON o.orderID = od.orderID\n"
                + "JOIN Products p ON od.productID = p.productID\n"
                + "where o.statusID >=3 and o.statusID <= 8";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Trả về tổng số đơn hàng
            }
        } catch (Exception e) {
            e.printStackTrace();  // Handle exception properly in production code
        }
        return 0;
    }

    public List<Status> getStatusForWarehouse() {
        List<Status> statusList = new ArrayList<>();
        String sql = "SELECT s.statusID, s.statusName, s.status,s.pre,s.post FROM Status s\n"
                + "where s.statusID >= 3 and s.statusID <= 8";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Create a new Status object for each row
                Status status = new Status();
                status.setStatusID(rs.getInt("statusID"));
                status.setStatusName(rs.getString("statusName"));
                status.setStatus(rs.getInt("status"));
                status.setPre(rs.getInt("pre"));
                status.setPost(rs.getInt("post"));
                // Add the status to the list
                statusList.add(status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statusList;
    }

    public List<Order> getOrdersForWarehouseBySearch(String query, String fromDate, String toDate, String status, int index, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = """
    WITH RankedOrders AS (
                    SELECT o.orderID, o.orderDate,o.statusID, s.statusName, p.productName, c.fullName, od.quantity,
                           -- Tính t?ng ti?n cho m?i s?n ph?m trong ??n hàng có áp d?ng khuy?n mãi n?u có
                           (od.quantity * od.price) as lineAmount
                    FROM Orders o
                    JOIN OrderDetail od ON o.orderID = od.orderID
                    JOIN Products p ON od.productID = p.productID
                    JOIN Customers c ON o.customerID = c.customerID
                    JOIN Status s ON o.statusID = s.statusID -- Join v?i b?ng Status ?? l?y tên tr?ng thái
                    WHERE 1=1 and o.statusID >=3 and o.statusID <= 8
    """;

        // Thêm điều kiện tìm kiếm
        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? ";  // So sánh theo statusID nếu có thêm điều kiện trạng thái
        }

        sql += """
     GROUP BY o.orderID, o.orderDate, s.statusName, p.productName, c.fullName, od.quantity,od.price,o.statusID
                ),
                OrderTotals AS (
                    SELECT orderID, SUM(lineAmount) AS totalAmount -- Tính t?ng ti?n cho m?i Order
                    FROM RankedOrders
                    GROUP BY orderID
                )
                SELECT r.orderID, r.orderDate,r.statusID, r.statusName, t.totalAmount, r.productName, r.fullName
                FROM RankedOrders r
                JOIN OrderTotals t ON r.orderID = t.orderID
                ORDER BY r.orderID
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
    """;

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Thiết lập các tham số tìm kiếm
            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);  // Thêm dòng này để set giá trị cho tham số status
            }

            // Thiết lập phân trang
            ps.setInt(paramIndex++, (index - 1) * pageSize);
            ps.setInt(paramIndex++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tạo đối tượng Order và thêm vào danh sách
                Order o = new Order();
                o.setOrderID(rs.getInt("orderID"));
                o.setOrderDate(rs.getString("orderDate"));
                o.setStatusName(rs.getString("statusName"));  // Fetch statusName from result set
                o.setTotalAmount(rs.getFloat("totalAmount"));
                o.setProductName(rs.getString("productName"));
                o.setFullName(rs.getString("fullName"));
                o.setOrderStatus(rs.getInt("statusID"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOrdersForWarehouseBySearch(String query, String fromDate, String toDate, String status) {
        String sql = """
         SELECT COUNT(DISTINCT o.orderID)
                         FROM Orders o
                         JOIN Customers c ON o.customerID = c.customerID
                         JOIN Status s ON o.statusID = s.statusID -- Join to get statusName
                         WHERE 1=1 and o.statusID >= 3 and o.statusID <= 8
    """;

        // Add search conditions
        if (query != null && !query.isEmpty()) {
            sql += "AND (o.orderID LIKE ? OR c.fullName LIKE ?) ";
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql += "AND o.orderDate >= ? ";
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += "AND o.orderDate <= ? ";
        }
        if (status != null && !status.isEmpty()) {
            sql += "AND s.statusID = ? ";  // Compare with statusName
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;

            // Set query search parameters
            if (query != null && !query.isEmpty()) {
                ps.setString(paramIndex++, "%" + query + "%");
                ps.setString(paramIndex++, "%" + query + "%");
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);  // Bind the statusName
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Return the total number of orders
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int insertOrderToInvoice(Invoice invoice) {
        int result = 0;
        String sql = "INSERT INTO Invoice\n"
                + "(orderID,invoiceDate,totalAmount,paymentMethod) VALUES\n"
                + "(?,?,?,?)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, invoice.getOrderID());
            statement.setObject(2, invoice.getInvoiceDate());
            statement.setObject(3, invoice.getTotalAmount());
            statement.setObject(4, invoice.getPaymentMethod());
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public float getPriceAfterDiscount(int productID, int sizeID) {
        String sql = "select pas.price - (pas.price * d.DiscountRate / 100)\n"
                + "from DiscountedProducts d\n"
                + "join Product_Attribute_Stock pas on d.productID = pas.productID and d.sizeID = pas.sizeID\n"
                + "join Promotion p on p.PromotionID = d.promotionID\n"
                + "where d.productID = ? and d.sizeID = ? and p.Status = 1 and p.StartDate <= ? and p.EndDate >= ?";
        String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID); // Bind employeeID
            ps.setObject(2, sizeID); // Bind employeeID
            ps.setObject(3, currentDate); // Bind employeeID
            ps.setObject(4, currentDate); // Bind employeeID
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Return the total number of orders
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Timestamp getStartDateDiscountEachProduct(int productID, int sizeID) {
        Timestamp startDate = null;
        String sql = "SELECT p1.StartDate "
                + "FROM Promotion p1 "
                + "JOIN DiscountedProducts d ON p1.promotionID = d.promotionID "
                + "WHERE d.productID = ? AND d.sizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID); // Bind productID
            ps.setObject(2, sizeID); // Bind sizeID
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                startDate = rs.getTimestamp("StartDate");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return startDate; // Trả về null nếu không tìm thấy bản ghi phù hợp
    }

    public Timestamp getEndDateDiscountEachProduct(int productID, int sizeID) {
        Timestamp endDate = null;
        String sql = "SELECT p1.EndDate "
                + "FROM Promotion p1 "
                + "JOIN DiscountedProducts d ON p1.promotionID = d.promotionID "
                + "WHERE d.productID = ? AND d.sizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, productID); // Bind productID
            ps.setObject(2, sizeID); // Bind sizeID
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                endDate = rs.getTimestamp("EndDate");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return endDate; // Trả về null nếu không tìm thấy bản ghi phù hợp
    }

    public int deleteOrderAssignmentByOrderID(int orderID) {
        int result = 0;
        String sql = "DELETE FROM OrderAssignment \n"
                + "      WHERE orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, orderID);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public int deleteOrderByOrderID(int orderID) {
        int result = 0;
        String sql = "DELETE FROM Orders \n"
                + "      WHERE orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, orderID);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }

    public int deleteInvoiceByOrderID(int orderID) {
        int result = 0;
        String sql = "DELETE FROM Orders \n"
                + "      WHERE orderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setObject(1, orderID);
            result = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception properly in production code
        }
        return result;
    }
    
    public String getStatusByOrderID(int orderID) {
        String sql = "select s.statusName\n"
                + "from Orders o\n"
                + "join Status s on o.statusID = s.statusID\n"
                + "where o.orderID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setObject(1, orderID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("statusName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(new OrderDAO().getPriceAfterDiscount(1, 3));
    }
}
