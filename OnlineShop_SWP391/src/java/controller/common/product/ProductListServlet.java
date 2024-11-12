/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common.product;

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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Blog;
import model.BlogCategories;
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
public class ProductListServlet extends HttpServlet {

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

        // Get the session from the current request
        HttpSession session = request.getSession();

        // Create DAO objects to interact with the database
        CategoryDAO cd = new CategoryDAO();
        BrandDAO bd = new BrandDAO();
        ProductDAO pd = new ProductDAO();
        SliderDAO sd = new SliderDAO();
        DAOBlog db = new DAOBlog();
        PromotionDAO prd = new PromotionDAO();

        // Retrieve the lists of categories, brands, and promotions from the database
        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Products> list3LatestPro = pd.get3LatestProducts();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<Promotion> listPromotion = prd.getAllPromotions();

        // Retrieve single brandID and catID from the request
        String brandID_raw = request.getParameter("brandID");
        String catID_raw = request.getParameter("catID");

        int brandID = 0; // Initialize brandID
        int catID = 0; // Initialize catID

        // Check if brandID_raw is not null or empty and parse it
        if (brandID_raw != null && !brandID_raw.isEmpty()) {
            brandID = Integer.parseInt(brandID_raw);
        } else {
            brandID = 0; // Default value if not provided
        }

        // Check if catID_raw is not null or empty and parse it
        if (catID_raw != null && !catID_raw.isEmpty()) {
            catID = Integer.parseInt(catID_raw);
        } else {
            catID = 0; // Default value if not provided
        }

        // Get the pagination index
        String index_raw = request.getParameter("index");
        int index = 1; // Default to 1 if not specified

        // Check if index_raw is not null and parse it
        if (index_raw != null) {
            index = Integer.parseInt(index_raw);
        }

        // Calculate total products based on filters
        int count = pd.getTotalProductsByCatAndBrand(catID, brandID);
        int endPage = count / 10;//12/10=1
        if (count % 10 != 0) {  //12%10=2
            endPage++;
        }

        // Fetch paginated products based on single catID and brandID
        List<Products> listPro = pd.pagingProducts(index, catID, brandID);

        // Store pagination and filtering data in the session
        session.setAttribute("endPage", endPage);
        session.setAttribute("tag", index);
        session.setAttribute("option", 1);

        // Manage boolean array for brands and categories to indicate selection
        boolean[] bID = new boolean[listBrands.size()];
        for (int i = 0; i < bID.length; i++) {
            if (brandID == listBrands.get(i).getBrandID()) {
                bID[i] = true; // Brand is selected
            } else {
                bID[i] = false; // Brand is not selected
            }
        }
        session.setAttribute("bID", bID); // Store the brand selection in the session

        boolean[] cID = new boolean[listCat.size()];
        for (int i = 0; i < cID.length; i++) {
            if (catID == listCat.get(i).getCatID()) {
                cID[i] = true; // Category is selected
            } else {
                cID[i] = false; // Category is not selected
            }
        }
        session.setAttribute("cID", cID); // Store the category selection in the session

        // Store categories, brands, products, images, latest products in session
        session.setAttribute("categories", listCat);
        session.setAttribute("brands", listBrands);
        session.setAttribute("products", listPro);
        session.setAttribute("images", listImage);
        session.setAttribute("promotions", listPromotion);
        session.setAttribute("latest1Products", list3LatestPro);

        // Forward to the JSP page to display the results
        request.getRequestDispatcher("product-list.jsp").forward(request, response);
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

    public boolean ischeck(int d, int[] id) {
        if (id == null) {
            return false;
        } else {
            for (int i = 0; i < id.length; i++) {
                if (id[i] == d) {
                    return true;
                }
            }
            return false;
        }
    }

}
