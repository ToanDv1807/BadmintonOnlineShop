package controller.common.assessSystem;

import dal.common.ResetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ResetPassServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        Long expireTime = (Long) session.getAttribute("expireTime");
        
        if (email == null || expireTime == null) {
            // Nếu không có thông tin hoặc session hết hạn
            request.setAttribute("message", "The activation link is invalid or has expired or email does not exist.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra thời gian hết hạn
        long currentTime = System.currentTimeMillis();
        if (currentTime > expireTime) {
            // Nếu đã quá hạn
            request.setAttribute("message", "The password reset link has expired. Please try again.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Nhận mật khẩu mới từ người dùng
        String newPassword = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");
        // Kiểm tra điều kiện mật khẩu
        if (!Character.isUpperCase(newPassword.charAt(0))) {
            // Kiểm tra ký tự đầu tiên có phải in hoa không
            request.setAttribute("message", "Password must start with a capital letter.");
            request.getRequestDispatcher("reset.jsp").forward(request, response);
        } else if (!newPassword.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            // Kiểm tra mật khẩu phải chứa ít nhất một ký tự đặc biệt
            request.setAttribute("message", "Password must contain at least one special character.");
            request.getRequestDispatcher("reset.jsp").forward(request, response);
        } else if (newPassword.length() > 8) {
            request.setAttribute("message", "Please only enter a password with a maximum length of 8 characters");
            request.getRequestDispatcher("reset.jsp").forward(request, response);
        }  else if (!confirm.equals(newPassword)) {
            request.setAttribute("message", "Re-enter the password that does not match");
            request.getRequestDispatcher("reset.jsp").forward(request, response);
        }else {
            // Cập nhật mật khẩu mới trong cơ sở dữ liệu
            ResetDAO dao = new ResetDAO();
            boolean updated = dao.updatePassword(email, newPassword);
            boolean updatedemp = dao.updatePasswordEmp(email, newPassword);

            if (updated || updatedemp) {
                // Xóa thông tin session sau khi đặt lại mật khẩu thành công
                session.removeAttribute("resetEmail");
                session.removeAttribute("expireTime");
                
                // Chuyển hướng đến trang đăng nhập
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("message", "Password reset failed.");
                request.getRequestDispatcher("reset.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
