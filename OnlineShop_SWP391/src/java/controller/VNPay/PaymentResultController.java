/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.VNPay;

import dal.marketer.AttributeDAO;
import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.common.ChangeDAO;
import dal.mail.Email;
import dal.common.OrderDAO;
import dal.common.OrderDetailDAO;
import model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Order;
import model.Product_Attribute_Stock;
import org.apache.jasper.tagplugins.jstl.core.ForEach;

/**
 *
 * @author MSI1
 */
public class PaymentResultController extends HttpServlet {

    CartDAO cartDao = new CartDAO();
    OrderDAO orderDao = new OrderDAO();
    OrderDetailDAO orderDetailDao = new OrderDetailDAO();
    AttributeDAO attributeDAO = new AttributeDAO();
    CartItemDAO cartItemDao = new CartItemDAO();
    ChangeDAO cd = new ChangeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account a = (Account) session.getAttribute("account");
        Customers cus = cd.getCustomersByEmail(a.getEmail());
        Cart cart = cartDao.getCartIdByUserId(cus.getCustomerID());
        String responseCode = request.getParameter("responseCode");
        int orderID = Integer.parseInt(request.getParameter("orderID"));

        if ("00".equals(responseCode)) {
            List<OrderDetail> listOrderDetail = orderDetailDao.getOrderDetailByOrderID(orderID);
            listOrderDetail.forEach(o -> {

                Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(o.getProductID(), o.getSizeID());
                int stock = (stockInfo != null) ? stockInfo.getStock() : 0; // Total stock from the database
                int hold = (stockInfo != null) ? stockInfo.getHold() : 0; // Current hold from the database

                stockInfo.setHold(stockInfo.getHold() + o.getQuantity());
                attributeDAO.updateHold(stockInfo.getHold(), stockInfo.getProductID(), stockInfo.getSizeID());

            });
            cartItemDao.deleteCartItemByCartID(cart.getCartID());
            
            session.removeAttribute("cart");
            session.removeAttribute("listCartItem");

            String subject = "Thank you for purchasing our products !";
            String noidung = "Dear " + cus.getFullName() + ",\n\n"
                    + "Thank you for being a valued customer of our store. We strive to provide the best experience for you.\n"
                    + "We would greatly appreciate. This is link about order information: \n\n";
            noidung = noidung + "http://localhost:9999/OnlineShop_SWP391/orderInformation?orderID=" + orderID + "\n";
            noidung += "Your opinion matters to us, and we hope to hear from you soon!\n\nBest regards,\nSport Store Team";
            Email.SendEmails(cus.getEmail(), subject, noidung);

            request.setAttribute("orderID", orderID);
            request.getRequestDispatcher("order_complete.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
