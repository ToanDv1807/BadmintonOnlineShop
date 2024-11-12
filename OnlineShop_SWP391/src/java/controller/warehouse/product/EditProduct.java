/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.warehouse.product;

import dal.marketer.AttributeDAO;
import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import dal.marketer.SizeDAO;
import dal.marketer.SubImageDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Attributes;
import model.Brand;
import model.Category;
import model.ProductImage;
import model.Product_Attribute_Stock;
import model.Products;
import model.Promotion;
import model.Size;
import model.SubImage;

/**
 *
 * @author Acer
 */
public class EditProduct extends HttpServlet {

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
            out.println("<title>Servlet EditProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProduct at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        CategoryDAO cd = new CategoryDAO();
        BrandDAO bd = new BrandDAO();
        ProductDAO pd = new ProductDAO();
        PromotionDAO prd = new PromotionDAO();
        AttributeDAO attributeDAO = new AttributeDAO();
        SubImageDAO sid = new SubImageDAO();
        SizeDAO sd = new SizeDAO();

        List<Size> sizes;
        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<SubImage> listSubImg = sid.getSubImageURLByProductImgId();

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Check if productID is present and valid
            String productIDParam = request.getParameter("productID");
            int productID = Integer.parseInt(productIDParam);

            // Get product information
            Products product = pd.getProductById(productID);

            // Get the category ID of the product
            int catID = product.getCatID(); // Assuming `getCatID` is a method in your `Products` class

            // Retrieve sizes based on the product's catID
            sizes = sd.getAllSizesByCatID(catID); // Fetch sizes based on category ID

            // Get product attributes
            List<Product_Attribute_Stock> productAttributes = attributeDAO.getProductAttributesByProductID(productID);

            // Get promotion related to the product
            Promotion promotion = prd.getPromotionByProductId(productID);

            // Retrieve messages from session (if any)
            String successMessage = (String) session.getAttribute("successMessageWare");
            session.removeAttribute("successMessageWare"); // Clear message

            String error = (String) session.getAttribute("errorMessageWare");
            session.removeAttribute("errorMessageWare"); // Clear message

            // Set messages to request attributes for display
            if (successMessage != null) {
                request.setAttribute("successMessageWare", successMessage);
            }
            if (error != null) {
                request.setAttribute("errorMessageWare", error);
            }

            // Set attributes in session for access in JSP
            session.setAttribute("product", product);
            session.setAttribute("promotion", promotion);
            session.setAttribute("categories", listCat);
            session.setAttribute("images", listImage);
            session.setAttribute("subImages", listSubImg);
            session.setAttribute("brands", listBrands);
            session.setAttribute("promotions", listPromotion);
            session.setAttribute("productAttributes", productAttributes);
            session.setAttribute("sizes", sizes); // Store sizes for JSP access

            // Forward to the edit product page
            request.getRequestDispatcher("editProductWarehouse.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Handle error for invalid number format
            out.println("<html><body>");
            out.println("<h3>Error: Invalid product ID format. Please enter a valid number.</h3>");
            out.println("<a href='your_previous_page.jsp'>Go back</a>");
            out.println("</body></html>");
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            out.println("<html><body>");
            out.println("<h3>Error: An error occurred while retrieving the product.</h3>");
            out.println("<a href='your_previous_page.jsp'>Go back</a>");
            out.println("</body></html>");
        } finally {
            out.close();
        }
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
        SizeDAO sd = new SizeDAO();
        AttributeDAO ad = new AttributeDAO();
        ProductDAO pd = new ProductDAO();

        String action = request.getParameter("action");
        String productIDStr = request.getParameter("productID");
        String[] stockValues = request.getParameterValues("stock");
        String[] importPriceValues = request.getParameterValues("importPrice");
        String[] sizeIDs = request.getParameterValues("sizeID");

        boolean hasError = false;
        int productID = 0;

        // Validate productID
        productID = validateProductID(productIDStr, request);
        if (productID == -1) {
            hasError = true;
        }

        // Get product details
        Products p = pd.getProductByID(productID);

        if ("updateProduct".equals(action) && !hasError) {
            // Lists for new sizes and updated sizes
            List<Integer> sizesToInsert = new ArrayList<>();
            List<Integer> stocksToInsert = new ArrayList<>();
            List<Float> importPricesToInsert = new ArrayList<>();

            List<Integer> sizesToUpdate = new ArrayList<>();
            List<Integer> stocksToUpdate = new ArrayList<>();
            List<Float> importPricesToUpdate = new ArrayList<>();

            if (stockValues != null && importPriceValues != null && sizeIDs != null) {
                for (int i = 0; i < stockValues.length; i++) {
                    if (hasError) {
                        break; // Exit if an error has already occurred
                    }

                    // Validate and collect data
                    int stock = validateInteger(stockValues[i], "Stock", request);
                    if (stock < 0) {
                        hasError = true;
                        continue;
                    }

                    float importPrice = validateFloat(importPriceValues[i], "Import Price", request);
                    if (importPrice < 0) {
                        hasError = true;
                        continue;
                    }

                    // Handle sizeID processing
                    String sizeIDStr = sizeIDs[i];
                    int sizeID = validateSizeID(sizeIDStr, request);
                    if (sizeID == -1) {
                        hasError = true;
                        continue;
                    }

                    // Check if the sizeID exists
                    if (ad.sizeIDExists(sizeID, productID)) {
                        // If exists, add to update lists
                        sizesToUpdate.add(sizeID);
                        stocksToUpdate.add(stock);
                        importPricesToUpdate.add(importPrice);
                    } else {
                        // If sizeID does not exist, add to insert lists
                        sizesToInsert.add(sizeID);
                        stocksToInsert.add(stock);
                        importPricesToInsert.add(importPrice);
                    }
                }

                // Batch update existing sizes
                if (!sizesToUpdate.isEmpty()) {
                    for (int i = 0; i < sizesToUpdate.size(); i++) {
                        int sizeID = sizesToUpdate.get(i);
                        int stock = stocksToUpdate.get(i);
                        float importPrice = importPricesToUpdate.get(i);
                        ad.updateStockAndImportPrice(stock, importPrice, productID, sizeID);
                    }
                }

                // Insert new sizes
                if (!sizesToInsert.isEmpty()) {
                    sd.insertNewSizesAndPrices(productID, sizesToInsert, stocksToInsert, importPricesToInsert);
                }

                if (!hasError) {
                    request.getSession().setAttribute("successMessageWare", "Attributes updated successfully!");
                }
            }
        }

        // Redirect back to EditProduct page
        response.sendRedirect("EditProduct?productID=" + productID);
    }

// Helper methods for validation
    private int validateProductID(String productIDStr, HttpServletRequest request) {
        if (productIDStr == null || productIDStr.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessageWare", "Product ID is required.");
            return -1; // Error indicator
        }
        try {
            return Integer.parseInt(productIDStr);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessageWare", "Invalid product ID.");
            return -1; // Error indicator
        }
    }

    private int validateInteger(String value, String fieldName, HttpServletRequest request) {
        if (value == null || value.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessageWare", fieldName + " is required.");
            return -1; // Error indicator
        }
        try {
            int result = Integer.parseInt(value);
            if (result < 0) {
                request.getSession().setAttribute("errorMessageWare", fieldName + " cannot be negative.");
                return -1; // Error indicator
            }
            return result;
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessageWare", "Invalid " + fieldName + " value.");
            return -1; // Error indicator
        }
    }

    private float validateFloat(String value, String fieldName, HttpServletRequest request) {
        if (value == null || value.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessageWare", fieldName + " is required.");
            return -1; // Error indicator
        }
        try {
            float result = Float.parseFloat(value);
            if (result < 0) {
                request.getSession().setAttribute("errorMessageWare", fieldName + " cannot be negative.");
                return -1; // Error indicator
            }
            return result;
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessageWare", "Invalid " + fieldName + " value.");
            return -1; // Error indicator
        }
    }

    private int validateSizeID(String sizeIDStr, HttpServletRequest request) {
        if (sizeIDStr == null || sizeIDStr.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessageWare", "Size ID is required.");
            return -1; // Error indicator
        }
        try {
            return Integer.parseInt(sizeIDStr);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessageWare", "Invalid size ID.");
            return -1; // Error indicator
        }
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
