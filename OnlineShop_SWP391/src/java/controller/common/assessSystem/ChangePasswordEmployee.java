package controller.common.assessSystem;

import dal.common.RegisterDAO;
import dal.marketer.MarketerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.Account;

@WebServlet(name = "ChangePasswordEmployee", urlPatterns = {"/change-password-employee"})
public class ChangePasswordEmployee extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        RegisterDAO dao = new RegisterDAO();
        // Khởi tạo DAO và session
        MarketerDAO md = new MarketerDAO();
        HttpSession session = request.getSession(false);
        Account account = (Account) session.getAttribute("account");

        if (account == null) {
            throw new ServletException("User is not authenticated.");
        }

        // Mã hóa mật khẩu hiện tại và kiểm tra trong cơ sở dữ liệu
        String hashedOldPassword = dao.hashPassword(oldPassword);
        if (md.isPasswordCorrect(account.getEmail(), hashedOldPassword)) {
            // Kiểm tra mật khẩu mới và mật khẩu xác nhận có khớp không
            if (newPassword.equals(confirmPassword)) {
                // Kiểm tra độ dài và ký tự đặc biệt cho mật khẩu mới
                if (newPassword.length() > 8) {
                    session.setAttribute("errorPassWord", "Password must not exceed 8 characters.");
                } else if (!newPassword.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
                    session.setAttribute("errorPassWord", "Password must contain at least one special character.");
                } else if (!Character.isUpperCase(newPassword.charAt(0))) {
                    session.setAttribute("errorPassWord", "Password must start with a capital letter.");
                } else {
                    // Mã hóa mật khẩu mới và cập nhật
                    String hashedNewPassword = dao.hashPassword(newPassword);
                    boolean isUpdated = md.updatePassword(account.getEmail(), hashedNewPassword);
                    if (isUpdated) {
                        session.setAttribute("messagePassWord", "Password changed successfully!");
                    } else {
                        session.setAttribute("errorPassWord", "Error updating password. Please try again.");
                    }
                }
            } else {
                session.setAttribute("errorPassWord", "New password and confirmation do not match.");
            }
        } else {
            session.setAttribute("errorPassWord", "Old password is incorrect.");
        }

        // Chuyển tiếp đến trang thông báo
        response.sendRedirect("MarketerDashboard");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordEmployee</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordEmployee at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for changing employee password with encryption.";
    }
}
