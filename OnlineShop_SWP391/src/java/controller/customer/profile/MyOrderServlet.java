/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.profile;

import dal.marketer.CategoryDAO;
import dal.common.ChangeDAO;
import dal.customer.MyOrderDAO;
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
import model.Category;
import model.Customers;
import model.Order;
import model.Products;

/**
 *
 * @author Tan
 */
public class MyOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet MyOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyOrderServlet at " + request.getContextPath() + "</h1>");
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
        String search = request.getParameter("query");
        ChangeDAO cd = new ChangeDAO();
        Account a = (Account) session.getAttribute("account");
        Customers c = cd.getCustomersByEmail(a.getEmail());
        MyOrderDAO mod = new MyOrderDAO();
        
        float total = mod.getToTalAmount(c.getCustomerID());
        
        if (search == null) {
            // Lấy thông tin tài khoản hiện tại từ session

            // Xử lý phân trang cho danh sách đơn hàng
            // Nhận tham số `page` từ request, nếu không có thì gán giá trị mặc định là 1
            String indexPage = request.getParameter("page");
            int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage); // Trang hiện tại

            // Số lượng bản ghi trên mỗi trang
            int pageSize = 10;

            // Lấy danh sách các chi tiết đơn hàng của khách hàng theo trang
            List<Order> listOrder = mod.getOrderOfCusByID(c.getCustomerID(), index);

            // Lấy tổng số bản ghi để tính tổng số trang
            int count = mod.getTotalOfOrder(c.getCustomerID());
            int endPage = count / pageSize;
            if (count % pageSize != 0) {
                endPage++;
            }
            // Đặt các thuộc tính cần thiết cho JSP
            request.setAttribute("totalAmountSum", total);
            request.setAttribute("list", listOrder);  // Danh sách đơn hàng
            request.setAttribute("endP", endPage);  // Tổng số trang
            request.setAttribute("currentPage", index);  // Trang hiện tại

            // Chuyển tiếp đến trang JSP `myorder.jsp`
            request.getRequestDispatcher("myorder.jsp").forward(request, response);
        } else {
            PrintWriter out = response.getWriter();

            // Nhận tham số `page` từ request, nếu không có thì gán giá trị mặc định là 1
            String indexPage = request.getParameter("page");
            int index = (indexPage == null) ? 1 : Integer.parseInt(indexPage); // Trang hiện tại

            // Số lượng bản ghi trên mỗi trang
            int pageSize = 10;

            // Lấy danh sách các chi tiết đơn hàng của khách hàng theo trang
            List<Order> listOrder = mod.searchOrder(c.getCustomerID(), index, search);

            // Lấy tổng số bản ghi để tính tổng số trang
            int count = mod.getTotalSearch(c.getCustomerID(), search);
            int endPage = count / pageSize;
            if (count % pageSize != 0) {
                endPage++;
            }

            // Đặt các thuộc tính cần thiết cho JSP
            request.setAttribute("totalAmountSum", total);
            request.setAttribute("list", listOrder);  // Danh sách đơn hàng
            request.setAttribute("endP", endPage);  // Tổng số trang
            request.setAttribute("currentPage", index);  // Trang hiện tại

            // Chuyển tiếp đến trang JSP `myorder.jsp`
            request.getRequestDispatcher("myorder.jsp").forward(request, response);
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
