package controller.common.assessSystem;

import dal.common.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

public class LoginServlet extends HttpServlet {

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

            if (account == null) {
                // Thông báo lỗi nếu đăng nhập không thành công
                request.setAttribute("message", "Wrong email or password!!!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                // Tạo session mới và lưu thông tin đăng nhập
                HttpSession session = request.getSession();
                session.setAttribute("account", account);

                if ("Customer".equals(account.getUserType())) {
                    // Điều hướng đến trang chủ cho khách hàng
                    response.sendRedirect("home");
                } else {
                    // Nếu loại tài khoản không xác định, hiển thị trang lỗi
                    response.sendRedirect("login.jsp");
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