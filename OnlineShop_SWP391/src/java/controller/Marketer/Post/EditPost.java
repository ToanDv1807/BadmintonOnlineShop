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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.BlogSubtitles;

/**
 * Servlet implementation class EditPost
 */
@MultipartConfig
@WebServlet(name = "EditPost", urlPatterns = {"/edit-post"})
public class EditPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            DAOBlog db = new DAOBlog();
            MarketerDAO md = new MarketerDAO();
            String postId_raw = request.getParameter("postId");

            if (postId_raw != null && !postId_raw.isEmpty()) {
                int postId = Integer.parseInt(postId_raw);
                // Get the post data
                String title = request.getParameter("title");
                String category = request.getParameter("category");
                String content = request.getParameter("content");
                String briefInfo = request.getParameter("brief-info");
                String status = request.getParameter("Status");
                String featured = request.getParameter("featured");
                Part thumbnailPart = request.getPart("thumbnail");
                String thumbnailFileName = saveFile(thumbnailPart, request);

                // Validate user session
                HttpSession session = request.getSession(false);
                Account account = (Account) session.getAttribute("account");
                if (account == null) {
                    throw new ServletException("User is not authenticated.");
                }

                // Retrieve employee and current date
                Employees employee = md.getEmployeeByEmail(account.getEmail());
                LocalDate currentDay = LocalDate.now();

                // Fetch the existing blog post
                Blog existingBlog = db.getBlogByBlogID(postId);
                if (existingBlog == null) {
                    request.setAttribute("errorMessage", "Blog post not found.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                    return;
                }

                // Use existing image if new image is not provided
                if (thumbnailFileName == null || thumbnailFileName.isEmpty()) {
                    thumbnailFileName = existingBlog.getBlogImgUrl();
                }

                // Update main blog post
                Blog updatedBlog = new Blog(postId, title, content,
                        briefInfo,
                        thumbnailFileName, existingBlog.getCreatedDate(),
                        currentDay.toString(), Integer.parseInt(category),
                        employee.getEmployeeID(), Integer.parseInt(status),
                        Integer.parseInt(featured));

                boolean isUpdated = md.updatePost(updatedBlog);

                for (Part part : request.getParts()) {
                    System.out.println("Part Name: " + part.getName() + ", Size: " + part.getSize());
                }
                // Handle subtitles
                handleSubtitles(request, postId, db, md);

                // Update session and redirect to PostDetail.jsp
                Blog blogToDisplay = db.getBlogByBlogID(postId);
                List<BlogSubtitles> subtitleToDisplay = db.getBlogSubtitlesByBlogID(postId);
                session.setAttribute("blogForEdit", blogToDisplay);
                session.setAttribute("subtitleForEdit", subtitleToDisplay);
                request.getRequestDispatcher("PostDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Post ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Post ID.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleSubtitles(HttpServletRequest request, int postId, DAOBlog db, MarketerDAO md) throws IOException, ServletException {
        List<BlogSubtitles> existingSubtitles = getExistingSubtitles(request, postId, md);
        updateExistingSubtitles(existingSubtitles, md);

        List<BlogSubtitles> newSubtitles = getNewSubtitles(request, postId, db);
        insertNewSubtitles(newSubtitles, md);

        deleteSubtitles(request, md);
    }

    private List<BlogSubtitles> getExistingSubtitles(HttpServletRequest request, int postId, MarketerDAO md) throws IOException, ServletException {
        List<BlogSubtitles> existingSubtitles = new ArrayList<>();
        int index = 0;
        while (true) {
            String subtitleId = request.getParameter("existingSubtitles[" + index + "][id]");
            String subtitleTitle = request.getParameter("existingSubtitles[" + index + "][title]");
            String subtitleContent = request.getParameter("existingSubtitles[" + index + "][content]");

            Part thumbnailPart = request.getPart("existingSubtitles[" + index + "][thumbnail]");
            String thumbnailFileName = null;

            // Get existing thumbnail name from the database if no new thumbnail is uploaded
            if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
                thumbnailFileName = saveFile(thumbnailPart, request); // Save the new thumbnail file
            } else {
                // If no new thumbnail is uploaded, get the existing one from the database
                try {
                    int parsedSubtitleId = Integer.parseInt(subtitleId);
                    // Retrieve existing subtitle to get the current thumbnail file name
                    BlogSubtitles existingSubtitle = md.getSubtitleById(parsedSubtitleId);
                    if (existingSubtitle != null) {
                        thumbnailFileName = existingSubtitle.getImgUrl(); // Keep the existing thumbnail
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid subtitle ID: " + subtitleId);
                }
            }

            if (subtitleId == null && subtitleTitle == null && subtitleContent == null) {
                break; // No more existing subtitles
            }

            if (isSubtitleValid(subtitleId, subtitleTitle, subtitleContent)) {
                try {
                    int parsedSubtitleId = Integer.parseInt(subtitleId);
                    // Add the thumbnail filename to the BlogSubtitles object
                    existingSubtitles.add(new BlogSubtitles(parsedSubtitleId, postId, subtitleTitle, thumbnailFileName, subtitleContent));
                } catch (NumberFormatException e) {
                    System.out.println("Invalid subtitle ID: " + subtitleId);
                }
            }
            index++;
        }
        return existingSubtitles;
    }

    private boolean isSubtitleValid(String id, String title, String content) {
        // Add debugging to identify why validation might be failing
        System.out.println("Validating subtitle: Title=" + title + ", Content=" + content);

        // Ensure title and content are non-null and non-empty
        if (title == null || title.isEmpty()) {
            System.out.println("Invalid subtitle: Title is null or empty.");
            return false;
        }
        if (content == null || content.isEmpty()) {
            System.out.println("Invalid subtitle: Content is null or empty.");
            return false;
        }

        // Additional validation logic if needed
        // Example: if there are specific patterns or rules for titles or content
        return true;  // Return true if both title and content are valid
    }

    private void updateExistingSubtitles(List<BlogSubtitles> existingSubtitles, MarketerDAO md) {
        for (BlogSubtitles subtitle : existingSubtitles) {
            boolean isUpdated = md.updateSubtitle(subtitle);
            System.out.println("Updated existing subtitle ID " + subtitle.getSubtitleID() + ": " + isUpdated);
        }
    }

    private List<BlogSubtitles> getNewSubtitles(HttpServletRequest request, int postId, DAOBlog db) throws IOException, ServletException {
        List<BlogSubtitles> newSubtitles = new ArrayList<>();

        // Lấy danh sách tiêu đề, nội dung, và thumbnail
        String[] titleArray = request.getParameterValues("newSubtitles[][title]");
        String[] contentArray = request.getParameterValues("newSubtitles[][content]");

        // Lọc các phần thumbnail từ request
        Part[] thumbnailParts = request.getParts().stream()
                .filter(part -> part.getName().startsWith("newSubtitles[") && part.getName().endsWith("[thumbnail]"))
                .toArray(Part[]::new);

        // Kiểm tra tính nhất quán giữa tiêu đề, nội dung và thumbnail
        if ((titleArray != null && contentArray != null)
                && (titleArray.length == contentArray.length)
                && (titleArray.length == thumbnailParts.length)) {

            // Lặp qua từng tiêu đề, nội dung và thumbnail
            for (int i = 0; i < titleArray.length; i++) {
                String title = titleArray[i] != null ? titleArray[i].trim() : "";
                String content = contentArray[i] != null ? contentArray[i].trim() : "";

                // Xử lý thumbnail cho subtitle
                String newThumbnailFileName = null;
                if (i < thumbnailParts.length) {
                    Part newThumbnailPart = thumbnailParts[i];
                    if (newThumbnailPart != null && newThumbnailPart.getSize() > 0) {
                        newThumbnailFileName = saveFile(newThumbnailPart, request);
                        System.out.println("Thumbnail File: " + newThumbnailFileName);
                    } else {
                        System.out.println("No thumbnail uploaded for subtitle #" + (i + 1));
                    }
                }

                // Thêm mới subtitle nếu hợp lệ
                if (isSubtitleValid(null, title, content)) {
                    int newSubtitleId = db.getLastBlogSubtitle() + 1;
                    BlogSubtitles subtitle = new BlogSubtitles(newSubtitleId, postId, title, newThumbnailFileName, content);
                    newSubtitles.add(subtitle);
                } else {
                    System.out.println("Invalid subtitle: Title=" + title + ", Content=" + content);
                }
            }
        } else {
            System.out.println("Mismatched number of titles, contents, or thumbnails");
        }

        // Ghi lại danh sách subtitle mới đã thêm
        System.out.println("List of New Subtitles: " + newSubtitles);

        return newSubtitles;
    }

    private void insertNewSubtitles(List<BlogSubtitles> newSubtitles, MarketerDAO md) {
        for (BlogSubtitles subtitle : newSubtitles) {
            boolean isInserted = md.AddSubtitle(subtitle);
            System.out.println("Inserted new subtitle: " + isInserted);
        }
    }

    private void deleteSubtitles(HttpServletRequest request, MarketerDAO md) {
        // Lấy các giá trị của subtitle cần xóa
        String[] subtitlesToDelete = request.getParameterValues("subtitlesToDelete");

        if (subtitlesToDelete != null) {
            for (String subtitleId : subtitlesToDelete) {
                // Nếu subtitleId có chứa dấu phẩy (chuỗi kết hợp nhiều ID), tách chuỗi ra
                String[] individualSubtitleIds = subtitleId.split(",");
                for (String individualId : individualSubtitleIds) {
                    try {
                        int id = Integer.parseInt(individualId.trim()); // Loại bỏ khoảng trắng nếu có
                        boolean isDeleted = md.deleteSubtitle(id);
                        System.out.println("Deleted subtitle ID " + id + ": " + isDeleted);
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid subtitle ID for deletion: " + individualId);
                    }
                }
            }
        }
    }

    private String saveFile(Part filePart, HttpServletRequest request) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null; // No file uploaded
        }

        // Get the file name from the part and ensure it's not null or empty
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        // Define the upload path (adjust this path according to your server's structure)
        String uploadPath = getServletContext().getRealPath("/assets/images/blog/BlogImg");

        // Create directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // Make directories if needed
        }

        // Ensure the file name is unique to avoid overwriting
        File file = new File(uploadDir, fileName);
        int count = 1;
        while (file.exists()) {
            String newFileName = fileName.substring(0, fileName.lastIndexOf('.')) + "_" + count + fileName.substring(fileName.lastIndexOf('.'));
            file = new File(uploadDir, newFileName);
            count++;
        }

        // Save the file to the desired path
        try {
            filePart.write(file.getAbsolutePath());
        } catch (IOException e) {
            e.printStackTrace();
            return null; // Return null if there's an issue saving the file
        }

        // Return the relative path or file name for storage in the database
        return file.getName();
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
        return "EditPost Servlet";
    }
}
