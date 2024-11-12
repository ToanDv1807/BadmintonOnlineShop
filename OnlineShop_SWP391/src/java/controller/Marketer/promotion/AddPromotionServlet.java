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
import model.Promotion;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "AddPromotionServlet", urlPatterns = {"/AddPromotionServlet"})
public class AddPromotionServlet extends HttpServlet {

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
            out.println("<title>Servlet AddPromotionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddPromotionServlet at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String promotionName = request.getParameter("promotionName");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String note = request.getParameter("note");
        String selectedProducts = request.getParameter("selectedProducts"); // Product IDs as a comma-separated string
        String discountPrice = request.getParameter("discountPrice");

        // Convert selectedProducts to a list of IDs
        List<String> productIds = Arrays.asList(selectedProducts.split(","));

        try {
            // Add promotion details to database (replace with your database access code)
            // Example DAO usage:
            PromotionDAO promotionDAO = new PromotionDAO();
            promotionDAO.addPromotion(promotionName, startDate, endDate, description, status, note);
            int promotionID = promotionDAO.getLastPromotionID();
            if(status.equals("1")){
                promotionDAO.setAllStatusPromotion(promotionID);
            }
            // Add selected products to the promotion
            for (String productId : productIds) {
                // Retrieve all sizes for the current product
                List<Integer> listSizeOfProduct = promotionDAO.getAllSizeOfProduct(Integer.parseInt(productId));

                // Loop through each size and add to promotion
                for (Integer sizeId : listSizeOfProduct) {
                    promotionDAO.addProductToPromotion(promotionID, Integer.parseInt(productId), Integer.parseInt(discountPrice), sizeId);
                }
            }

            // Redirect to a success page or back to the dashboard
            response.sendRedirect("MarketerDashboard");
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to an error page or show an error message
            response.sendRedirect("errorPage.jsp");
        }
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
