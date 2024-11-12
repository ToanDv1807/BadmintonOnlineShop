/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.setting;

import dal.common.PermissionDAO;
import dal.admin.SettingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Setting;
import model.TypeSetting;

/**
 *
 * @author Asus
 */
public class SettingList extends HttpServlet {
        // Phương thức kiểm tra session và quyền truy cập
    private boolean checkSessionAndRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo session mới nếu không tồn tại
        if (session == null || session.getAttribute("account") == null) {
            // Nếu không có session hoặc chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return false;
        }

        Account account = (Account) session.getAttribute("account");
        if (!"Employee".equals(account.getUserType())) {
            // Nếu không phải là nhân viên chuyển hướng đến trang lỗi hoặc đăng nhập
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        // Kiểm tra quyền truy cập dựa vào URL
        PermissionDAO permissionDAO = new PermissionDAO();
        String currentUrl = request.getRequestURL().toString();
        int roleID = account.getRoleID();

        // Lấy danh sách các URL mà roleID có thể truy cập
        List<String> allowedUrls = permissionDAO.getPermissionsByRole(roleID);

        // Kiểm tra nếu URL hiện tại nằm trong danh sách URL được phép
        if (!allowedUrls.contains(currentUrl)) {
            response.sendRedirect("unauthorized.jsp");
            return false;
        }

        return true; // Nếu session và quyền hợp lệ, cho phép tiếp tục truy cập
    }
   
        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (checkSessionAndRole(request, response)) {
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            final int PAGE_SIZE = 5;  // Tong so dong moi trang
            SettingDAO sd = new SettingDAO();
            // Set page
            int page = 1;
            String strPage = request.getParameter("page");
            if (strPage != null) {
                page = Integer.parseInt(strPage);
            }

            // Set key for search 
            String searchKey = "";
            String strSearchKey = request.getParameter("key");
            if (strSearchKey != null) {
                searchKey = strSearchKey;
            }

            // Set category
            String typeId = "!= -1";
            String strTypeId = request.getParameter("typeId");
            if (strTypeId != null) {
                typeId = "= " + strTypeId;
            }

            // Set sort 
            String value = "type";
            String type = "";
            String strType = request.getParameter("type");
            String strValue = request.getParameter("value");
            if (strType != null) {
                type = strType;
            }
            if (strValue != null) {
                value = strValue;
            }

            // Set status
            String status = "!= -1";
            String strStatus = request.getParameter("status");
            if (strStatus != null) {
                status = "= " + strStatus;
            }


            // Set total page 
            int totalSetting = sd.getTotalSetting(searchKey, typeId, status);
            int totalPage = totalSetting / PAGE_SIZE;
            if (totalSetting % PAGE_SIZE != 0) {
                totalPage += 1;
            }

            // Get list product, new, category, slider
            List<Setting> listSetting = sd.getSettingWithPaging(page, PAGE_SIZE, searchKey, typeId, type, value, status);
            List<TypeSetting> listTypeSetting = sd.getAllSettingType();
            session.setAttribute("listTypeSetting", listTypeSetting);

            // Set param request to jsp page
            String history = "SettingList?page=" + page;
            if (strSearchKey != null) {
                history = history + "&key=" + strSearchKey;
                request.setAttribute("historyKey", "&key=" + strSearchKey);
                request.setAttribute("key", strSearchKey);
            }
            if (strTypeId != null) {
                history = history + "&typeId=" + strTypeId;
                request.setAttribute("historyTypeId", "&typeId=" + strTypeId);
                request.setAttribute("typeId", strTypeId);
            }
            if (strValue != null) {
                history = history + "&value=" + strValue;
                request.setAttribute("historyValue", "&value=" + strValue);
                request.setAttribute("value", strValue);
            }
            if (strType != null) {
                history = history + "&type=" + strType;
                request.setAttribute("historyType", "&type=" + strType);
                request.setAttribute("type", strType);
            }
            if (strStatus != null) {
                history = history + "&status=" + strStatus;
                request.setAttribute("historyStatus", "&status=" + strStatus);
                request.setAttribute("status", strStatus);
            }
            
            request.setAttribute("listSetting", listSetting);
            request.setAttribute("page", page);
            request.setAttribute("totalPage", totalPage);
            session.setAttribute("historyUrl", history);

            // Request
            request.getRequestDispatcher("setting_list.jsp").forward(request, response);
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
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>
}
