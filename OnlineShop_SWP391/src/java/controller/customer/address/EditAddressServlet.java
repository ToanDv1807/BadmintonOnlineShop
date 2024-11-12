/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.address;

import dal.customer.AddressDAO;
import dal.common.ChangeDAO;
import dal.marketer.MarketerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Address;
import model.Customers;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "EditAddressServlet", urlPatterns = {"/EditAddressServlet"})
public class EditAddressServlet extends HttpServlet {

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
        String id = request.getParameter("addressId");
        String editedAddress = request.getParameter("editedAddress");
        AddressDAO ad = new AddressDAO();
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        ChangeDAO cd = new ChangeDAO();
        Customers customers = cd.getCustomersByEmail(a.getEmail());
        if (id.equals("primary")) {
            ad.updatedPrimaryAddress(editedAddress, customers.getCustomerID());
        } else {
            ad.updatedAddress(Integer.parseInt(id), editedAddress);
        }
        Customers customers1 = cd.getCustomersByEmail(a.getEmail());
        MarketerDAO md = new MarketerDAO();
        List<Address> addresses = md.getAllAddressByCid(customers.getCustomerID());
        request.setAttribute("message", "Update Successful");
        session.setAttribute("customerToGetAddress", customers1);
        session.setAttribute("addresses", addresses);
        request.getRequestDispatcher("EditShippingAddress.jsp").forward(request, response);
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
