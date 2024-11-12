package controller.common.dashboard;

import dal.mail.Email;
import dal.customer.FeedbackDAO;
import dal.common.OrderDAO;
import dal.common.PermissionDAO;
import dal.seller.SaleDAO;
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
import model.Customers;
import model.Order;
import model.Status;

public class SaleManagerDashboard extends HttpServlet {

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
            SaleDAO s = new SaleDAO();
            Map<String, Double> listDailyRevenue = null;
            Map<String, Integer[]> getOrderTrend = null;
            float totalRevenue = 0;
            // Lấy tham số startDate và endDate từ request
            String startDateStr = request.getParameter("startdate");
            String endDateStr = request.getParameter("enddate");
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
                listDailyRevenue = s.listDailyRevenueByEmployee(startDateStr, endDateStr);
                getOrderTrend = s.getOrderTrend(startDateStr, endDateStr);
                totalRevenue = s.getTotalRevenueForSeller(startDateStr, endDateStr);
            } else {
                // Xử lý nếu ngày bắt đầu lớn hơn ngày kết thúc
                response.sendRedirect("SaleManagerDashboard");
                return;
            }
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("listDailyRevenue", listDailyRevenue);
            request.setAttribute("getOrderTrend", getOrderTrend);
            request.getRequestDispatcher("sales_manager_dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (checkSessionAndRole(request, response)) {

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
