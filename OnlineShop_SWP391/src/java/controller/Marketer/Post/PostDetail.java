/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.Post;

import dal.marketer.DAOBlog;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Blog;
import java.util.List;
import model.BlogSubtitles;

/**
 *
 * @author LENNOVO
 */
@MultipartConfig
@WebServlet(name = "PostDetail", urlPatterns = {"/post-detail"})
public class PostDetail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        DAOBlog db = new DAOBlog(); // Khởi tạo DAO một lần

        try (PrintWriter out = response.getWriter()) {
            String bid_raw = request.getParameter("bid");
            if (bid_raw != null && !bid_raw.isEmpty()) {
                int bid = Integer.parseInt(bid_raw);
                Blog blog = db.getBlogByBlogID(bid);
                List<BlogSubtitles> subtitles = db.getBlogSubtitlesByBlogID(bid);
                HttpSession session = request.getSession();
                session.setAttribute("blogForEdit", blog);
                session.setAttribute("subtitleForEdit", subtitles);
            }
            request.getRequestDispatcher("PostDetail.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet handling post updates";
    }
}
