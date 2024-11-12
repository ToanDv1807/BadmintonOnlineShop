package controller.seller.order;

import dal.mail.Email;
import dal.customer.FeedbackDAO;
import dal.common.OrderDAO;
import dal.common.OrderDetailDAO;
import dal.common.PermissionDAO;
import dal.marketer.AttributeDAO;
import dal.marketer.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Customers;
import model.Invoice;
import model.Order;
import model.Product_Attribute_Stock;
import model.Products;
import model.Status;

public class SaleManagerOrderList extends HttpServlet {
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
            HttpSession session = request.getSession();
            String search = request.getParameter("query");
            OrderDAO orderDAO = new OrderDAO();  // Lấy OrderDAO

            // Nếu không có từ khóa tìm kiếm
            if (search == null) {
                String indexPage = request.getParameter("page");
                int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

                int pageSize = 5;  // Số lượng đơn hàng trên mỗi trang
                List<Order> listOrder = orderDAO.getOrdersByIndex(index, pageSize);  // Truyền pageSize vào phương thức
                int totalOrders = orderDAO.getTotalOfOrder();  // Lấy tổng số đơn hàng
                int totalPages = (totalOrders % pageSize == 0) ? totalOrders / pageSize : (totalOrders / pageSize) + 1;
                List<Status> statusList = orderDAO.getAllStatuses();
                // Đặt danh sách đơn hàng và thông tin phân trang vào request để hiển thị trong JSP
                request.setAttribute("list", listOrder);
                request.setAttribute("endP", totalPages);
                request.setAttribute("currentPage", index);
                request.setAttribute("statusList", statusList);
                request.getRequestDispatcher("sale_manager_order_list.jsp").forward(request, response);
            } else {
                handleSearch(request, response, orderDAO, search);
            }
        }
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO, String search) throws ServletException, IOException {
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String status = request.getParameter("status");
        String indexPage = request.getParameter("page");
        int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

        int pageSize = 5;

        // Lấy danh sách đơn hàng của nhân viên hiện tại theo từ khóa, khoảng thời gian và trạng thái
        List<Order> listOrder = orderDAO.getOrders2(search, fromDate, toDate, status, index, pageSize);
        int totalOrders = orderDAO.getTotalOrders2(search, fromDate, toDate, status);  // Tổng số đơn hàng tìm kiếm được
        int totalPages = (totalOrders % pageSize == 0) ? totalOrders / pageSize : (totalOrders / pageSize) + 1;
        List<Status> statusList = orderDAO.getAllStatuses();
        // Đặt danh sách đơn hàng và thông tin phân trang vào request để hiển thị trong JSP
        request.setAttribute("list", listOrder);
        request.setAttribute("endP", totalPages);
        request.setAttribute("currentPage", index);
        request.setAttribute("statusList", statusList);

        request.getRequestDispatcher("sale_manager_order_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkSessionAndRole(request, response)) {
            // Xử lý thay đổi trạng thái đơn hàng
            String orderIDRaw = request.getParameter("orderID");
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

            Timestamp orderDateTimestamp = new Timestamp(new Date().getTime());

            if (Integer.parseInt(newStatus) == 3) {
                Order order = orderDAO.getOrderByOrderID(orderID);
                Invoice invoice = new Invoice(orderID, orderDateTimestamp.toString(), orderDAO.getTotalAmountOfOrderByOrderID(orderID), order.getPaymentMethod());
                orderDAO.insertOrderToInvoice(invoice);
            }

            //Gửi link cho khách hàng feedback nếu status =1
            if (Integer.parseInt(newStatus) == 7) {
                Customers c = orderDAO.getCustomerByOrderID(orderID);
                String subject = "We'd Love to Hear Your Feedback!";
                String noidung = "Dear " + c.getFullName() + ",\n\n"
                        + "Thank you for being a valued customer of our store. We strive to provide the best experience for you.\n"
                        + "We would greatly appreciate it if you could take a moment to share your feedback with us by clicking the link below:\n\n";
                noidung = noidung + "http://localhost:9999/OnlineShop_SWP391/viewProductToFeedback?orderID=" + orderID + "\n";
                noidung += "Your opinion matters to us, and we hope to hear from you soon!\n\nBest regards,\nSport Store Team";
                Email.SendEmails(c.getEmail(), subject, noidung);
            }

            // Quay lại trang dashboard sau khi cập nhật
            response.sendRedirect("SaleManagerOrderList");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    public String getServletInfo() {
        return "Sale Manager Dashboard Servlet";
    }
}
