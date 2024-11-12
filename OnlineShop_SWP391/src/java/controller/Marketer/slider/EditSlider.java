/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.slider;

import dal.marketer.MarketerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import model.Slider;

/**
 *
 * @author LENNOVO
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB threshold before writing to disk
        maxFileSize = 1024 * 1024 * 10, // 10MB maximum file size
        maxRequestSize = 1024 * 1024 * 50 // 50MB maximum request size
)
@WebServlet(name = "EditSlider", urlPatterns = {"/edit-slider"})
public class EditSlider extends HttpServlet {

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
            out.println("<title>Servlet EditSlider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditSlider at " + request.getContextPath() + "</h1>");
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
        String sliderID = request.getParameter("sliderID");
        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String status = request.getParameter("status");
        String note = request.getParameter("note");

        Part imagePart = request.getPart("image");
        String fileName = imagePart.getSubmittedFileName();

        String imagePath = null;
        if (fileName != null && !fileName.isEmpty()) {
            // Path to save the uploaded image (you can change this to your actual path)
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/images/product-section-slider";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Saving the file
            imagePart.write(uploadPath + File.separator + fileName);
            imagePath = fileName;
        }
        MarketerDAO md = new MarketerDAO();
        Slider s = md.getSliderBySID(Integer.parseInt(sliderID));
        if (s != null) {
            s.setTitle(title);
            s.setBacklink(backlink);
            s.setStatus(Integer.parseInt(status));
            s.setNotes(note);

            // If a new image is uploaded, update the image path
            if (imagePath != null) {
                s.setSliderImgUrl(imagePath);
            }

            // Update the slider in the database
            boolean isUpdated = md.updateSlider(s);

            if (isUpdated) {
                request.getSession().setAttribute("message", "Slider updated successfully!");
            } else {
                request.getSession().setAttribute("message", "Error updating slider.");
            }
        }
        response.sendRedirect("slider-detail?sid=" + sliderID);
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
