/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.cart;

import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.common.ChangeDAO;
import dal.common.OrderDAO;
import dal.customer.CheckoutDAO;
import dal.marketer.MarketerDAO;
import dal.customer.ProductCartDAO;
import dal.marketer.AttributeDAO;
import dal.marketer.ProductDAO;
import dal.marketer.SizeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Employees;
import model.Products;
import model.Account;
import model.Address;
import model.Product_Attribute_Stock;
import model.Size;

/**
 *
 * @author MSI1
 */
public class CheckOutController extends HttpServlet {

    CheckoutDAO checkoutDao = new CheckoutDAO();
    CartDAO cartDao = new CartDAO();
    CartItemDAO cartItemDao = new CartItemDAO();
    ProductCartDAO productCartDao = new ProductCartDAO();
    MarketerDAO md = new MarketerDAO();
    ChangeDAO cd = new ChangeDAO();
    SizeDAO sizeDao = new SizeDAO();
    ProductDAO productDao = new ProductDAO();
    AttributeDAO attributeDao = new AttributeDAO();
    OrderDAO orderDao = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        Customers customers = cd.getCustomersByEmail(a.getEmail());
        Cart cart = cartDao.getCartIdByUserId(customers.getCustomerID());
        int cartID = cart.getCartID();
        int customerID = customers.getCustomerID();
        List<CartItem> listCartItem = cartItemDao.getCartItemsByCartId(cart.getCartID());
        
        listCartItem.forEach(c -> {

            Product_Attribute_Stock stockInfo = attributeDao.getProduct_Attribute_Stock(c.getProductID(), c.getSizeID());

            if ( orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()) != 0) {
                c.setPrice(orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()));
            } else {
                c.setPrice(stockInfo.getPrice());
            }

        });

        if (listCartItem == null || listCartItem.isEmpty()) {
            // Nếu giỏ hàng trống, chuyển hướng về trang giỏ hàng và hiển thị thông báo
            request.setAttribute("cartEmptyMessage", "Your cart is empty. Please add items before proceeding.");
            response.sendRedirect("cart"); // Hoặc bạn có thể forward đến trang giỏ hàng với thông báo
        } else {
            List<Products> listProduct = productCartDao.getAllProduct();
        List<Address> addresses = md.getAllAddressByCid(customers.getCustomerID());
        List<Size> listSizeAll = sizeDao.getAllSize();
        List<Product_Attribute_Stock> listProductAttribute = productDao.getListProductAttribute();

        session.setAttribute("customerCheckOut", customers);
        request.setAttribute("cart", cart);
        request.setAttribute("listCartItem", listCartItem);
        session.setAttribute("listProductAttribute", listProductAttribute);
        request.setAttribute("listSizeAll", listSizeAll);
        request.setAttribute("listProduct", listProduct);
        session.setAttribute("addresses", addresses);
        request.setAttribute("cartID", cartID);
        request.setAttribute("customerID", customerID);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
        

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
