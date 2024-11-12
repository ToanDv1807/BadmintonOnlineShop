package controller.customer.cart;

import dal.marketer.AttributeDAO;
import dal.customer.CartDAO;
import dal.customer.CartItemDAO;
import dal.common.ChangeDAO;
import dal.common.OrderDAO;
import dal.marketer.ProductDAO; // Import ProductDAO to check product availability
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import model.Account;
import model.Cart;
import model.CartItem;
import model.Customers;
import model.Product_Attribute_Stock;
import model.Products;

public class AddProductToCartServlet extends HttpServlet {

    CartDAO cartDao = new CartDAO();
    CartItemDAO cartItemDao = new CartItemDAO();
    ChangeDAO cd = new ChangeDAO();
    ProductDAO productDao = new ProductDAO(); // DAO to access product details
    AttributeDAO attributeDao = new AttributeDAO();
    OrderDAO orderDao = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("account");
        Customers customers = cd.getCustomersByEmail(a.getEmail());

        int customerID;
        if (customers == null) {
            response.sendRedirect("login.jsp");
            return;
        } else {
            customerID = customers.getCustomerID();
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int requestedQuantity = Integer.parseInt(request.getParameter("stock"));

        String size = request.getParameter("size");
        String errorMessageSize = "Bạn chưa chọn size cho sản phẩm, vui lòng thử lại !";
        if (size == null) {
            request.setAttribute("errorMessageSize", errorMessageSize);
            request.getRequestDispatcher("product-detail.jsp?productID=" + id).forward(request, response);
        } else {
            int sizeID = Integer.parseInt(size);
            // Get the stock information
            Product_Attribute_Stock stockInfo = attributeDao.getProduct_Attribute_Stock(id, sizeID);

            // Retrieve stock and hold values from the stockInfo object
            int stock = (stockInfo != null) ? stockInfo.getStock() : 0; // Total stock from the database
            int hold = (stockInfo != null) ? stockInfo.getHold() : 0; // Current hold from the database
            int availableStock = stock - hold; // Calculate available stock

            Timestamp orderDateTimestamp = new Timestamp(new Date().getTime());

            Cart cart = cartDao.getCartIdByUserId(customerID);
            if (cart == null) {
                cart = new Cart();
                cart.setCustomerID(customerID);
                cartDao.insertCart(cart);
                cart = cartDao.getCartIdByUserId(customerID);
            }

            int cartItemId = cartItemDao.getCartItemID(cart.getCartID(), id, sizeID);
            CartItem cartItem = new CartItem(cartItemId, cart.getCartID(), id, sizeID, requestedQuantity);
            if ( orderDao.getPriceAfterDiscount(id, sizeID) != 0) {
                cartItem.setPrice(orderDao.getPriceAfterDiscount(id, sizeID));
            } else {
                cartItem.setPrice(stockInfo.getPrice());
            }

            if (cartItemDao.checkExistingProductInCart(cartItem) == 0) {
                // Check if requested quantity exceeds available stock before inserting
                if (requestedQuantity > availableStock) {
                    session.setAttribute("errorMessage", "Requested quantity exceeds available stock: " + availableStock);
                    response.sendRedirect("product-detail.jsp?productID=" + id);
                    return;
                }
                cartItemDao.insertCartItem(cartItem);
            } else if (cartItemDao.checkExistingProductInCart(cartItem) == 1) {
                // Check if total quantity in cart exceeds available stock before updating
                int currentCartItemStock = cartItemDao.getCartItem(cartItem).getStock();
                int newTotalStock = currentCartItemStock + requestedQuantity; // Total stock after adding

                if (newTotalStock > availableStock) {
                    session.setAttribute("errorMessage", "Total quantity in cart exceeds available stock: " + availableStock);
                    response.sendRedirect("product-detail.jsp?productID=" + id);
                    return;
                }

                // Update the cart item with the new quantity
                cartItem.setStock(newTotalStock);
                cartItemDao.updateCartItem(cartItem);
            }

            response.sendRedirect("cart?cartID=" + cart.getCartID() + "&customerID=" + customerID);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
