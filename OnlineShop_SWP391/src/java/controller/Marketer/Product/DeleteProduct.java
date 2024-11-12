/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.Product;

import dal.marketer.MarketerDAO;
import dal.marketer.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Blog;

/**
 *
 * @author Acer
 */
public class DeleteProduct extends HttpServlet {

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
            out.println("<title>Servlet DeleteProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteProduct at " + request.getContextPath() + "</h1>");
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

        // Thiết lập content type để phản hồi là HTML
        response.setContentType("text/html;charset=UTF-8");

        // Tạo PrintWriter để ghi thông tin vào response
        PrintWriter out = response.getWriter();

        try {
            String productID_raw = request.getParameter("productID");
            out.println("Raw productID: " + productID_raw); // Kiểm tra giá trị của productID_raw

            int productID = 0;

            if (productID_raw != null && !productID_raw.isEmpty()) {
                try {
                    productID = Integer.parseInt(productID_raw);
                    out.println("Parsed productID: " + productID); // Kiểm tra giá trị đã phân tích
                } catch (NumberFormatException e) {
                    out.println("Invalid productID format.");
                    request.getSession().setAttribute("deleteErrorMessage", "Invalid product ID.");
                    response.sendRedirect("MarketerDashboard");
                    return; // Dừng xử lý nếu productID không hợp lệ
                }
            } else {
                out.println("productID_raw is null or empty.");
                request.getSession().setAttribute("deleteErrorMessage", "Product ID is required.");
                response.sendRedirect("MarketerDashboard");
                return; // Dừng xử lý nếu productID không được cung cấp
            }

            ProductDAO pd = new ProductDAO();
            out.println("ProductDAO instance created."); // Kiểm tra xem instance được tạo thành công không

            // Kiểm tra quantity của sản phẩm trước khi xóa
            int quantity = pd.getProductQuantity(productID); // Hàm này cần được định nghĩa trong ProductDAO
            out.println("Product quantity: " + quantity); // Kiểm tra quantity

            if (quantity == 0) {
                // Xóa sản phẩm nếu quantity bằng 0
                boolean isDeleted = pd.delete(productID);
                out.println("Called delete method for productID: " + productID); // Kiểm tra xem phương thức delete đã được gọi không

                HttpSession session = request.getSession();

                if (isDeleted) {
                    // Đặt thông báo thành công nếu xóa thành công
                    session.setAttribute("deleteSuccessMessage", "Product deleted successfully.");
                    out.println("Product deleted successfully."); // Kiểm tra thông báo
                } else {
                    // Đặt thông báo lỗi nếu không xóa được sản phẩm
                    session.setAttribute("deleteErrorMessage", "Failed to delete the product. Product may not exist.");
                    out.println("Failed to delete the product."); // Kiểm tra thông báo lỗi
                }
            } else {
                // Nếu quantity lớn hơn 0, không cho phép xóa
                HttpSession session = request.getSession();
                session.setAttribute("deleteErrorMessage", "Cannot delete product with quantity greater than 0.");
                out.println("Cannot delete product with quantity greater than 0."); // Kiểm tra thông báo lỗi
            }

            // Chuyển hướng về trang MarketerDashboard
            response.sendRedirect("MarketerDashboard");
            out.println("Redirecting to MarketerDashboard"); // Kiểm tra xem có thực hiện chuyển hướng không

        } catch (Exception e) {
            // Log the exception and redirect to an error page or dashboard
            e.printStackTrace(out); // Ghi lỗi vào PrintWriter
            request.getSession().setAttribute("deleteErrorMessage", "An error occurred while deleting the product.");
            out.println("An error occurred: " + e.getMessage()); // In thông báo lỗi
            response.sendRedirect("MarketerDashboard"); // Redirect back to the dashboard
        } finally {
            out.close(); // Đảm bảo PrintWriter được đóng
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
