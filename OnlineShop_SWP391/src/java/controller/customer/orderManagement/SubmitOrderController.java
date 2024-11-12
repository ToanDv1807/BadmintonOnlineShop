/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.orderManagement;

import dal.marketer.AttributeDAO;
import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.common.ChangeDAO;
import dal.mail.Email;
import dal.common.OrderDAO;
import dal.common.OrderDetailDAO;
import dal.marketer.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Invoice;
import model.Order;
import model.OrderDetail;
import model.Product_Attribute_Stock;
import model.Products;

/**
 *
 * @author MSI1
 */
public class SubmitOrderController extends HttpServlet {

    CartDAO cartDao = new CartDAO();
    OrderDAO orderDao = new OrderDAO();
    OrderDetailDAO orderDetailDao = new OrderDetailDAO();
    CartItemDAO cartItemDao = new CartItemDAO();
    ProductDAO productDao = new ProductDAO();
    AttributeDAO attributeDAO = new AttributeDAO();

    ChangeDAO cd = new ChangeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account a = (Account) session.getAttribute("account");
        Customers cus = cd.getCustomersByEmail(a.getEmail());

        String payment = request.getParameter("payment");
        String note = request.getParameter("note");
        String address = request.getParameter("selectedAddress");

        int customerID = cus.getCustomerID();
        Timestamp orderDateTimestamp = new Timestamp(new Date().getTime());

        if (payment.equalsIgnoreCase("Cash on delivery - COD")) {
            int orderStatus = 2;

            Order order = new Order(1, customerID, orderDateTimestamp.toString(), orderStatus, note, payment, address);

            orderDao.insertOrder(order);
            order.setOrderID(orderDao.getOrderIdByCustomerID(customerID));
            orderDao.insertOrderAssignment(order);
            Cart cart = cartDao.getCartIdByUserId(customerID);

            List<CartItem> listCartItem = cartItemDao.getCartItemsByCartId(cart.getCartID());
            listCartItem.forEach(c -> {

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(order.getOrderID());
                orderDetail.setProductID(c.getProductID());
                orderDetail.setSizeID(c.getSizeID());
                orderDetail.setQuantity(c.getStock());

                Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(c.getProductID(), c.getSizeID());
                int stock = (stockInfo != null) ? stockInfo.getStock() : 0; // Total stock from the database
                int hold = (stockInfo != null) ? stockInfo.getHold() : 0; // Current hold from the database
                int availableStock = stock - hold; // Calculate available stock

                if (orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()) != 0) {
                    orderDetail.setPrice(orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()));
                } else {
                    orderDetail.setPrice(stockInfo.getPrice());
                }
                orderDetailDao.insertOrderDetail(orderDetail);

                cartItemDao.deleteCartItemFromDB(c.getCartItemID());

                stockInfo.setHold(stockInfo.getHold() + orderDetail.getQuantity());
                attributeDAO.updateHold(stockInfo.getHold(), stockInfo.getProductID(), stockInfo.getSizeID());

            });
            session.removeAttribute("cart");
            session.removeAttribute("listCartItem");

            String subject = "Thank you for purchasing our products !";
            String noidung = "Dear " + cus.getFullName() + ",\n\n"
                    + "Thank you for being a valued customer of our store. We strive to provide the best experience for you.\n"
                    + "We would greatly appreciate. This is link about order information: \n\n";
            noidung = noidung + "http://localhost:9999/OnlineShop_SWP391/orderInformation?orderID=" + order.getOrderID() + "\n";
            noidung += "Your opinion matters to us, and we hope to hear from you soon!\n\nBest regards,\nSport Store Team";
            Email.SendEmails(cus.getEmail(), subject, noidung);

            request.setAttribute("orderID", order.getOrderID());
            request.getRequestDispatcher("order_complete.jsp").forward(request, response);

        } else if (payment.equalsIgnoreCase("VN Pay")) {
            int orderStatus = 2;

            Order order = new Order(1, customerID, orderDateTimestamp.toString(), orderStatus, note, payment, address);

            orderDao.insertOrder(order);
            order.setOrderID(orderDao.getOrderIdByCustomerID(customerID));
            orderDao.insertOrderAssignment(order);
            Cart cart = cartDao.getCartIdByUserId(customerID);

            List<CartItem> listCartItem = cartItemDao.getCartItemsByCartId(cart.getCartID());
            listCartItem.forEach(c -> {

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderID(order.getOrderID());
                orderDetail.setProductID(c.getProductID());
                orderDetail.setSizeID(c.getSizeID());
                orderDetail.setQuantity(c.getStock());

                Product_Attribute_Stock stockInfo = attributeDAO.getProduct_Attribute_Stock(c.getProductID(), c.getSizeID());

                if (orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()) != 0) {
                    orderDetail.setPrice(orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()));
                } else {
                    orderDetail.setPrice(stockInfo.getPrice());
                }
                orderDetailDao.insertOrderDetail(orderDetail);

            });

            response.sendRedirect("payment?orderID=" + order.getOrderID());

        }
    }
}
