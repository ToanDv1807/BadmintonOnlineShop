/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.Post;

import dal.marketer.DAOBlog;
import dal.marketer.MarketerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Blog;

/**
 *
 * @author LENNOVO
 */
@WebServlet(name = "DeletePost", urlPatterns = {"/delete-post"})
public class DeletePost extends HttpServlet {

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
        PrintWriter out = response.getWriter(); // Moved out of the try-with-resources
        try {
            String blogId_raw = request.getParameter("blogId");
            int blogId = 0;
            if (blogId_raw != null && !blogId_raw.isEmpty()) {
                blogId = Integer.parseInt(blogId_raw);
            }

            MarketerDAO md = new MarketerDAO();
            // Delete all subtitles before deleting the blog
            boolean isDeletedSubtitle = md.deleteAllSubtitleByBlogID(blogId);
            // Delete the blog
            boolean isDeletedBlog = md.deleteBlogByBlogID(blogId);

            if (isDeletedBlog) {
                // Set success message in the request scope
                request.getSession().setAttribute("deleteSuccessMessage", "Post deleted successfully.");
                HttpSession session = request.getSession();
                List<Blog> filterBlog = md.getFilteredBlogs(null, null, null, null);
                session.setAttribute("blogs", filterBlog);
                // Redirect to the dashboard
                response.sendRedirect("marketer_dashboard.jsp");
            } else {
                // Handle the case where deletion fails
                request.getSession().setAttribute("deleteErrorMessage", "Failed to delete the post.");
                response.sendRedirect("PostDetail.jsp"); // Redirect back to the EditPost page
            }
        } catch (Exception e) {
            // Log the exception and redirect to an error page or dashboard
            e.printStackTrace();
            request.getSession().setAttribute("deleteErrorMessage", "An error occurred while deleting the post.");
            response.sendRedirect("PostDetail.jsp"); // Redirect back to the EditPost page
        } finally {
            out.close(); // Close the PrintWriter
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
