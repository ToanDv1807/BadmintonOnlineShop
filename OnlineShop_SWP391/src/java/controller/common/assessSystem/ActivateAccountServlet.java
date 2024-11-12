package controller.common.assessSystem;

import dal.common.RegisterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Customers;
import java.io.File;
import java.io.IOException;

public class ActivateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String activationCode = request.getParameter("code");

        // Kiểm tra mã kích hoạt
        String sessionActivationCode = (String) request.getSession().getAttribute("activationCode");
        if (sessionActivationCode != null && sessionActivationCode.equals(activationCode)) {
            // Lấy thông tin người dùng từ session
            String password = (String) request.getSession().getAttribute("password");
            String fullName = (String) request.getSession().getAttribute("fullName");
            String tempImgPath = (String) request.getSession().getAttribute("tempImgPath");
            String phone = (String) request.getSession().getAttribute("phone");
            String address = (String) request.getSession().getAttribute("address");
            int gender = (int) request.getSession().getAttribute("gender");
            // Đường dẫn đến thư mục uploads (thư mục chính)
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // Chuyển file từ tempUploads sang uploads
            File tempFile = new File(getServletContext().getRealPath("/") + tempImgPath);
            File destFile = new File(uploadPath + File.separator + tempFile.getName());
            tempFile.renameTo(destFile); // Chuyển file đến thư mục chính

            // Tạo đối tượng Customer và lưu vào cơ sở dữ liệu
            Customers customer = new Customers();
            customer.setEmail(email);
            customer.setPassword(password);
            customer.setFullName(fullName);
            customer.setImg_url("uploads/" + tempFile.getName());
            customer.setPhone(phone);
            customer.setAddress(address);
            customer.setGender(gender);
            customer.setStatus(1);
            RegisterDAO dao = new RegisterDAO();
            dao.registerCustomer(customer);

            // Sau khi tài khoản được tạo, xóa session
            request.getSession().invalidate();

            response.sendRedirect("login.jsp"); // Chuyển đến trang đăng nhập sau khi kích hoạt
        } else {
            request.setAttribute("message", "The activation link is invalid or has expired.");
            request.getRequestDispatcher("activation-failed.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Activate Account Servlet";
    }
}
