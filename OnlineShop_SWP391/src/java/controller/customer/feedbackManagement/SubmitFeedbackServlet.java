/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.feedbackManagement;

import dal.common.ChangeDAO;
import dal.customer.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Account;
import model.Customers;
import model.Feedback;

/**
 *
 * @author Tan
 */
public class SubmitFeedbackServlet extends HttpServlet {

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
            out.println("<title>Servlet SubmitFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubmitFeedbackServlet at " + request.getContextPath() + "</h1>");
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
        String productID = request.getParameter("productID");
        String attributeValue = request.getParameter("attributeValue");
        //lay thong tin nguoi dung
        ChangeDAO cdao = new ChangeDAO();
        Account a = (Account) session.getAttribute("account");
        Customers c = cdao.getCustomersByEmail(a.getEmail());
        FeedbackDAO fd = new FeedbackDAO();
        int orderID = (int) session.getAttribute("orderID");
        int numberFeedbackOfCustomer = fd.countNoOfFBOfCustomer(c.getCustomerID(), Integer.parseInt(productID), attributeValue, orderID);
        int numberOfProduct = fd.countNumberBuyOfProduct(Integer.parseInt(productID), c.getCustomerID(), orderID, attributeValue);
        if (numberFeedbackOfCustomer >= numberOfProduct) {
            session.setAttribute("messReview", "You can only give feedback once per purchase");
            response.sendRedirect("viewProductToFeedback?orderID=" + orderID);

        } else {
            request.setAttribute("productID", productID);
            request.setAttribute("attributeValue", attributeValue);
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        FeedbackDAO fbd = new FeedbackDAO();
        //lay thong tin nguoi dung
        ChangeDAO cdao = new ChangeDAO();
        Account a = (Account) session.getAttribute("account");
        Customers c = cdao.getCustomersByEmail(a.getEmail());

        //lay feedback
        int rating = Integer.parseInt(request.getParameter("rating"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        String attributeValue = request.getParameter("attributeValue");
        int orderID = (int) session.getAttribute("orderID");
        String comment = request.getParameter("comment");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String dateString = dateFormat.format(date);
        int sizeID = fbd.getSizeIDByName(attributeValue);
        Feedback f = new Feedback(c.getCustomerID(), productID, rating, comment, 1, dateString, orderID, sizeID);
        fbd.addAFeedback(f);
        session.setAttribute("messReview", "Add new review successfull");
        response.sendRedirect("viewProductToFeedback?orderID=" + orderID);
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
