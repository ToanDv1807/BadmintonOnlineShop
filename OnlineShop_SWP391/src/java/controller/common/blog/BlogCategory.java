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
@WebServlet(name = "BlogCategory", urlPatterns = {"/blog-category"})
public class BlogCategory extends HttpServlet {

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
            String cid_raw = request.getParameter("cid");
            try {
                int cid = Integer.parseInt(cid_raw);
                String index_raw = request.getParameter("index");
                if (index_raw == null) {
                    index_raw = "1";
                }
                int index = Integer.parseInt(index_raw);
                DAOBlog d = new DAOBlog();
                int count = d.getAllBlogByCategoryBlogId(cid).size();
                int endPage = count / 4;
                if (count % 4 != 0) {
                    endPage++;
                }
                List<Blog> blogs = d.getPagingBlogByCategoryBlogId(cid, index);
                List<BlogCategories> categories = d.getAllBlogCategories();
                request.setAttribute("blogs", blogs);
                request.setAttribute("categories", categories);
                request.setAttribute("endPage", endPage);
                request.setAttribute("tag", index);
                request.setAttribute("option", "2");
                String catName = d.getCategoryNameByCID(cid);
                request.setAttribute("catName", catName);
                request.getRequestDispatcher("BlogList.jsp").forward(request, response);
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
