/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common.product;

import dal.marketer.AttributeDAO;
import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.common.ChangeDAO;
import dal.marketer.DAOBlog;
import dal.customer.FeedbackDAO;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.SizeDAO;
import dal.marketer.SliderDAO;
import dal.marketer.SubImageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.awt.Image;
import java.util.List;
import model.Account;
import model.Brand;
import model.Category;
import model.Customers;
import model.Feedback;
import model.ProductImage;
import model.Product_Attribute_Stock;
import model.Products;
import model.Promotion;
import model.Size;
import model.SubImage;

/**
 *
 * @author Acer
 */
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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
        Account a = (Account) session.getAttribute("account");

        ChangeDAO chd = new ChangeDAO();
        Customers c = null;

        // Nếu người dùng đã đăng nhập, lấy thông tin khách hàng
        if (a != null) {
            c = chd.getCustomersByEmail(a.getEmail());
            session.setAttribute("c", c);
        }

        CategoryDAO cd = new CategoryDAO();
        ProductDAO pd = new ProductDAO();

        BrandDAO bd = new BrandDAO();
        DAOBlog db = new DAOBlog();
        FeedbackDAO fd = new FeedbackDAO();
        SubImageDAO sid = new SubImageDAO();
        PromotionDAO prd = new PromotionDAO();
        AttributeDAO attributeDAO = new AttributeDAO();
        SizeDAO sd = new SizeDAO();

        List<SubImage> listSubImg = sid.getSubImageURLByProductImgId();
        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrand = bd.getAllBrands();
        List<Products> listPro = pd.getAllProducts();
        List<Products> list3LatestPro = pd.get3LatestProducts();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<Products> listFeaturePro = pd.getFeaturedProducts();
        String productID_raw = request.getParameter("productID");
        List<Products> listTop3Rated = fd.getTop3ProductRated();
        List<Feedback> listFP = fd.getAvgRateForEachPro();
        List<Size> listSize = sd.getAllSize();
        List<Products> list3BestSelling = pd.getTopBestSellingProducts();

        int productID;
        try {
            productID = Integer.parseInt(productID_raw);

            // Xử lý các sản phẩm liên quan
            Products product_new2 = pd.getProductByAfterID(productID);
            Products product_new1 = pd.getProductByPreID(productID);
            Products productbyID = pd.getProductByID(productID);
            List<Products> listProByID = pd.getProductsByCatID(productbyID.getCatID());
            List<Product_Attribute_Stock> productAttributes = attributeDAO.getProductAttributesByProductID(productID);
            List<Feedback> listf = fd.getFeedbacksByPID(productID);
            
            int countFeedback = fd.countFeedbackByPid(productID);
            float avgRating = fd.getAVGRatingBYPid(productID);

            // Đặt các thuộc tính vào request và session
            request.setAttribute("productbyID", productbyID);
            session.setAttribute("avgRating", avgRating);
            session.setAttribute("listf", listf);
            session.setAttribute("countfb", countFeedback);
            session.setAttribute("productPre", product_new1);
            session.setAttribute("productAfter", product_new2);
            session.setAttribute("listProbyID", listProByID);
            session.setAttribute("productAttributes", productAttributes);
            session.setAttribute("productID", productID);
            session.setAttribute("list3BestSelling", list3BestSelling);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        // Đặt các thuộc tính chung vào session
        session.setAttribute("listFP", listFP);
        session.setAttribute("productID_request", productID_raw);
        session.setAttribute("listTop3Rated", listTop3Rated);
        session.setAttribute("categories", listCat);
        session.setAttribute("brands", listBrand);
        session.setAttribute("products", listPro);
        session.setAttribute("images", listImage);
        session.setAttribute("promotions", listPromotion);
        session.setAttribute("latest3Products", list3LatestPro);
        session.setAttribute("featureProducts", listFeaturePro);
        session.setAttribute("subImages", listSubImg);
        session.setAttribute("sizes", listSize);

        // Chuyển tiếp tới trang chi tiết sản phẩm
        request.getRequestDispatcher("product-detail.jsp").forward(request, response);
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
