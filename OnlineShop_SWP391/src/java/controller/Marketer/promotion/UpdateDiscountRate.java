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

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "UpdateDiscountRate", urlPatterns = {"/UpdateDiscountRate"})
public class UpdateDiscountRate extends HttpServlet {

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
            String discountRateStr = request.getParameter("discountRateInput");
            String productIdStr = request.getParameter("productIdInput");
            String promotionIdStr = request.getParameter("promotionIdInput");

            // Log the received parameters to verify
            System.out.println("Received Discount Rate: " + discountRateStr);
            System.out.println("Received Product ID: " + productIdStr);
            System.out.println("Received Promotion ID: " + promotionIdStr);

            // Check if any parameter is null
            if (discountRateStr == null || productIdStr == null || promotionIdStr == null) {
                System.out.println("One or more parameters are null.");
            } else {
                PromotionDAO pd = new PromotionDAO();
                boolean isUpdated = pd.UpdateDiscountRate(
                        Integer.parseInt(promotionIdStr),
                        Integer.parseInt(productIdStr),
                        Integer.parseInt(discountRateStr)
                );
                String message = isUpdated ? "Updated Successfully" : "Update Failed";
                request.getSession().setAttribute("messageEditPro", message);
                response.sendRedirect("promotion-edit?proid=" + promotionIdStr);
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
