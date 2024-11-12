/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.cart;

import dal.marketer.AttributeDAO;
import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.marketer.CategoryDAO;
import dal.common.ChangeDAO;
import dal.common.OrderDAO;
import dal.customer.ProductCartDAO;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
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
import model.Category;
import model.Customers;
import model.Order;
import model.Product_Attribute_Stock;
import model.Products;
import model.Promotion;
import model.Size;

/**
 *
 * @author MSI1
 */
public class CartServlet extends HttpServlet {

    CartDAO cd = new CartDAO();
    CategoryDAO ctd = new CategoryDAO();
    ProductDAO pd = new ProductDAO();
    PromotionDAO prd = new PromotionDAO();
    ChangeDAO changeDao = new ChangeDAO();
    AttributeDAO attributeDao = new AttributeDAO();
    CartItemDAO cartItemDao = new CartItemDAO();
    SizeDAO sizeDao = new SizeDAO();
    OrderDAO orderDao = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account a = (Account) session.getAttribute("account");
        Customers customers = changeDao.getCustomersByEmail(a.getEmail());
        int customerID = customers.getCustomerID();
        Cart cart = cd.getCartIdByUserId(customerID);
        int cartID = cart.getCartID();
        List<CartItem> listCartItem = cartItemDao.getCartItemsByCartId(cart.getCartID());
        listCartItem.forEach(c -> {

            Product_Attribute_Stock stockInfo = attributeDao.getProduct_Attribute_Stock(c.getProductID(), c.getSizeID());

            if (orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()) != 0) {
                c.setPrice(orderDao.getPriceAfterDiscount(c.getProductID(), c.getSizeID()));
            } else {
                c.setPrice(stockInfo.getPrice());
            }

        });

        List<Products> listProduct = new ProductCartDAO().getAllProduct();
        List<Category> listCat = ctd.getAllCategories();
        List<Products> listPro = pd.getAllProducts();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<Size> listSizeAll = sizeDao.getAllSize();

        session.setAttribute("promotions", listPromotion);
        session.setAttribute("categories", listCat);
        session.setAttribute("products", listPro);
        session.setAttribute("cart", cart);
        session.setAttribute("listCartItem", listCartItem);
        session.setAttribute("listProduct", listProduct);
        session.setAttribute("listSizeAll", listSizeAll);
        request.setAttribute("customerID", customerID);
        request.setAttribute("cartID", cartID);
        request.getRequestDispatcher("cart.jsp?cartID=" + cartID + "&customerID=" + customerID).forward(request, response);

    }

}
