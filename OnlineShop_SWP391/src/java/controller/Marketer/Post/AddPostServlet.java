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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.Account;
import model.Blog;
import model.Employees;
import java.time.LocalDate;
import model.BlogSubtitles;

/**
 *
 * @author LENNOVO
 */
@MultipartConfig // Để hỗ trợ xử lý form có tệp tải lên (multipart/form-data)
@WebServlet(name = "AddPostServlet", urlPatterns = {"/AddPostServlet"})
public class AddPostServlet extends HttpServlet {

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
            // Lấy thông tin từ form
            String title = request.getParameter("title");
            String category = request.getParameter("category");
            String content = request.getParameter("content");
            String status = request.getParameter("status");
            // In ra giá trị để kiểm tra
            System.out.println("Title: " + title);
            System.out.println("Category: " + category);
            System.out.println("Content: " + content);

            // Lấy file thumbnail của bài viết chính
            Part thumbnailPart = request.getPart("thumbnail");
            String thumbnailFileName = saveFile(thumbnailPart, request);

            // Kiểm tra xem thumbnail đã lấy được chưa
            System.out.println("Thumbnail File Name: " + thumbnailFileName);

            MarketerDAO md = new MarketerDAO();
            HttpSession session = request.getSession(false);
            Account account = (Account) session.getAttribute("account");

            if (account == null) {
                throw new ServletException("User is not authenticated.");
            }

            Employees e = md.getEmployeeByEmail(account.getEmail());
            LocalDate currentDay = LocalDate.now();

            // Lưu bài viết vào database
            DAOBlog db = new DAOBlog();
            Blog b = new Blog(db.getLastBlogID() + 1, title, content, content.substring(0, Math.min(49, content.length())),
                    thumbnailFileName, currentDay.toString(), currentDay.toString(),
                    Integer.parseInt(category), e.getEmployeeID(), Integer.parseInt(status), 0);

            boolean isInserted = md.AddPost(b); // Gọi phương thức và kiểm tra kết quả


// Xử lý phần subtitles
            String[] subtitlesTitle = request.getParameterValues("subtitles[][title]");
            String[] subtitlesContent = request.getParameterValues("subtitles[][content]");

// Check if subtitlesTitle or subtitlesContent is null or empty
            if (subtitlesTitle != null && subtitlesContent != null && subtitlesTitle.length > 0 && subtitlesContent.length > 0) {
                Part[] subtitlesThumbnailParts = request.getParts().stream()
                        .filter(part -> part.getName().startsWith("subtitles[") && part.getName().endsWith("[thumbnail]"))
                        .toArray(Part[]::new);

                for (int i = 0; i < subtitlesTitle.length; i++) {
                    String subtitleTitle = subtitlesTitle[i];
                    String subtitleContent = subtitlesContent[i];

                    // Handle thumbnail file for subtitle (now optional)
                    String subtitleThumbnailFileName = null;
                    if (i < subtitlesThumbnailParts.length) {
                        subtitleThumbnailFileName = saveFile(subtitlesThumbnailParts[i], request);
                    }

                    // Create a new BlogSubtitles object and save it
                    BlogSubtitles bs = new BlogSubtitles(db.getLastBlogSubtitle() + 1, db.getLastBlogID(),
                            subtitleTitle, subtitleThumbnailFileName, subtitleContent);

                    boolean subtitleIsInserted = md.AddSubtitle(bs); // Call DAO method to insert subtitle

                    // Log the result for debugging
                    System.out.println("Subtitle Inserted: " + subtitleIsInserted);
                }
            } else {
                // Log or handle the case where subtitles are null or empty
                System.out.println("No subtitles provided.");
            }
            request.setAttribute("message", "Add Successful");
            request.getRequestDispatcher("AddPost.jsp").forward(request, response);
        }
    }

    private String saveFile(Part filePart, HttpServletRequest request) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null; // Không có file
        }
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("/assets/images/blog/BlogImg");
        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Đường dẫn file để lưu
        String filePath = uploadPath + File.separator + fileName;
        try {
            filePart.write(filePath); // Lưu file
        } catch (IOException e) {
            e.printStackTrace(); // In ra thông báo lỗi
            return null; // Trả về null nếu có lỗi
        }
        return fileName; // Trả về tên file đã lưu
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
        return "Servlet xử lý việc thêm bài viết với ảnh và subtitle";
    }// </editor-fold>

}
