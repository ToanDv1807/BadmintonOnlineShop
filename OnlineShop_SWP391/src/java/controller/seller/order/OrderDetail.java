package controller.seller.order;

import dal.mail.Email;
import dal.common.OrderDetailDAO;
import model.Order;
import java.util.List;
import model.Employees;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Status;
import dal.common.OrderDAO;
import dal.common.PermissionDAO;
import dal.marketer.AttributeDAO;
import dal.marketer.ProductDAO;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Customers;
import model.Product_Attribute_Stock;
import model.Products;

public class OrderDetail extends HttpServlet {
    OrderDetailDAO orderDetailDao = new OrderDetailDAO();
    AttributeDAO attributeDAO = new AttributeDAO();
    ProductDAO productDao = new ProductDAO();
    
 // Phương thức kiểm tra session và quyền truy cập
    private boolean checkSessionAndRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo session mới nếu không tồn tại
        if (session == null || session.getAttribute("account") == null) {
            // Nếu không có session hoặc chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return false;
        }

        Account account = (Account) session.getAttribute("account");
        if (!"Employee".equals(account.getUserType())) {
            // Nếu không phải là nhân viên chuyển hướng đến trang lỗi hoặc đăng nhập
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        // Kiểm tra quyền truy cập dựa vào URL
        PermissionDAO permissionDAO = new PermissionDAO();
        String currentUrl = request.getRequestURL().toString();
        int roleID = account.getRoleID();

        // Lấy danh sách các URL mà roleID có thể truy cập
        List<String> allowedUrls = permissionDAO.getPermissionsByRole(roleID);

        // Kiểm tra nếu URL hiện tại nằm trong danh sách URL được phép
        if (!allowedUrls.contains(currentUrl)) {
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        return true; // Nếu session và quyền hợp lệ, cho phép tiếp tục truy cập
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkSessionAndRole(request, response)) {
        // Lấy orderID từ tham số yêu cầu
        String orderIdParam = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdParam);

        // Gọi DAO để lấy thông tin chi tiết đơn hàng
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        Order order = orderDetailDAO.getOrderDetails(orderId);
        OrderDAO orderDAO= new OrderDAO();
        
        // Lấy danh sách nhân viên từ EmployeeDAO (để hiển thị trong dropdown)
        List<Employees> employees = orderDetailDAO.getAllEmployees();
        List<Status> statusList = orderDAO.getAllStatuses();
        
        // Đưa thông tin đơn hàng và danh sách nhân viên vào request attribute để truyền sang JSP
        request.setAttribute("order", order);
        request.setAttribute("employees", employees);
        request.setAttribute("statusList", statusList);
        
        // Chuyển sang trang JSP để hiển thị
        request.getRequestDispatcher("order_detail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
if (checkSessionAndRole(request, response)) {
        // Lấy orderID và saleName từ request
        String orderIdParam = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdParam);
        String saleName = request.getParameter("employeeName");  // Lấy tên nhân viên từ request
        String newStatus = request.getParameter("newStatus");    // Lấy trạng thái mới từ request

        // Gọi DAO để cập nhật nhân viên bán hàng cho đơn hàng
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        orderDetailDAO.updateOrderSaler(orderId, saleName);  // Truyền saleName để cập nhật
        
        // Nếu trạng thái không rỗng, gọi hàm thay đổi trạng thái
        if (newStatus != null && !newStatus.isEmpty()) {
            changeStatus(request, response);  // Gọi hàm changeStatus
        }

        // Quay lại trang chi tiết đơn hàng sau khi cập nhật
        response.sendRedirect("OrderDetail?orderId=" + orderId);
}
    }
    
    private void changeStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkSessionAndRole(request, response)) {
        // Xử lý thay đổi trạng thái đơn hàng
        String orderIDRaw = request.getParameter("orderId");
        String newStatus = request.getParameter("newStatus");

        // Gọi DAO để cập nhật trạng thái đơn hàng
        OrderDAO orderDAO = new OrderDAO();
        int orderID = Integer.parseInt(orderIDRaw);
        orderDAO.updateOrderStatus(orderID, newStatus);
        orderDAO.updateOrderAssignmentStatus(orderID, newStatus);
        List<model.OrderDetail> listOrderDetailCancelBySeller = orderDetailDao.getOrderDetailInStatusCancelBySellerByOrderID(orderID);
            if (listOrderDetailCancelBySeller != null) {
                listOrderDetailCancelBySeller.forEach(od -> {
                    Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(od.getProductID(), od.getSizeID());

                    stockInfo.setHold(stockInfo.getHold() - od.getQuantity());
                    attributeDAO.updateHold(stockInfo.getHold(), stockInfo.getProductID(), stockInfo.getSizeID());
                });
            }
        
        // Gửi link cho khách hàng feedback nếu status = 7 (hoàn thành)
        if (Integer.parseInt(newStatus) == 7) {
            Customers c = orderDAO.getCustomerByOrderID(orderID);
            String subject = "We'd Love to Hear Your Feedback!";
            String noidung = "Dear " + c.getFullName() + ",\n\n"
                    + "Thank you for being a valued customer of our store. We strive to provide the best experience for you.\n"
                    + "We would greatly appreciate it if you could take a moment to share your feedback with us by clicking the link below:\n\n";
            noidung += "http://localhost:9999/OnlineShop_SWP391/viewProductToFeedback?orderID=" + orderID + "\n";
            noidung += "Your opinion matters to us, and we hope to hear from you soon!\n\nBest regards,\nSport Store Team";
            Email.SendEmails(c.getEmail(), subject, noidung);
        }
        }
    }
}
