/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.promotion;

import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.DAOBlog;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
public class SetSaleProduct extends HttpServlet {

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
            out.println("<title>Servlet SetSaleProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SetSaleProduct at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        CategoryDAO cd = new CategoryDAO();
        BrandDAO bd = new BrandDAO();
        ProductDAO pd = new ProductDAO();
        PromotionDAO prd = new PromotionDAO();

        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<ProductImage> listImage = pd.getAllProductImage();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Kiểm tra xem productID có tồn tại và không null
            String productIDParam = request.getParameter("productID");

            int productID = Integer.parseInt(productIDParam);

            // Lấy thông tin sản phẩm
            Products product = pd.getProductById(productID);

            // Lấy thông tin khuyến mãi liên quan đến sản phẩm
            Promotion promotion = prd.getPromotionByProductId(productID);

            // Thiết lập thông tin vào session
            session.setAttribute("product", product);
            session.setAttribute("promotion", promotion);
            session.setAttribute("categories", listCat);
            session.setAttribute("images", listImage);
            session.setAttribute("brands", listBrands);
            session.setAttribute("promotions", listPromotion);

            // Chuyển hướng đến trang SetSaleProduct.jsp
            request.getRequestDispatcher("SetSaleProduct.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi không thể chuyển đổi kiểu số
            out.println("<html><body>");
            out.println("<h3>Error: Invalid product ID format. Please enter a valid number.</h3>");
            out.println("<a href='your_previous_page.jsp'>Go back</a>");
            out.println("</body></html>");
        } catch (Exception e) {
            // Xử lý các lỗi khác
            e.printStackTrace();
            out.println("<html><body>");
            out.println("<h3>Error: An error occurred while retrieving the product.</h3>");
            out.println("<a href='your_previous_page.jsp'>Go back</a>");
            out.println("</body></html>");
        } finally {
            out.close();
        }
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
        processRequest(request, response);
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
