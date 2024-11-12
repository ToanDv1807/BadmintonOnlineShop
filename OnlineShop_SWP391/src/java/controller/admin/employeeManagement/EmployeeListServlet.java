/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.employeeManagement;

import dal.admin.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Employees;
import model.Role;

/**
 *
 * @author Tan
 */
public class EmployeeListServlet extends HttpServlet {

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
            out.println("<title>Servlet EmployeeListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmployeeListServlet at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        HttpSession session=request.getSession();
        AdminDAO adminDAO = new AdminDAO();

        // Lấy tham số tìm kiếm và sắp xếp từ request
        String searchE = request.getParameter("searchEmployee");
        String sortE = request.getParameter("sortE");
        String filterGender = request.getParameter("filterGender");
        String filterRole = request.getParameter("filterRole");
        String filterStatus = request.getParameter("filterStatus");

        // Khởi tạo giá trị tìm kiếm và sắp xếp mặc định
        if (sortE == null || sortE.isEmpty()) {
            sortE = "employeeID";
        }
        if (searchE == null) {
            searchE = "";
        }

        // Xử lý phân trang cho Employee
        String indexPageE = request.getParameter("pageE");
        int indexE = (indexPageE == null) ? 1 : Integer.parseInt(indexPageE);

        // Gọi DAO để lấy danh sách nhân viên theo điều kiện tìm kiếm và lọc
        List<Employees> listEmp;
        List<Role> listRole = adminDAO.listRole();
        int countE;

        // Kiểm tra và xử lý nếu có bộ lọc nào được chọn
        if (filterGender != null && !filterGender.isEmpty()
                || filterRole != null && !filterRole.isEmpty()
                || filterStatus != null && !filterStatus.isEmpty()) {
            // Nếu có bộ lọc, sử dụng phương thức tìm kiếm theo bộ lọc
            listEmp = adminDAO.filterEmployees(searchE, indexE, sortE, filterGender, filterRole, filterStatus);
            countE = adminDAO.getTotalEmployeesByFilter(searchE, filterGender, filterRole, filterStatus);
        } else {
            // Nếu không có bộ lọc, hiển thị danh sách nhân viên như bình thường
            if (searchE.isEmpty()) {
                listEmp = adminDAO.pagingEmployees(indexE, sortE);
                countE = adminDAO.getTotalEmployees();
            } else {
                listEmp = adminDAO.searchEmployees(searchE, indexE, sortE);
                countE = adminDAO.getTotalEmployeesBySearch(searchE);
            }
        }

        int endPageE = (countE % 10 == 0) ? countE / 10 : (countE / 10) + 1;

        // Đặt thuộc tính cho JSP
        request.setAttribute("employees", listEmp);
        request.setAttribute("listRole", listRole);
        request.setAttribute("endPE", endPageE);
        session.setAttribute("currentPageE", indexE);
        request.setAttribute("searchEmployee", searchE);
        request.setAttribute("sortE", sortE);
        request.setAttribute("filterGender", filterGender);
        request.setAttribute("filterRole", filterRole);
        request.setAttribute("filterStatus", filterStatus);

        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("employeelist.jsp").forward(request, response);
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
