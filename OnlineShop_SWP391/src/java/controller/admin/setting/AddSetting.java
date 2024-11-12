package controller.admin.setting;

import dal.marketer.CategoryDAO;
import dal.common.OrderDAO;
import dal.common.PermissionDAO;
import dal.admin.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Category;
import model.Status;

public class AddSetting extends HttpServlet {
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
        // Khi truy cập GET, lấy danh sách Status và chuyển tiếp đến trang add_setting.jsp
        OrderDAO orderDAO = new OrderDAO();
        CategoryDAO cateDAO = new CategoryDAO();
        List<Status> statusList = orderDAO.getAllStatuses2();
        List<Category> cateList = cateDAO.getAllCategories();
        request.setAttribute("statusList", statusList);
        request.setAttribute("cateList", cateList);
        request.getRequestDispatcher("add_setting.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    if (checkSessionAndRole(request, response)) {
    try {
        // Lấy các tham số từ request
        int type = Integer.parseInt(request.getParameter("type"));
        String value = request.getParameter("value");
        String description = request.getParameter("description");
        int status = Integer.parseInt(request.getParameter("status"));

        SettingDAO sd = new SettingDAO();
        int order;

        if (type == 1) {
            // Xử lý thêm category
            order = sd.addCategory(value, status, description);
            sd.addSettingBy(type, order, value, description, status);

        } else if (type == 2) {
            // Lấy giá trị pre và post từ request
            String preParam = request.getParameter("pre");
            String postParam = request.getParameter("post");

            // Kiểm tra giá trị pre và post không bị null hoặc rỗng
            if (preParam == null || preParam.isEmpty() || postParam == null || postParam.isEmpty()) {
                // Xử lý lỗi hoặc phản hồi về trang thêm setting nếu pre hoặc post chưa được chọn
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Pre and Post status are required for type 2.");
                return;
            }

            // Chuyển đổi pre và post thành số nguyên
            int pre = Integer.parseInt(preParam);
            int post = Integer.parseInt(postParam);

            // Thêm order status với giá trị pre và post
            order = sd.addOrderStatus(value, status, pre, post);
            sd.addSettingBy(type, order, value, description, status);
        }
         else if (type == 3) {
            // Lấy giá trị pre và post từ request
            String cateParam = request.getParameter("categories");

            // Kiểm tra giá trị pre và post không bị null hoặc rỗng
            if (cateParam == null || cateParam.isEmpty()) {
                // Xử lý lỗi hoặc phản hồi về trang thêm setting nếu pre hoặc post chưa được chọn
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category is required for type 3.");
                return;
            }

            // Chuyển đổi pre và post thành số nguyên
            int cate = Integer.parseInt(cateParam);

            // Thêm order status với giá trị pre và post
            order = sd.addSize(value, status, cate, description);
            sd.addSettingBy(type, order, value, description, status);
        }

        // Sau khi xử lý thành công, chuyển hướng tới trang SettingList
        response.sendRedirect("SettingList");

    } catch (NumberFormatException e) {
        // Xử lý lỗi khi chuyển đổi chuỗi thành số
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format for numbers.");
    } catch (Exception e) {
        // Xử lý các lỗi khác
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
    }
    }
}


    @Override
    public String getServletInfo() {
        return "Servlet to add settings";
    }
}
