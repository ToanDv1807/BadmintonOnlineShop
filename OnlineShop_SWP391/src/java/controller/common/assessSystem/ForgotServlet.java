package controller.common.assessSystem;

import dal.common.ForgotDAO;
import dal.mail.Email;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

public class ForgotServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            ForgotDAO dao = new ForgotDAO();

            // Kiểm tra xem email có tồn tại không
            if (dao.getCustomerByEmail(email) != null || dao.getEmployeesByEmail(email) != null) {
                // Tạo thời gian hết hạn 
                long currentTime = System.currentTimeMillis();
                long expireTime = currentTime + 1 * 60 * 1000; // 1 phút

                // Lưu thời gian hết hạn vào session
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", email);
                session.setAttribute("expireTime", expireTime);

                // Tạo liên kết đặt lại mật khẩu
                String resetLink = "http://localhost:9999/OnlineShop_SWP391/reset.jsp?email=" + email;

                // Gửi email với liên kết đặt lại mật khẩu
                String subject = "Reset your password";
                String message = "Click on the following link to reset your password: " + resetLink;
                Email.SendEmails(email, subject, message);
                request.setAttribute("message", "The system has sent a password reset link via email. Please check!");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Email không tồn tại.");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
