/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.orderManagement;
import dal.common.ChangeDAO;
import dal.common.OrderDAO;
import model.OrderDetail;
import dal.common.OrderDetailDAO;
import dal.customer.ProductCartDAO;
import dal.marketer.SizeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Account;
import model.Customers;
import model.Products;
import model.Size;

/**
 *
 * @author MSI1
 */
public class OrderInformationServlet extends HttpServlet {
    
    OrderDetailDAO orderDetailDao = new OrderDetailDAO();
    ChangeDAO changeDao = new ChangeDAO();
    ProductCartDAO productCartDAO = new ProductCartDAO();
    OrderDAO orderDao = new OrderDAO();
    SizeDAO sizeDao = new SizeDAO();
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int orderId = Integer.parseInt(request.getParameter("orderID"));
        Account a = (Account) session.getAttribute("account");
        Customers customer = changeDao.getInformationOrderByEmailAndOrderID(a.getEmail(), orderId);
        
        List<OrderDetail> listOrderDetail = orderDetailDao.getOrderDetailByOrderID(orderId);
        List<Products> listProduct = productCartDAO.getAllProduct();
        List<Size> listSizeAll = sizeDao.getAllSize();
        String statusName = orderDao.getStatusByOrderID(orderId);
        Float totalAmount = orderDao.getTotalAmountOfOrderByOrderID(orderId);
        
        session.setAttribute("listOrderDetail", listOrderDetail);
        session.setAttribute("listSizeAll", listSizeAll);
        session.setAttribute("listProduct", listProduct);
        request.setAttribute("customer", customer);
        request.setAttribute("statusName", statusName);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("order_information.jsp").forward(request, response);
        
        
    }


    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }



}



