/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.employeeManagement;

import dal.admin.AdminDAO;
import dal.mail.Email;
import dal.common.RegisterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.security.SecureRandom;
import java.util.UUID;

/**
 *
 * @author Tan
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class AddNewEmployeeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddNewEmployeeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewEmployeeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RegisterDAO rd = new RegisterDAO();
        String email = request.getParameter("email");
        String password = "";
        String fullName = request.getParameter("fullName");
        Part imgPart = request.getPart("img_url");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String genderstr = request.getParameter("gender");
        String rolestr = request.getParameter("role");
        RegisterDAO registerDAO = new RegisterDAO();
        AdminDAO ad = new AdminDAO();
        int gender = Integer.parseInt(genderstr);
        int role = Integer.parseInt(rolestr);
// Validate and update customer profile
        if (fullName.trim().isEmpty()) {
            request.setAttribute("message", "The name cannot be left blank.");
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            return; // Ensure to return after forwarding
        }

        if (!fullName.matches("^[\\p{L}\\s]+$")) {
            request.setAttribute("message", "The name cannot contain special characters or numbers.");
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            return; // Ensure to return after forwarding
        }

        if (!phone.isEmpty()) {
            if (!phone.matches("^0\\d{9}$")) {
                request.setAttribute("message", "Please enter a phone number with 10 digits that starts with 0.");
                request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
                return; // Ensure to return after forwarding
            }
        }

        if (!address.isEmpty()) {
            if (!address.matches("^[\\p{L}\\p{N}\\s\\-]*$")) {
                request.setAttribute("message", "The address cannot contain special characters.");
                request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            }
        }
        if (registerDAO.checkEmployeesExists(email)) {
            request.setAttribute("message", "Email already exists! Please use another email.");
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            return; // Ensure to return after forwarding
        }
// Lấy tên file từ đối tượng Part
        String fileName = imgPart.getSubmittedFileName();
        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);

        if (!fileExtension.equalsIgnoreCase("jpg") && !fileExtension.equalsIgnoreCase("jpeg") && !fileExtension.equalsIgnoreCase("png")) {
            request.setAttribute("message", "Please only select files with the extension jpg, png or jpeg");
            request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
            return;
        }

        String imgFileName = System.currentTimeMillis() + "_" + imgPart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/") + "tempUploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        imgPart.write(uploadPath + File.separator + imgFileName);
        password = generateRandomPassword(8);
        String hashPassword = rd.hashPassword(password);
        
// Gửi email với liên kết kích hoạt
        String subject = "Login your account";
        String content = String.format("Dear %s,\nYou have become a part of us, and below is your account:\nEmail: %s\nPassowrd: %s\nPhone: %s\nClick on the following link to login: http://localhost:9999/OnlineShop_SWP391/employee_login.jsp",
                fullName, email, password, phone);

        Email.SendEmails(email, subject, content);

        ad.createEmployee(email, fullName, hashPassword, phone, address, gender, imgFileName, role);
        request.setAttribute("message", "Add employee successful");
        request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
    }

    private static final String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARACTERS = "!@#$%^&*()-_=+";
    private static final String ALL_CHARACTERS = UPPERCASE + LOWERCASE + DIGITS + SPECIAL_CHARACTERS;

    public static String generateRandomPassword(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(ALL_CHARACTERS.length());
            password.append(ALL_CHARACTERS.charAt(randomIndex));
        }

        return password.toString();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
