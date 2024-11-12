/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common.home;

import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.DAOBlog;
import dal.customer.FeedbackDAO;
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
import model.DiscountedProducts;
import model.Feedback;
import model.ProductImage;
import model.Products;
import model.Promotion;
import model.Slider;

/**
 *
 * @author Acer
 */
public class HomeServlet extends HttpServlet {

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
        SliderDAO sd = new SliderDAO();
        DAOBlog db = new DAOBlog();
        FeedbackDAO fd = new FeedbackDAO();
        PromotionDAO prd = new PromotionDAO();
        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Products> listPro = pd.getAllProducts();
        List<Products> listLatestPro = pd.getLatestProducts();
        List<Products> listFeaturePro = pd.getFeaturedProducts();
        List<Products> listComingSoon = pd.getComingSoonProducts();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<Slider> listSlider = sd.getAllSliders();
        Promotion promotion = prd.getActivePromotion();
        if (promotion != null) {
            List<DiscountedProducts> discountedProducts = prd.getUniqueDiscountedProductsByPromotionID(promotion.getPromotionID());
            List<DiscountedProducts> discountedProductsWithSize = prd.getDiscountedProductsByPromotionID(promotion.getPromotionID());
            session.setAttribute("DiscountedProducts", discountedProducts);
            session.setAttribute("DiscountedSize", discountedProductsWithSize);
            session.setAttribute("promotion", promotion);
        }
        if(promotion == null){
            session.removeAttribute("DiscountedProducts");
            session.removeAttribute("DiscountedSize");
            session.removeAttribute("promotion");
        }
        List<Feedback> listFP = fd.getAvgRateForEachPro();
        List<Blog> listBlogs = db.get2BlogByCategoryBlogId(4);
        List<Products> listBestSelling = pd.getTopBestSellingProducts();
        session.setAttribute("listFP", listFP);
        session.setAttribute("categories", listCat);
        session.setAttribute("brands", listBrands);
        session.setAttribute("products", listPro);
        session.setAttribute("images", listImage);
        session.setAttribute("latestProducts", listLatestPro);
        session.setAttribute("featureProducts", listFeaturePro);
        session.setAttribute("comingSoonProducts", listComingSoon);
        session.setAttribute("sliders", listSlider);
        session.setAttribute("blogs", listBlogs);
        session.setAttribute("bestSelling", listBestSelling);
        request.getRequestDispatcher("home.jsp").forward(request, response);
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


