package controller.common.assessSystem;

import dal.common.LoginDAO;
import dal.marketer.MarketerDAO;
import dal.common.PermissionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Employees;

public class EmployeeLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Lấy thông tin đăng nhập từ request
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Khởi tạo DAO và kiểm tra thông tin đăng nhập
            LoginDAO loginDAO = new LoginDAO();
            Account account = loginDAO.checkLogin(email, password);
            MarketerDAO md = new MarketerDAO();       
            if (account == null || account.getStatus()==0) {
                // Thông báo lỗi nếu đăng nhập không thành công
                request.setAttribute("message", "Wrong email or password!!!");
                request.getRequestDispatcher("employee_login.jsp").forward(request, response);
            } else {
                // Tạo session mới và lưu thông tin đăng nhập
                HttpSession session = request.getSession();
                session.setAttribute("account", account);

                // Kiểm tra loại tài khoản và roleID để chuyển hướng đến Dashboard phù hợp
                if ("Employee".equals(account.getUserType())) {
                    // Kiểm tra roleID của nhân viên
                    int roleID = account.getRoleID();

                    // Khởi tạo PermissionDAO để kiểm tra quyền
                    PermissionDAO permissionDAO = new PermissionDAO();
                    String dashboardUrl = "";  // Xác định Dashboard URL của từng roleID
                    switch (roleID) {
                        case 1:
                            dashboardUrl = "AdminDashboard";
                            break;
                        case 2:
                            dashboardUrl = "MarketerDashboard";
                            break;
                        case 3:
                            dashboardUrl = "SellerDashboard";
                            break;
                        case 4:
                            dashboardUrl = "SaleManagerDashboard";
                            break;
                        case 6:
                            dashboardUrl = "WarehouseServlet";
                            break;
                        default:
                            response.sendRedirect("employee_login.jsp");
                            return;
                    }
                    Employees e = md.getEmployeeByEmail(account.getEmail());
                    session.setAttribute("employee", e);
                    // Chuyển người dùng đến trang Dashboard phù hợp
                    response.sendRedirect(dashboardUrl);

                    // Người dùng đã được chuyển đến dashboard và từ đó họ sẽ có thể truy cập các trang khác.
                    // Kiểm tra quyền truy cập vào các trang khác có thể được thực hiện trong các servlet khác cho từng dashboard cụ thể.
                } else {
                    // Nếu loại tài khoản không xác định, hiển thị trang lỗi
                    response.sendRedirect("employee_login.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the login request.");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet for managing user login and redirect based on user role.";
    }// </editor-fold>
}
