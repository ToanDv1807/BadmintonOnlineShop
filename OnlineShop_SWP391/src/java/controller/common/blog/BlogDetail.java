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
import model.BlogSubtitles;
import model.Employees;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "BlogDetail", urlPatterns = {"/blog-detail"})
public class BlogDetail extends HttpServlet {

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
            String bid_raw = request.getParameter("bid");
            try {
                int bid = Integer.parseInt(bid_raw);
                DAOBlog d = new DAOBlog();
                Blog b = d.getBlogByBlogID(bid);
                List<Blog> blogs = d.getBlogsByCategoryID(b.categoryID);
                Employees e = d.getEmployeeByBlogID(bid);
                List<BlogSubtitles> bs = d.getBlogSubtitlesByBlogID(bid);
                List<BlogCategories> c = d.getAllBlogCategories();
                request.setAttribute("blog", b);
                request.setAttribute("employee", e);
                request.setAttribute("subtitles", bs);
                request.setAttribute("categories", c);
                request.setAttribute("relatedBlogs", blogs);
                request.setAttribute("updatedDate", b.updatedDate.substring(0, 10));
                request.getRequestDispatcher("BlogDetail.jsp").forward(request, response);
            } catch (Exception e) {
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
