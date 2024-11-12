package controller.common.assessSystem;

import dal.mail.Email;
import dal.common.RegisterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            Part imgPart = request.getPart("img_url");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String genderstr = request.getParameter("gender");
            RegisterDAO registerDAO = new RegisterDAO();
            int gender = Integer.parseInt(genderstr);
            // Lấy tên file từ đối tượng Part
            String fileName = imgPart.getSubmittedFileName();
            // Lấy phần đuôi file (extension) từ tên file
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);

            if (registerDAO.checkCustomerExists(email)) {
                // Nếu email đã tồn tại, chuyển hướng tới trang đăng ký với thông báo lỗi
                request.setAttribute("message", "Email already exists! Please use another email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (registerDAO.checkEmployeesExists(email)) {
                // Nếu email đã tồn tại, chuyển hướng tới trang đăng ký với thông báo lỗi
                request.setAttribute("message", "Email already exists! Please use another email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (!Character.isUpperCase(password.charAt(0))) {
                // Kiểm tra ký tự đầu tiên có phải in hoa không
                request.setAttribute("message", "Password must start with a capital letter");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
                // Kiểm tra mật khẩu phải chứa ít nhất một ký tự đặc biệt
                request.setAttribute("message", "Password must contain at least one special character");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (password.length() > 8) {
                request.setAttribute("message", "Please only enter a password with a maximum length of 8 characters");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (!fileExtension.equalsIgnoreCase("jpg") && !fileExtension.equalsIgnoreCase("jpeg") && !fileExtension.equalsIgnoreCase("png")) {
                request.setAttribute("message", "Please only select files with the extension jpg, png or jpeg");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                // Tạo mã kích hoạt
                String activationCode = UUID.randomUUID().toString();

                // Lưu ảnh vào thư mục trong project (tạm thời)
                String imgFileName = imgPart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("/") + "tempUploads"; // Lưu ảnh tạm thời vào thư mục tempUploads
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                imgPart.write(uploadPath + File.separator + imgFileName);

                // Lưu thông tin vào session
                request.getSession().setAttribute("email", email);
                request.getSession().setAttribute("password", password);
                request.getSession().setAttribute("fullName", fullName);
                request.getSession().setAttribute("tempImgPath", "tempUploads/" + imgFileName);
                request.getSession().setAttribute("phone", phone);
                request.getSession().setAttribute("address", address);
                request.getSession().setAttribute("gender", gender);
                request.getSession().setAttribute("activationCode", activationCode);

                // Gửi email với liên kết kích hoạt
                String activationLink = "http://localhost:9999/OnlineShop_SWP391/ActivateAccountServlet?email=" + email + "&code=" + activationCode;
                String subject = "Activate your account";
                String content = "Dear " + fullName + "\nYou have almost finished registering a new account with informations: " + "\nEmail: " + email + "\nName: " + fullName + "\nPhone: " + phone + "\nAddress: " + address + ",\n\nClick on the following link to activate your account: " + activationLink;
                Email.SendEmails(email, subject, content);

                request.setAttribute("message", "You have almost completed account registration, please click on the link sent via registration email to complete account creation.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Register Servlet";
    }
}
