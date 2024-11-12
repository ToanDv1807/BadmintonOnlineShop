/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common.product;

import dal.marketer.DAOBlog;
import dal.marketer.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Blog;
import model.BlogCategories;
import model.Products;

/**
 *
 * @author Acer
 */
public class SearchProduct extends HttpServlet {

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
            out.println("<title>Servlet SearchProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchProduct at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        // Lấy các tham số tìm kiếm
        String name_raw = request.getParameter("name");
        String catID_raw = request.getParameter("catID"); // Giả sử catID là String

        int catID = 0;
        if (catID_raw != null && !catID_raw.isEmpty()) {
            try {
                catID = Integer.parseInt(catID_raw); // Chuyển đổi catID thành số nguyên
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Ghi log lỗi nếu cần
            }
        }

        // Xử lý tên sản phẩm để loại bỏ khoảng trắng không cần thiết
        if (name_raw != null) {
            name_raw = name_raw.replaceAll("\\s+", " ").trim(); // Thay thế nhiều khoảng trắng bằng một khoảng trắng duy nhất và trim
        }

        // Lấy chỉ số trang
        String index_raw = request.getParameter("index");
        if (index_raw == null) {
            index_raw = "1";
        }
        int index = Integer.parseInt(index_raw);

        ProductDAO pd = new ProductDAO();

        // Kiểm tra xem tên sản phẩm có hợp lệ không
        if ((name_raw == null || name_raw.isEmpty()) && catID == 0) {
            // Nếu cả tên và catID đều rỗng, có thể gửi thông báo lỗi
            session.setAttribute("message", "Please provide a product name or select a category.");
            request.getRequestDispatcher("product-list.jsp").forward(request, response);
            return; // Dừng thực hiện nếu không có điều kiện tìm kiếm
        }

        // Lấy số lượng sản phẩm phù hợp với tìm kiếm
        int count = pd.getProductsBySearch(catID, name_raw).size();
        int endPage = (count + 9) / 10; // Tính số trang (làm tròn lên)

        // Tìm kiếm sản phẩm theo danh mục và tên
        List<Products> listPro = pd.getProductsByCatIDAndNamePage(catID, name_raw, index);

        // Lưu các thuộc tính vào session
        session.setAttribute("selectedCatID", catID);
        session.setAttribute("products", listPro);
        session.setAttribute("endPage", endPage);
        session.setAttribute("tag", index);
        session.setAttribute("option", 3);

        // Tạo thông báo cho người dùng dựa trên kết quả tìm kiếm
        String message;
        if (!listPro.isEmpty()) {
            message = "Found " + count + " products with name: '" + name_raw + "'";
        } else {
            message = "No products found with name: '" + name_raw + "'";
        }
        session.setAttribute("message1", message);

        request.getRequestDispatcher("product-list.jsp").forward(request, response);
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
