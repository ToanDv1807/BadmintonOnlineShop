/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.promotion;

import dal.marketer.PromotionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "AddProductForPromotion", urlPatterns = {"/AddProductForPromotion"})
public class AddProductForPromotion extends HttpServlet {

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
            String proid = request.getParameter("proid");
            String selectedProducts = request.getParameter("selectedProducts");
            String discountPrice = request.getParameter("discountPrice");
            if (selectedProducts == null) {
                request.getSession().setAttribute("messageEditPro", "None product was added");
                response.sendRedirect("promotion-edit?proid=" + proid);
            } else {
                List<String> productIds = Arrays.asList(selectedProducts.split(","));
                try {
                    // Add promotion details to database (replace with your database access code)
                    // Example DAO usage:
                    PromotionDAO promotionDAO = new PromotionDAO();
                    // Add selected products to the promotion
                    for (String productId : productIds) {
                        // Retrieve all sizes for the current product
                        List<Integer> listSizeOfProduct = promotionDAO.getAllSizeOfProduct(Integer.parseInt(productId));

                        // Loop through each size and add to promotion
                        for (Integer sizeId : listSizeOfProduct) {
                            promotionDAO.addProductToPromotion(Integer.parseInt(proid), Integer.parseInt(productId), Integer.parseInt(discountPrice), sizeId);
                        }
                    }
                    // Redirect to a success page or back to the dashboard
                    response.sendRedirect("promotion-edit?proid=" + proid);
                } catch (Exception e) {
                    e.printStackTrace();
                    // Redirect to an error page or show an error message
                    response.sendRedirect("errorPage.jsp");
                }
            }
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
