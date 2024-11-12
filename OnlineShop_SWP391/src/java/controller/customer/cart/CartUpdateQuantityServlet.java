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
import dal.customer.ProductCartDAO;
import dal.marketer.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.KeyPair;
import java.util.AbstractMap;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Category;
import model.Customers;
import model.Product_Attribute_Stock;
import model.Products;

/**
 *
 * @author MSI1
 */
public class CartUpdateQuantityServlet extends HttpServlet {

    CartDAO cd = new CartDAO();
    ChangeDAO changeDao = new ChangeDAO();
    AttributeDAO attributeDao = new AttributeDAO();
    CartItemDAO cartItemDAO = new CartItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadAndDisplayCart(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        changeQuantity(request);
        loadAndDisplayCart(request, response);
    }

    private void changeQuantity(HttpServletRequest request) {
        //create map to save error

        Map<Integer, Integer> isError = new HashMap<>();
        String error = "Not enough stock available!";
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int sizeID = Integer.parseInt(request.getParameter("size"));
            int num = Integer.parseInt(request.getParameter("num"));

            CartItem cartItem = cartItemDAO.getCartItemsByCartItemId(id);
            int productId = cartItem.getProductID();

            Product_Attribute_Stock stockInfo = attributeDao.getProduct_Attribute_Stock(productId, sizeID);

            int stock = (stockInfo != null) ? stockInfo.getStock() : 0; // Total stock from the database
            int hold = (stockInfo != null) ? stockInfo.getHold() : 0; // Current hold from the database
            int availableStock = stock - hold; // Calculate available stock

            if (quantity > availableStock && sizeID == stockInfo.getSizeID()) {
                if (num == -1) {
                    cartItem.setStock(quantity);
                    //Update in db
                    cartItemDAO.updateCartItemQuantity(cartItem.getCartItemID(), quantity);
                }else{
                    isError.put(productId, sizeID);
                }
                isError.put(productId, sizeID);

            } else if (quantity == 0) {
                // Remove the item from the cart if quantity is 0 1
                cartItemDAO.deleteCartItemFromDB(cartItem.getCartItemID());
            } else {
                cartItem.setStock(quantity);
                //Update in db
                cartItemDAO.updateCartItemQuantity(cartItem.getCartItemID(), quantity);
            }

            request.setAttribute("isError", isError);
            request.setAttribute("error", error);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void loadAndDisplayCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Account a = (Account) session.getAttribute("account");
        Customers customers = changeDao.getCustomersByEmail(a.getEmail());

        Cart cart = cd.getCartIdByUserId(customers.getCustomerID());

        List<CartItem> listCartItem = new CartItemDAO().getCartItemsByCartId(cart.getCartID());
        List<Products> listProduct = new ProductCartDAO().getAllProduct();
        session.setAttribute("cart", cart);
        request.setAttribute("listCartItem", listCartItem);
        session.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
