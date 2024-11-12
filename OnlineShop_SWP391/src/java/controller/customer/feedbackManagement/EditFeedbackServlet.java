/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.feedbackManagement;

import dal.customer.FeedbackDAO;
import dal.marketer.MarketerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customers;
import model.Feedback;

/**
 *
 * @author Tan
 */
public class EditFeedbackServlet extends HttpServlet {

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
            out.println("<title>Servlet EditFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditFeedbackServlet at " + request.getContextPath() + "</h1>");
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
        FeedbackDAO fd = new FeedbackDAO();
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        Feedback f = fd.getFeedbackByFID(feedbackID);
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        String attributeValue = request.getParameter("attributeValue");
        request.setAttribute("f", f);
        request.setAttribute("orderID", orderID);
        request.setAttribute("attributeValue", attributeValue);
        request.getRequestDispatcher("editfeedback.jsp").forward(request, response);
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
        int feedbackID = Integer.parseInt(request.getParameter("feedbackID"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        String attributeValue = request.getParameter("attributeValue");
        int productID = (int) session.getAttribute("productID");
        // Update feedback in the database
        FeedbackDAO fd = new FeedbackDAO();
        fd.updateFeedback(feedbackID, rating, comment);

        // Redirect back to the feedback list or another page
        session.setAttribute("messReviewUpdate", "Update successfull");
        response.sendRedirect("viewFeedback?productID=" + productID+"&attributeValue="+attributeValue+"&orderID="+orderID);
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
