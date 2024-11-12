package controller.common.dashboard;

import dal.warehouse.WarehouseDAO;
import dal.marketer.SizeDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.ProductDAO;
import dal.common.PermissionDAO;
import dal.common.OrderDetailDAO;
import dal.common.OrderDAO;
import dal.marketer.MarketerDAO;
import dal.mail.Email;
import dal.marketer.CategoryDAO;
import dal.marketer.BrandDAO;
import dal.marketer.AttributeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import model.*;

public class WarehouseDashboard extends HttpServlet {

    private final OrderDetailDAO orderDetailDao = new OrderDetailDAO();
    private final AttributeDAO attributeDAO = new AttributeDAO();
    private final ProductDAO productDao = new ProductDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    // Method to check session and role access
    private boolean checkSessionAndRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login.jsp");
            return false;
        }

        Account account = (Account) session.getAttribute("account");
        if (!"Employee".equals(account.getUserType())) {
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        PermissionDAO permissionDAO = new PermissionDAO();
        String currentUrl = request.getRequestURL().toString();
        int roleID = account.getRoleID();

        List<String> allowedUrls = permissionDAO.getPermissionsByRole(roleID);
        if (!allowedUrls.contains(currentUrl)) {
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (checkSessionAndRole(request, response)) {
            MarketerDAO md = new MarketerDAO();
            WarehouseDAO wd = new WarehouseDAO();
            HttpSession session = request.getSession(false);
            Account account = (Account) session.getAttribute("account");
            Employees e = md.getEmployeeByEmail(account.getEmail());

            String[] dateRange = processDateRange(request, session);
            String startDate = dateRange[0];
            String endDate = dateRange[1];

            processStatistics(session, wd, startDate, endDate);
            processProductList(request, session, new CategoryDAO(), new BrandDAO(), new ProductDAO(), new PromotionDAO());
            getDataOrderList(request, response);

            session.setAttribute("employee", e);
            request.getRequestDispatcher("warehouse_dashboard.jsp").forward(request, response);
        }
    }

    private String[] processDateRange(HttpServletRequest request, HttpSession session) {
        LocalDate currentDate = LocalDate.now();
        String startDate = request.getParameter("startdate");
        String endDate = request.getParameter("enddate");

        if ((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty())) {
            startDate = currentDate.minusDays(7).format(DateTimeFormatter.ISO_DATE);
            endDate = currentDate.format(DateTimeFormatter.ISO_DATE);
        } else if ((startDate == null || startDate.isEmpty())) {
            startDate = "2023-01-01"; // Mặc định nếu không có ngày bắt đầu
            session.setAttribute("endDate", endDate);
        } else if ((endDate == null || endDate.isEmpty())) {
            endDate = currentDate.format(DateTimeFormatter.ISO_DATE);
            session.setAttribute("startDate", startDate);
        } else {
            session.setAttribute("startDate", startDate);
            session.setAttribute("endDate", endDate);
        }

        return new String[]{startDate, endDate};
    }

    private void processProductList(HttpServletRequest request, HttpSession session, CategoryDAO cd, BrandDAO bd, ProductDAO pd, PromotionDAO prd) {
        SizeDAO sd = new SizeDAO();

        // Lấy tham số từ request
        String categoryProduct = request.getParameter("categoryProduct");
        String brandProduct = request.getParameter("brandProduct");
        String statusProduct = request.getParameter("statusProduct");

        // Lấy danh sách sản phẩm đã lọc
        List<Products> filterProduct = pd.getFilteredProductManagement(categoryProduct, brandProduct, statusProduct);
        List<Size> listMinSize = sd.getMinImportPrices();
        // Thiết lập các thuộc tính cho session
        session.setAttribute("categories", cd.getAllCategories());
        session.setAttribute("brands", bd.getAllBrands());
        session.setAttribute("products", pd.getAllProducts());
        session.setAttribute("images", pd.getAllProductImage());
        session.setAttribute("promotions", prd.getAllPromotions());
        session.setAttribute("productAttributesWarehouse", attributeDAO.getAllProduct_Attribute_Stock());
        session.setAttribute("filterProduct", filterProduct);
        session.setAttribute("categoryProductTag", categoryProduct);
        session.setAttribute("brandProductTag", brandProduct);
        session.setAttribute("statusProductTag", statusProduct);
        session.setAttribute("minSizeWarehouse", listMinSize);
        // Cập nhật trạng thái sản phẩm nếu có tham số
        String statusProductRaw = request.getParameter("setStatus");
        String productIDRaw = request.getParameter("productID");

        if (isValidStatusUpdate(statusProductRaw, productIDRaw)) {
            int statusToShowOrHideProduct = Integer.parseInt(statusProductRaw);
            int productIDToSetStatus = Integer.parseInt(productIDRaw);

            // Lấy kích thước tương ứng với sản phẩm
            session.setAttribute("sizes", sd.getAllSizesByProductID(productIDToSetStatus));

            // Cập nhật trạng thái cho sản phẩm
            pd.setShowOrHideForProduct(statusToShowOrHideProduct, productIDToSetStatus);
        }
    }

// Phương thức hỗ trợ để kiểm tra tính hợp lệ của tham số
    private boolean isValidStatusUpdate(String statusProductRaw, String productIDRaw) {
        return statusProductRaw != null && !statusProductRaw.isEmpty() && productIDRaw != null && !productIDRaw.isEmpty();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        handleHoldAndQuantityProduct(request, response, session);
        response.sendRedirect("WarehouseServlet");
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, OrderDAO orderDAO, String search, HttpSession session) throws ServletException, IOException {
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String status = request.getParameter("status");
        String indexPage = request.getParameter("page");
        int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

        int pageSize = 5;

        List<Order> listOrder = orderDAO.getOrdersForWarehouseBySearch(search, fromDate, toDate, status, index, pageSize);
        int totalOrders = orderDAO.getTotalOrdersForWarehouseBySearch(search, fromDate, toDate, status);
        int totalPages = (totalOrders % pageSize == 0) ? totalOrders / pageSize : (totalOrders / pageSize) + 1;
        List<Status> statusList = orderDAO.getStatusForWarehouse();

        session.setAttribute("listOrderList", listOrder);
        session.setAttribute("endOrderList", totalPages);
        session.setAttribute("currentPageOrderList", index);
        session.setAttribute("statusOrderList", statusList);

    }

    private void handleHoldAndQuantityProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        String orderIDRaw = request.getParameter("orderID");
        String newStatus = request.getParameter("newStatus");

        int orderID = Integer.parseInt(orderIDRaw);
        orderDAO.updateOrderStatus(orderID, newStatus);
        orderDAO.updateOrderAssignmentStatus(orderID, newStatus);

        List<OrderDetail> listOrderDetailDelivering = orderDetailDao.getOrderDetailInStatusDeliveringByOrderID(orderID);
        if (listOrderDetailDelivering != null) {
            listOrderDetailDelivering.forEach(od -> {
                Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(od.getProductID(), od.getSizeID());

                Products product = productDao.getProductById(od.getProductID());
                stockInfo.setHold(stockInfo.getHold() - od.getQuantity());
                stockInfo.setStock(stockInfo.getStock() - od.getQuantity());
                attributeDAO.updateStock(stockInfo.getStock(), stockInfo.getProductID(), stockInfo.getSizeID());
                attributeDAO.updateHold(stockInfo.getHold(), stockInfo.getProductID(), stockInfo.getSizeID());
                product.setQuantity(product.getQuantity() - od.getQuantity());
                productDao.updateQuantityProduct(product);
            });
        }
        List<OrderDetail> listOrderDetailCancel = orderDetailDao.getOrderDetailInStatusCancelByOrderID(orderID);
        if (listOrderDetailCancel != null) {
            listOrderDetailCancel.forEach(od -> {
                Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(od.getProductID(), od.getSizeID());

                Products product = productDao.getProductById(od.getProductID());
                stockInfo.setStock(stockInfo.getStock() + od.getQuantity());
                attributeDAO.updateStock(stockInfo.getStock(), stockInfo.getProductID(), stockInfo.getSizeID());
                product.setQuantity(product.getQuantity() + od.getQuantity());
                productDao.updateQuantityProduct(product);
            });
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

    }

    private void getDataOrderList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String search = request.getParameter("query");

        if (search == null) {
            String indexPage = request.getParameter("page");
            int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage);

            int pageSize = 5;
            List<Order> listOrder = orderDAO.getOrdersForWarehouseByIndex(index, pageSize);
            int totalOrders = orderDAO.getTotalOfOrderForWarehouse();
            int totalPages = (totalOrders % pageSize == 0) ? totalOrders / pageSize : (totalOrders / pageSize) + 1;
            List<Status> statusList = orderDAO.getStatusForWarehouse();

            session.setAttribute("listOrderList", listOrder);
            session.setAttribute("endOrderList", totalPages);
            session.setAttribute("currentPageOrderList", index);
            session.setAttribute("statusOrderList", statusList);
        } else {
            handleSearch(request, response, orderDAO, search, session);
        }
    }

    private void processStatistics(HttpSession session, WarehouseDAO wd, String startDate, String endDate) {
        int totalProductsByDate = wd.getProductsByCreatedDate(startDate, endDate).size();
        int totalOrderByDate = wd.getOrdersByCreatedDate(startDate, endDate).size();
        double totalImportCost = wd.getTotalImportCostByDate(startDate, endDate);

        Map<String, Integer> newCustomersMap = wd.getOrderSuccessLast7Days();
        session.setAttribute("newCustomersMap", newCustomersMap);

        Map<String, Integer> orderStatusCountMap = wd.getOrderStatusDistribution();
        session.setAttribute("orderStatusCountMap", orderStatusCountMap);

        session.setAttribute("totalProducts", totalProductsByDate);
        session.setAttribute("totalOrders", totalOrderByDate);
        session.setAttribute("totalImport", totalImportCost);
    }

}
