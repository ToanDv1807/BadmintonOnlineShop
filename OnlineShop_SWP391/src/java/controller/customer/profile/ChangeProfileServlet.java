/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.profile;

import dal.common.ChangeDAO;
import dal.marketer.MarketerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.Account;
import model.Customers;
import model.Employees;

/**
 *
 * @author Tan
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ChangeProfileServlet extends HttpServlet {

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
            out.println("<title>Servlet ChangeProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangeProfileServlet at " + request.getContextPath() + "</h1>");
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
        ChangeDAO cd = new ChangeDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        if (a == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        Customers c = cd.getCustomersByEmail(a.getEmail());
        //update infor cua customer
        String fullName = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int gender = Integer.parseInt(request.getParameter("gender"));
        String fileExtension = "";

        // Handle file upload
        Part imgPart = request.getPart("profileImage");
        String fileName = null;
        if (imgPart != null && imgPart.getSize() > 0) {
            String UPLOAD_DIRECTORY = "uploads/";
            fileName = Paths.get(imgPart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);

            // Thêm timestamp vào tên file để tránh trùng lặp
            fileName = System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + fileName;
            //check file anh
            if (!fileExtension.equalsIgnoreCase("jpg") && !fileExtension.equalsIgnoreCase("jpeg") && !fileExtension.equalsIgnoreCase("png")) {
                session.setAttribute("messProfile", "Please only select files with the extension jpg, png or jpeg");
                response.sendRedirect("userProfile");
                return;
            } else {
                try {
                    // Lưu file vào đường dẫn đã tạo
                    imgPart.write(filePath);
                } catch (IOException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "File upload failed due to permission issues.");
                    return;
                }
            }
            // Đảm bảo file đã được lưu thành công trước khi set vào session
            fileName = "uploads/" + fileName;

        } else {
            // Nếu không có file upload mới, sử dụng hình ảnh cũ
            fileName = c.getImg_url();
        }
//
        // Validate and update customer profile
        if (fullName.trim().isEmpty()) {
            session.setAttribute("messProfile", "The name cannot be left blank.");
            response.sendRedirect("userProfile");
            return;
        }

        if (!fullName.matches("^[\\p{L}\\s]+$")) {
            session.setAttribute("messProfile", "The name cannot contain special characters or numbers.");
            response.sendRedirect("userProfile");
            return;
        }

        if (!phone.isEmpty()) {
            if (!phone.matches("^0\\d{9}$")) {
                session.setAttribute("messProfile", "Please enter a phone number with 10 digits that starts with 0.");
                response.sendRedirect("userProfile");
                return;
            }
        } else {
            phone = c.getPhone();
        }

        if (!address.isEmpty()) {
            if (!address.matches("^[\\p{L}\\p{N}\\s,\\-]*$")) {
                session.setAttribute("messProfile", "The address cannot contain special characters.");
                response.sendRedirect("userProfile");
                return;
            }
        } else {
            address = c.getAddress();
        }
        if (fullName.equals(c.getFullName()) && phone.equals(c.getPhone()) && address.equals(c.getAddress()) && gender == c.getGender() && fileName.equals(c.getImg_url())) {
            session.setAttribute("messProfile", "You can not update duplicate information");
            response.sendRedirect("userProfile");
            return;
        }
        // save change history to database
        MarketerDAO md = new MarketerDAO();
        md.addCustomerChangeHistory(c.getCustomerID(), c.getEmail(), c.getFullName(), c.getGender(), c.getPhone(), c.getAddress(), c.getFullName());
        // Update customer profile in database
        cd.updateCustomerProfile(fileName, phone, address, fullName, c.getCustomerID(), gender);
        session.setAttribute("messProfile", "Update success!!!");
        response.sendRedirect("userProfile");
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
