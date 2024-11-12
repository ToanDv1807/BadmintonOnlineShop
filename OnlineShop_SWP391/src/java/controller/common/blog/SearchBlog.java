/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common.blog;

import dal.marketer.DAOBlog;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;
import model.BlogCategories;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "SearchBlog", urlPatterns = {"/search"})
public class SearchBlog extends HttpServlet {

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
            String input = request.getParameter("input");
            if (input != null && !input.isEmpty()) {
                String index_raw = request.getParameter("index");
                if (index_raw == null) {
                    index_raw = "1";
                }
                int index = Integer.parseInt(index_raw);
                DAOBlog d = new DAOBlog();
                int count = d.getBlogsByName(input).size();
                int endPage = count / 4;
                if (count % 4 != 0) {
                    endPage++;
                }
                List<Blog> blogs = d.getPagingBlogByName(input, index);
                List<BlogCategories> categories = d.getAllBlogCategories();
                request.setAttribute("blogs", blogs);
                request.setAttribute("categories", categories);
                request.setAttribute("endPage", endPage);
                request.setAttribute("tag", index);
                request.setAttribute("option", 3);
                if (!blogs.isEmpty()) {
                    String message = "Founded " + count + " blogs with name: '" + input + "'";
                    request.setAttribute("message", message);
                } else {
                    String message = "Not founded blog with name: '" + input + "'";
                    request.setAttribute("message", message);
                }

                request.getRequestDispatcher("BlogList.jsp").forward(request, response);
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
