package controller.common.dashboard;

import dal.marketer.AttributeDAO;
import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.DAOBlog;
import dal.marketer.MarketerDAO;
import dal.common.PermissionDAO;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.SizeDAO;
import dal.marketer.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Blog;
import model.BlogCategories;
import model.Brand;
import model.Category;
import model.Customers;
import model.Employees;
import model.Feedback;
import model.Order;
import model.OrderDetail;
import model.ProductImage;
import model.Products;
import model.Promotion;
import model.Size;
import model.Slider;
import org.apache.jasper.tagplugins.jstl.core.ForEach;

public class MarketerDashboard extends HttpServlet {

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
            MarketerDAO md = new MarketerDAO();
            HttpSession session = request.getSession(false);
            Account account = (Account) session.getAttribute("account");
            Employees e = md.getEmployeeByEmail(account.getEmail());

            String[] dateRange = processDateRange(request, session);
            String startDate = dateRange[0];
            String endDate = dateRange[1];

            DAOBlog db = new DAOBlog();
            SliderDAO sd = new SliderDAO();
            PromotionDAO pd = new PromotionDAO();
            String index_raw = request.getParameter("index");
            int index = (index_raw == null) ? 1 : Integer.parseInt(index_raw);

            processBlogList(request, session, db, index, md);
            processFilteredBlogs(request, session, md);
            processStatistics(session, md, startDate, endDate);
            processProductList(request, session, new CategoryDAO(), new BrandDAO(), new ProductDAO(), new PromotionDAO());
            processFeedbackList(request, session, md);
            processCustomerList(request, session, md, index);
            processFilteredCustomers(request, session, md);
            processSliderList(request, session, sd, index, md);
            processFilteredSliders(request, session, md);
            processPromotionList(request, session, pd, index);
            processFilteredPromotions(request, session, pd);
            session.setAttribute("employee", e);
            request.getRequestDispatcher("marketer_dashboard.jsp").forward(request, response);
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

    private void processBlogList(HttpServletRequest request, HttpSession session, DAOBlog db, int index, MarketerDAO md) {
        int count = db.getTotalBlogs();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }

        List<Blog> blogs = db.pagingBlogForMKT(index);
        List<BlogCategories> cateBlogs = db.getAllBlogCategories();
        List<Employees> allEmployees = md.getAllEmployees();
        List<Employees> allMarketers = md.getAllEmployeesIsMarketer();
        session.setAttribute("employees", allEmployees);
        session.setAttribute("marketers", allMarketers);
        session.setAttribute("cateBlogs", cateBlogs);
        session.setAttribute("paginatedBlogs", blogs);
        session.setAttribute("tag", index);
        session.setAttribute("endPage", endPage);
    }

    private void processFilteredBlogs(HttpServletRequest request, HttpSession session, MarketerDAO md) {
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        String status = request.getParameter("status");
        String searchTitle = request.getParameter("searchTitle");

        List<Blog> filterBlog = md.getFilteredBlogs(category, author, status, searchTitle);
        session.setAttribute("filteredBlogs", filterBlog);
        session.setAttribute("categoryTag", category);
        session.setAttribute("authorTag", author);
        session.setAttribute("statusTag", status);
        session.setAttribute("searchTag", searchTitle);
        session.setAttribute("blogs", filterBlog);
    }

    private void processStatistics(HttpSession session, MarketerDAO md, String startDate, String endDate) {
        int totalCustomersByDate = md.getCustomersByCreatedDate(startDate, endDate).size();
        int totalProductsByDate = md.getProductsByCreatedDate(startDate, endDate).size();
        int totalBlogsByDate = md.getBlogsByCreatedDate(startDate, endDate).size();
        int totalSlidersByDate = md.getSlidersByCreatedDate(startDate, endDate).size();
        int totalFeedBack = md.getFeebackByFeedbackDate(startDate, endDate).size();
        List<Order> listOrderByDate = md.getOrderSuccessByDate(startDate, endDate);
        float totalPrice = 0;
        for (Order item : listOrderByDate) {
            totalPrice += md.getPriceByOrderID(item.getOrderID());
        }
        float totalImportPrice = 0;
        for (Order item : listOrderByDate) {
            List<OrderDetail> list = md.getOrderDetailByOrderID(item.getOrderID());
            for (OrderDetail item1 : list) {
                 float importPriceEachProduct = md.getImportPriceByProductIdAndSizeID(item1.getProductID(), item1.getSizeID());
                 totalImportPrice += importPriceEachProduct * item1.getQuantity();
            }
        }
        float profit = totalPrice - totalImportPrice;

        Map<String, Integer> newCustomersMap = md.getNewCustomersLast7Days();
        session.setAttribute("newCustomersMap", newCustomersMap);

        Map<String, Integer> productCountMap = md.getProductCountByCategory();
        session.setAttribute("productCountMap", productCountMap);
        session.setAttribute("totalIncome", profit);
        session.setAttribute("totalCustomers", totalCustomersByDate);
        session.setAttribute("totalProducts", totalProductsByDate);
        session.setAttribute("totalBlogs", totalBlogsByDate);
        session.setAttribute("totalSliders", totalSlidersByDate);
        session.setAttribute("totalFeedbacks", totalFeedBack);
    }

    private void processProductList(HttpServletRequest request, HttpSession session, CategoryDAO cd, BrandDAO bd, ProductDAO pd, PromotionDAO prd) {
        //ProductList
        SizeDAO sd = new SizeDAO();
        AttributeDAO ad = new AttributeDAO();
        String categoryProduct = request.getParameter("categoryProduct");
        String brandProduct = request.getParameter("brandProduct");
        String statusProduct = request.getParameter("statusProduct");

        List<Products> filterProduct = pd.getFilteredProductManagement(categoryProduct, brandProduct, statusProduct);

        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Products> listPro = pd.getAllProducts();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<Size> listMinSize = sd.getMinPriceSizes();
        session.setAttribute("categories", listCat);
        session.setAttribute("brands", listBrands);
        session.setAttribute("products", listPro);
        session.setAttribute("images", listImage);
        session.setAttribute("promotions", listPromotion);
        session.setAttribute("filterProduct", filterProduct);
        session.setAttribute("categoryProductTag", categoryProduct);
        session.setAttribute("brandProductTag", brandProduct);
        session.setAttribute("statusProductTag", statusProduct);
        session.setAttribute("productAttributes", ad.getAllProduct_Attribute_Stock());
        session.setAttribute("minSize", listMinSize);

        // Handle Show/Hide Product
        String statusProduct_raw = request.getParameter("setStatus");
        String productID_raw = request.getParameter("productID");
        if (statusProduct_raw != null && !statusProduct_raw.isEmpty() && productID_raw != null && !productID_raw.isEmpty()) {
            int statusToShowOrHideProduct = Integer.parseInt(statusProduct_raw);
            int productIDToSetStatus = Integer.parseInt(productID_raw);
            // Update status in the database
            pd.setShowOrHideForProduct(statusToShowOrHideProduct, productIDToSetStatus);
        }
    }

    private void processFeedbackList(HttpServletRequest request, HttpSession session, MarketerDAO md) {
        String filterfp = request.getParameter("filterfp");
        String filterfr = request.getParameter("filterfr");
        String searchf = request.getParameter("productFilter");
        String indexPage = request.getParameter("pagef");

// Default to page 1 if no page is provided
        int indexf = (indexPage == null || indexPage.isEmpty()) ? 1 : Integer.parseInt(indexPage);

        int pageSize = 10; // Set page size
        List<Feedback> listf = md.getAllFeedBacks(indexf, filterfr, filterfp, searchf);
        List<String> listp = md.getProductName();
        int countf = md.countFeedback(filterfr, filterfp, searchf);

// Calculate the total number of pages
        int endPagef = (countf + pageSize - 1) / pageSize; // Round up the number of pages

// Store relevant data in session attributes for use in JSP
        session.setAttribute("endPf", endPagef);
        session.setAttribute("listp", listp);
        session.setAttribute("currentPagef", indexf);
        session.setAttribute("listFeedback", listf);
        session.setAttribute("productFilter", searchf);
        session.setAttribute("filterfp", filterfp);
        session.setAttribute("filterfr", filterfr);
    }

    private void processCustomerList(HttpServletRequest request, HttpSession session, MarketerDAO md, int index) {
        int count = md.getTotalCustomers();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        List<Customers> customers = md.getCustomersPaginated(index);
        session.setAttribute("customers", customers);
        session.setAttribute("tagCL", index);
        session.setAttribute("endPageCL", endPage);
    }

    private void processFilteredCustomers(HttpServletRequest request, HttpSession session, MarketerDAO md) {
        String status = request.getParameter("statusC");
        String searchTitle = request.getParameter("searchTitleC");

// Call the new filtering method
        List<Customers> filterCustomers = md.getFilteredCustomers(status, searchTitle);
        session.setAttribute("filteredCustomers", filterCustomers);
        session.setAttribute("statusTagC", status);
        session.setAttribute("searchTagC", searchTitle);
        session.setAttribute("customersCL", filterCustomers);
    }

    private void processSliderList(HttpServletRequest request, HttpSession session, SliderDAO sd, int index, MarketerDAO md) {
        int count = sd.getAllSliders().size();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        List<Slider> sliders = sd.getPaginatedSliderList(index);
        session.setAttribute("paginatedSliders", sliders);
        session.setAttribute("tagSL", index);
        session.setAttribute("endPageSL", endPage);
    }

    private void processFilteredSliders(HttpServletRequest request, HttpSession session, MarketerDAO md) {
        String status = request.getParameter("statusS");
        String searchTitle = request.getParameter("searchTitleS");

        List<Slider> filterSliders = md.getFilteredSliders(status, searchTitle);
        session.setAttribute("filteredSliders", filterSliders);
        session.setAttribute("statusTagS", status);
        session.setAttribute("searchTagS", searchTitle);
        session.setAttribute("slidersSL", filterSliders);
    }

    private void processPromotionList(HttpServletRequest request, HttpSession session, PromotionDAO pd, int index) {
        int count = pd.getAllPromotions().size();
        int endPage = count / 10;
        if (count % 10 != 0) {
            endPage++;
        }
        SizeDAO sd = new SizeDAO();
        List<Size> listSize = sd.getAllSize();
        List<Promotion> promotions = pd.getPaginatedPromotionList(index);
        session.setAttribute("paginatedPromotions", promotions);
        session.setAttribute("tagPromotion", index);
        session.setAttribute("sizeForPromotion", listSize);
        session.setAttribute("endPagePromotion", endPage);
    }

    private void processFilteredPromotions(HttpServletRequest request, HttpSession session, PromotionDAO pd) {
        String status = request.getParameter("statusPromotion");
        String searchTitle = request.getParameter("searchTitlePromotion");

        List<Promotion> filterPromotions = pd.getFilteredPromotion(status, searchTitle);
        session.setAttribute("filterPromotions", filterPromotions);
        session.setAttribute("statusTagPromotion", status);
        session.setAttribute("searchTagPromotion", searchTitle);
        session.setAttribute("promotions", filterPromotions);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra session và quyền truy cập trước khi xử lý yêu cầu
        if (checkSessionAndRole(request, response)) {
            String feedbackIDRaw = request.getParameter("feedbackID");
            String statusRaw = request.getParameter("fbstatus"); // Lấy giá trị fbstatus từ hidden input
            String currentPageRaw = request.getParameter("currentPagef");

            // Kiểm tra xem các tham số có hợp lệ không trước khi chuyển đổi
            if (feedbackIDRaw != null && statusRaw != null && currentPageRaw != null) {
                try {
                    // Chuyển đổi các giá trị từ chuỗi sang số
                    int feedbackID = Integer.parseInt(feedbackIDRaw);
                    int status = Integer.parseInt(statusRaw);
                    int currentPagef = Integer.parseInt(currentPageRaw);

                    // Gọi DAO để cập nhật trạng thái
                    MarketerDAO md = new MarketerDAO();
                    md.updateStatusFb(feedbackID, status);

                    // Sau khi cập nhật xong, chuyển hướng người dùng quay lại trang quản lý với trang hiện tại
                    response.sendRedirect("MarketerDashboard?pagef=" + currentPagef);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    // Xử lý nếu có lỗi trong quá trình chuyển đổi tham số
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input values");
                }
            } else {
                // Nếu thiếu tham số, gửi lỗi cho client
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Marketer Dashboard Servlet";
    }
}


