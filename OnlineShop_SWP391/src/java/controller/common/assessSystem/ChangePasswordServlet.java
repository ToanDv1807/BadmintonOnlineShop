package controller.common.assessSystem;

import dal.common.ChangeDAO;
import dal.common.RegisterDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Customers;

public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("changepassword.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPass = request.getParameter("confirmPassword");
        RegisterDAO dao = new RegisterDAO();
        ChangeDAO cd = new ChangeDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");

        if (a == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy thông tin khách hàng từ cơ sở dữ liệu
        Customers c = cd.getCustomersByEmail(a.getEmail());
        boolean passwordCorrect = false;

        // Mã hóa mật khẩu hiện tại người dùng nhập vào và so sánh với mật khẩu đã mã hóa trong cơ sở dữ liệu
        if (dao.hashPassword(currentPassword).equals(c.getPassword())) {
            passwordCorrect = true;
        }

        if (!passwordCorrect) {
            request.setAttribute("mess", "Current password is incorrect");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmNewPass)) {
            request.setAttribute("mess", "The new password does not match");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }
        if (newPassword.length() > 8) {
            request.setAttribute("mess", "Please only enter a password with a maximum length of 8 characters");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }
        if (!newPassword.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            request.setAttribute("mess", "Password must contain at least one special character");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }
        if (!Character.isUpperCase(newPassword.charAt(0))) {
            request.setAttribute("mess", "Password must start with a capital letter");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu mới và cập nhật cơ sở dữ liệu
        String hashedNewPassword = dao.hashPassword(newPassword);
        cd.updateCustomerPassword(hashedNewPassword, c.getCustomerID()); // Cập nhật mật khẩu đã mã hóa

        request.setAttribute("mess", "Change password success!!!");
        request.getRequestDispatcher("changepassword.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for changing customer password with password encryption.";
    }
}
