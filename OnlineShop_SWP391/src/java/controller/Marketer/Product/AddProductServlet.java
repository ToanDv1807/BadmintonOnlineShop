/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.Product;

import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.DAOBlog;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.SliderDAO;
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
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.security.Timestamp;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;
import model.Blog;
import model.Brand;
import model.Category;
import model.ProductImage;
import model.Products;
import model.Promotion;
import model.Slider;

/**
 *
 * @author Acer
 */
@MultipartConfig
public class AddProductServlet extends HttpServlet {

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
            out.println("<title>Servlet AddProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Giả định bạn đã có các DAO để lấy danh sách categories, brands, promotions, v.v.
        CategoryDAO cd = new CategoryDAO();
        BrandDAO bd = new BrandDAO();

        session.setAttribute("categories", cd.getAllCategories());
        session.setAttribute("brands", bd.getAllBrands());
        // Chuyển hướng đến trang nhập sản phẩm
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String briefInfo = request.getParameter("productBriefInfo");
        String description = request.getParameter("description");
        String catIDStr = request.getParameter("category");
        String brandIDStr = request.getParameter("brand");
        String statusStr = request.getParameter("status");
        String featuredStr = request.getParameter("featured");

        Part filePart = request.getPart("productImage");
        String fileName = null;
        String fileExtension = "";
        String message = null; // Variable to store message
        String success = null;
        // Validate product name
        if (productName == null || productName.trim().isEmpty()) {
            message = "Product name cannot be empty.";
            forwardWithMessage(request, response, message, success);
            return;
        }

        // Check for special characters
       

        // Check category and brand
        if ("0".equals(catIDStr)) {
            message = "Please select a valid category.";
            forwardWithMessage(request, response, message, success);
            return;
        }
        if ("0".equals(brandIDStr)) {
            message = "Please select a valid brand.";
             forwardWithMessage(request, response, message, success);
            return;
        }

        // Handle file upload
        if (filePart != null && filePart.getSize() > 0) {
            String UPLOAD_DIRECTORY = "uploads/";
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            System.out.println("Upload Path: " + uploadPath); // Print path for debugging

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    System.out.println("Directory created successfully.");
                } else {
                    message = "Failed to create directory for uploads.";
                    forwardWithMessage(request, response, message, success);
                    return;
                }
            }

            // Get file extension and validate image format
            fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
            if (!fileExtension.equalsIgnoreCase("jpg") && !fileExtension.equalsIgnoreCase("jpeg") && !fileExtension.equalsIgnoreCase("png")) {
                message = "Please select files with extensions jpg, png, or jpeg.";
                 forwardWithMessage(request, response, message, success);
                return;
            }

            // Add timestamp to the filename to avoid duplication
            fileName = System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + fileName;

            // Save file to the path
            try {
                filePart.write(filePath);
            } catch (IOException e) {
                message = "Error saving file.";
                 forwardWithMessage(request, response, message, success);
                return;
            }

            // Set relative path for the database
            fileName = UPLOAD_DIRECTORY + fileName;
        } else {
            message = "No file uploaded.";
             forwardWithMessage(request, response, message, success);
            return;
        }

        try {
            int catID = Integer.parseInt(catIDStr);
            int brandID = Integer.parseInt(brandIDStr);
            int status = Integer.parseInt(statusStr);
            int featured = Integer.parseInt(featuredStr);

            Products product = new Products();
            product.setProductName(productName);
            product.setBriefInfo(briefInfo);
            product.setDescription(description);
            product.setCatID(catID);
            product.setBrandID(brandID);
            product.setStatus(status);
            product.setFeatureStatus(featured);
            product.setCreatedAt(new java.sql.Date(System.currentTimeMillis()));

            ProductDAO productDAO = new ProductDAO();
            productDAO.addProduct(product, fileName);

            success = "Product added successfully!";
            forwardWithMessage(request, response, message, success);
        } catch (NumberFormatException | SQLException e) {
            message = "Error adding product: Input all information";
             forwardWithMessage(request, response, message, success);
        }
    }

// Phương thức hỗ trợ để chuyển tiếp với thông báo
    private void forwardWithMessage(HttpServletRequest request, HttpServletResponse response, String message, String success)
            throws ServletException, IOException {
        request.setAttribute("message", message);
        request.setAttribute("success", success);
        request.getRequestDispatcher("addProduct.jsp").forward(request, response);
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
