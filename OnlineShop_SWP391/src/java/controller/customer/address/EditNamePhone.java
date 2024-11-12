/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.address;

import dal.customer.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customers;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "EditNameEmailPhone", urlPatterns = {"/edit-shipping-address"})
public class EditNamePhone extends HttpServlet {

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
            out.println("<title>Servlet EditNameEmailPhone</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditNameEmailPhone at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String field = request.getParameter("field");
        String newValue = request.getParameter("editedFullName"); // Default to fullName

        if ("phone".equals(field)) {
            newValue = request.getParameter("editedPhone");
        }

        // Obtain the session and the customer object (assumed to be in the session)
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("customerToGetAddress");

        // Update the customer's field based on the field parameter
        if (customer != null) {
            switch (field) {
                case "fullName":
                    customer.setFullName(newValue);
                    break;
                case "phone":
                    customer.setPhone(newValue);
                    break;
            }
            CustomerDAO cd = new CustomerDAO();
            boolean isUpdated = cd.updatedCustomer(customer);
            if (isUpdated) {
                request.setAttribute("message", "Your information has been updated successfully.");
                session.setAttribute("customerToGetAddress", customer);
                session.setAttribute("customerCheckOut", customer);
            } else {
                request.setAttribute("message", "Updated fail");
            }
        }
        request.getRequestDispatcher("EditShippingAddress.jsp").forward(request, response);
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
