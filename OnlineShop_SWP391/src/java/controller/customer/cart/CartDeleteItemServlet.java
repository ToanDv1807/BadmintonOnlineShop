/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.cart;

import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.marketer.CategoryDAO;
import dal.common.ChangeDAO;
import dal.customer.ProductCartDAO;
import dal.marketer.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Products;

/**
 *
 * @author MSI1
 */
@WebServlet(name = "CartDeleteItemServlet", urlPatterns = {"/cartDelete"})
public class CartDeleteItemServlet extends HttpServlet {

    CartDAO cd = new CartDAO();
    ChangeDAO changeDao = new ChangeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadAndDisplayCart(request, response);
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
        delete(request, response);
        loadAndDisplayCart(request, response);

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
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //get session
        HttpSession session = request.getSession();
        //get request
        int id = Integer.parseInt(request.getParameter("id"));
        CartItemDAO cartItemDAO = new CartItemDAO();
        List<CartItem> listCartItem = (List<CartItem>) session.getAttribute("listCartItem");
        Iterator<CartItem> iterator = listCartItem.iterator();
        while (iterator.hasNext()) {
            CartItem cartItem = iterator.next();
            if (cartItem.getCartItemID() == id) {
                iterator.remove();
                cartItemDAO.deleteCartItemFromDB(cartItem.getCartItemID());
            }

        }
    }

}



