/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.warehouse.product;

import dal.marketer.AttributeDAO;
import dal.marketer.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Acer
 */
public class DeleteProductWarehouse extends HttpServlet {

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
            out.println("<title>Servlet DeleteProductWarehouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteProductWarehouse at " + request.getContextPath() + "</h1>");
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

        response.setContentType("text/html;charset=UTF-8");

        // Use try-with-resources for PrintWriter to ensure it's closed properly
        try (PrintWriter out = response.getWriter()) {
            String productID_raw = request.getParameter("productID");
            String attributeValue = request.getParameter("attributeValue");

            // Validate and parse productID
            int productID = 0;
            try {
                productID = Integer.parseInt(productID_raw);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("deleteErrorMessage", "Invalid product ID.");
                response.sendRedirect("EditProduct");
                return; // Exit early if productID is invalid
            }

            AttributeDAO dao = new AttributeDAO();

            // Call the method to delete the attribute
            boolean isDeleted = dao.deleteProductAttribute(productID, attributeValue);

            HttpSession session = request.getSession();
            if (isDeleted) {
                session.setAttribute("deleteSuccessMessage", "Attribute deleted successfully.");
            } else {
                session.setAttribute("deleteErrorMessage", "Failed to delete the attribute. It may not exist.");
            }

            // Redirect back to the EditProduct page with the productID
            response.sendRedirect("EditProduct?productID=" + productID);

        } catch (Exception e) {
            // Log the error and set an error message
            e.printStackTrace(); // Optionally log to a file or logging framework
            request.getSession().setAttribute("deleteErrorMessage", "An error occurred while deleting the attribute.");
            response.sendRedirect("EditProduct");
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
