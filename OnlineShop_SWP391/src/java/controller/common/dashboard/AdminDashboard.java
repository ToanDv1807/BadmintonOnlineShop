package controller.common.dashboard;

import dal.admin.AdminDAO;
import dal.common.PermissionDAO;
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
import model.Employees;

public class AdminDashboard extends HttpServlet {

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
        // Kiểm tra session và quyền truy cập trước khi xử lý yêu cầu
        if (checkSessionAndRole(request, response)) {
            AdminDAO ad = new AdminDAO();
            HttpSession session = request.getSession(false);
            Account a = (Account) session.getAttribute("account");
            Employees e = ad.getEmployeesByEmail(a.getEmail());

            // Lấy tham số startDate và endDate từ request
            String startDateStr = request.getParameter("startdate");
            String endDateStr = request.getParameter("enddate");

            int totalCustomer = 0, totalBought = 0;
            float totalAmount = 0;
            float avg = 0;
            Map<String, Float> listRate = null;
            Map<String, Float> listAmount = null;
            Map<String, Integer[]> orderTrend = null;
            Map<String, Integer> orderList = null;
            // Định dạng ngày hiện tại
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate now = LocalDate.now();

            // Khởi tạo biến LocalDate cho startDate và endDate
            LocalDate startDate = null, endDate = null;

            // Kiểm tra và xử lý đầu vào của startDate và endDate
            if (startDateStr == null || startDateStr.isEmpty()) {
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    // Nếu endDate có giá trị thì startDate sẽ là endDate trừ đi 7 ngày
                    endDate = LocalDate.parse(endDateStr, formatter);
                    startDate = endDate.minusDays(7);
                } else {
                    // Nếu endDate không có giá trị, thì startDate là 7 ngày trước hiện tại
                    startDate = now.minusDays(7);
                    endDate = now;
                }
            } else {
                startDate = LocalDate.parse(startDateStr, formatter);
                if (endDateStr == null || endDateStr.isEmpty()) {
                    endDate = now; // Lấy ngày hiện tại nếu không có endDate
                } else {
                    endDate = LocalDate.parse(endDateStr, formatter);
                }
            }

            // Cập nhật lại giá trị chuỗi cho startDateStr và endDateStr
            startDateStr = startDate.toString();
            endDateStr = endDate.toString();

            // Nếu `startDate` và `endDate` hợp lệ, truy vấn dữ liệu
            if (!startDate.isAfter(endDate)) {
                orderList = ad.listOrderCountByStatus(startDateStr, endDateStr);
                totalAmount = ad.totalAmount(startDateStr, endDateStr);
                totalCustomer = ad.totalCustomers(startDateStr, endDateStr);
                totalBought = ad.totalCustomerBuy(startDateStr, endDateStr);
                listRate = ad.listRate(startDateStr, endDateStr);
                listAmount = ad.listAmount(startDateStr, endDateStr);
                orderTrend = ad.getOrderTrend(startDateStr, endDateStr);
                avg = ad.getAvgOfAllFB(startDateStr, endDateStr);
            } else {
                // Xử lý nếu ngày bắt đầu lớn hơn ngày kết thúc
                response.sendRedirect("AdminDashboard");
                return;
            }

            // Đặt giá trị vào request attribute để truyền sang JSP
            session.setAttribute("admin", e);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            request.setAttribute("orderList", orderList);
            request.setAttribute("totalCustomer", totalCustomer);
            request.setAttribute("avgRate", avg);
            request.setAttribute("orderTrend", orderTrend);
            request.setAttribute("listAmount", listAmount);
            request.setAttribute("listRate", listRate);
            request.setAttribute("totalBought", totalBought);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra session và quyền truy cập trước khi xử lý yêu cầu
        if (checkSessionAndRole(request, response)) {
            processRequest(request, response);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Nội dung của trang Admin Dashboard
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Admin Dashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Welcome to Admin Dashboard</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin Dashboard Servlet";
    }
}
