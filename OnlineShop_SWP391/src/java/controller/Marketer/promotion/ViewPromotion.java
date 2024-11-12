/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.promotion;

import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DiscountedProducts;
import model.Product_Attribute_Stock;
import model.Products;
import model.Promotion;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "ViewPromotion", urlPatterns = {"/promotion-view"})
public class ViewPromotion extends HttpServlet {

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
            String promotionID = request.getParameter("proid");
            PromotionDAO pd = new PromotionDAO();
            ProductDAO prod = new ProductDAO();
            Promotion p = pd.getPromotionByPromotionID(Integer.parseInt(promotionID));
            List<Products> listPro = prod.getAllProducts();
            List<Product_Attribute_Stock> listSize = pd.getAllProductAttributeStock();
            List<DiscountedProducts> listDP = pd.getUniqueDiscountedProductsByPromotionID(Integer.parseInt(promotionID));
            request.setAttribute("PromotionForView", p);
            request.setAttribute("DiscountedProducts", listDP);
            request.setAttribute("products", listPro);
            request.setAttribute("sizeOfProduct", listSize);
            request.getRequestDispatcher("ViewPromotion.jsp").forward(request, response);
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
