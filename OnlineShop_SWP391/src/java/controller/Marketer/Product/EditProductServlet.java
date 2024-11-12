/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Marketer.Product;

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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
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
@MultipartConfig
public class EditProductServlet extends HttpServlet {

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
            out.println("<title>Servlet EditProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProductServlet at " + request.getContextPath() + "</h1>");
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

        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Promotion> listPromotion = prd.getAllPromotions();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<SubImage> listSubImg = sid.getSubImageURLByProductImgId();

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Kiểm tra xem productID có tồn tại và không null
            String productIDParam = request.getParameter("productID");
            int productID = Integer.parseInt(productIDParam);

            // Lấy thông tin sản phẩm
            Products product = pd.getProductById(productID);
            List<Product_Attribute_Stock> productAttributes = attributeDAO.getProductAttributesByProductID(productID);
            int catID = product.getCatID(); // Assuming `getCatID` is a method in your `Products` class

            List<Size> sizes = sd.getAllSizesByCatID(catID); // Fetch sizes based on category ID
            // Lấy thông tin khuyến mãi liên quan đến sản phẩm
            Promotion promotion = prd.getPromotionByProductId(productID);

            // Lấy thông báo từ session (nếu có)
            String successMessage = (String) session.getAttribute("successMessage");

            // Xóa thông báo khỏi session để không hiển thị lại
            session.removeAttribute("successMessage");

            // Đặt thông báo trong request để hiển thị trên trang JSP
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
            }

            // Thiết lập thông tin vào session
            session.setAttribute("product", product);
            session.setAttribute("promotion", promotion);
            session.setAttribute("categories", listCat);
            session.setAttribute("images", listImage);
            session.setAttribute("subImages", listSubImg);
            session.setAttribute("brands", listBrands);
            session.setAttribute("promotions", listPromotion);
            session.setAttribute("productAttributes", productAttributes);
            session.setAttribute("sizes", sizes); // Store sizes for JSP access

            // Chuyển hướng đến trang editProduct.jsp
            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Xử lý lỗi khi không thể chuyển đổi kiểu số
            out.println("<html><body>");
            out.println("<h3>Error: Invalid product ID format. Please enter a valid number.</h3>");
            out.println("<a href='your_previous_page.jsp'>Go back</a>");
            out.println("</body></html>");
        } catch (Exception e) {
            // Xử lý các lỗi khác
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

        PrintWriter out = response.getWriter();
        String UPLOAD_DIRECTORY = "uploads/";
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        System.out.println("Upload Path: " + uploadPath); // For debugging

        File uploadDir = new File(uploadPath);

        // Ensure the upload directory exists or attempt to create it
        if (!uploadDir.exists()) {
            if (uploadDir.mkdirs()) {
                System.out.println("Upload directory created successfully at " + uploadPath);
            } else {
                System.out.println("Failed to create upload directory at " + uploadPath);
                request.setAttribute("error", "Unable to create directory for uploads.");
                request.getRequestDispatcher("editProduct.jsp").forward(request, response);
                return;  // Exit to prevent further execution if directory creation fails
            }
        }

        // Continue with the rest of your code
        Products product = getProductFromRequest(request);

        try {
            String action = request.getParameter("action");
            ProductDAO productDAO = new ProductDAO(); // Moved outside of the if block

            if ("update".equals(action)) {
                String newImagePath = handlePrimaryProductImage(request, uploadPath, product.getProductID());

                // Ensure that required parameters are present
                String productIDParam = request.getParameter("productID1");
                if (productIDParam != null) {
                    product.setProductID(Integer.parseInt(productIDParam));
                } else {
                    throw new IllegalArgumentException("Product ID is missing.");
                }

                // Set other product attributes safely
                product.setProductName(request.getParameter("productName"));
                product.setCatID(Integer.parseInt(request.getParameter("category")));
                product.setBrandID(Integer.parseInt(request.getParameter("brand")));
                product.setBriefInfo(request.getParameter("productBriefInfo"));
                product.setDescription(request.getParameter("description"));
                product.setStatus(Integer.parseInt(request.getParameter("status")));
                product.setFeatureStatus(Integer.parseInt(request.getParameter("featured")));

                // Lấy giá cho từng kích thước
                Map<Integer, Float> priceMap = new HashMap<>();
                for (String parameter : request.getParameterMap().keySet()) {
                    if (parameter.startsWith("price_")) {
                        int sizeID = Integer.parseInt(parameter.split("_")[1]);
                        String priceValue = request.getParameter(parameter);

                        // Kiểm tra giá trị price không null hoặc trống
                        if (priceValue != null && !priceValue.trim().isEmpty()) {
                            float price = Float.parseFloat(priceValue);
                            priceMap.put(sizeID, price);
                        } else {
                            // Xử lý khi không có giá
                            priceMap.put(sizeID, 0f); // Hoặc tùy thuộc vào logic của bạn
                        }
                    }
                }

                // Cập nhật sản phẩm và giá
                productDAO.updateProduct(product, priceMap);

                if (newImagePath != null) {
                    productDAO.updateProductImage(product.getProductID(), newImagePath);
                }

                handleSubImages(request, uploadPath, product.getProductID());
                handleNewSubImage(request, uploadPath, product.getProductID());

                setSuccessMessage(request.getSession(), "Cập nhật sản phẩm thành công!");
                response.sendRedirect("EditProductServlet?productID=" + product.getProductID());

            } else if ("delete".equals(action)) {
                handleDeleteSubImages(request);
                setSuccessMessage(request.getSession(), "Xóa hình ảnh phụ thành công!");
                response.sendRedirect("EditProductServlet?productID=" + product.getProductID());

            } else if ("add".equals(action)) {
                handleNewSubImage(request, uploadPath, product.getProductID());
                setSuccessMessage(request.getSession(), "Thêm hình ảnh phụ thành công!");
                response.sendRedirect("EditProductServlet?productID=" + product.getProductID());

            } else {
                handleError(out, request, response, "Hành động không hợp lệ.");
            }

        } catch (NumberFormatException e) {
            handleError(out, request, response, "Lỗi khi phân tích tham số: " + e.getMessage());
        } catch (SQLException e) {
            handleError(out, request, response, "Lỗi SQL: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            handleError(out, request, response, "Lỗi hợp lệ: " + e.getMessage());
        } catch (Exception e) {
            handleError(out, request, response, "Lỗi không mong muốn: " + e.getMessage());
        } finally {
            out.close();
        }
    }

    private Products getProductFromRequest(HttpServletRequest request) {
        String productIDStr = request.getParameter("productID1");
        int productID_parse = 0;

        try {
            productID_parse = Integer.parseInt(productIDStr);
        } catch (NumberFormatException e) {
            // Handle exception, có thể log lỗi hoặc ném ngoại lệ
            throw new IllegalArgumentException("Invalid product ID.");
        }

        // Get other product parameters
        String productName = request.getParameter("productName");
        String briefInfo = request.getParameter("productBriefInfo");
        String description = request.getParameter("description");
        String catIDStr = request.getParameter("category");
        String brandIDStr = request.getParameter("brand");
        String statusStr = request.getParameter("status");
        String featuredStr = request.getParameter("featured");

        // Kiểm tra giá cho từng kích thước
        String priceStr = request.getParameter("price"); // Nếu bạn muốn kiểm tra riêng

        // Tạo đối tượng sản phẩm
        ProductDAO pd = new ProductDAO();
        Products product = pd.getProductByID(productID_parse);

        // Set product properties
        product.setProductName(productName);
        product.setBriefInfo(briefInfo);
        product.setDescription(description);
        product.setCatID(Integer.parseInt(catIDStr));
        product.setBrandID(Integer.parseInt(brandIDStr));
        product.setStatus(Integer.parseInt(statusStr));
        product.setFeatureStatus(Integer.parseInt(featuredStr));

        // Lấy giá từ các trường giá tương ứng
        Map<Integer, Float> priceMap = new HashMap<>();
        for (String parameter : request.getParameterMap().keySet()) {
            if (parameter.startsWith("price_")) {
                int sizeID = Integer.parseInt(parameter.split("_")[1]);
                String priceValue = request.getParameter(parameter);

                // Kiểm tra giá trị không null hoặc trống
                if (priceValue != null && !priceValue.trim().isEmpty()) {
                    try {
                        float price = Float.parseFloat(priceValue);
                        priceMap.put(sizeID, price);
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Price for size ID " + sizeID + " is invalid.");
                    }
                } else {
                    throw new IllegalArgumentException("Price for size ID " + sizeID + " is missing.");
                }
            }
        }

        // Cập nhật giá trị giá cho sản phẩm từ priceMap nếu cần
        // product.setPrice(priceMap.get(someSizeID)); // Thiết lập giá cho sản phẩm nếu cần
        return product;
    }

    private String handlePrimaryProductImage(HttpServletRequest request, String uploadPath, int productID) throws IOException, ServletException {
        Part filePart = request.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Get the file name
            String filePath = uploadPath + File.separator + fileName;

            // Save the uploaded image
            saveFile(filePart.getInputStream(), filePath);
            return "uploads/" + fileName; // Adjust as needed for the database path
        }
        return null;
    }

//    private void handlePriceUpdate(HttpServletRequest request, ProductDAO productDAO, int productID) throws IOException {
//        // Retrieve product attributes for the productID
//        AttributeDAO ad = new AttributeDAO();
//        List<Product_Attribute_Stock> productAttributes =ad.getProductAttributesByProductID(productID);
//
//        for (Product_Attribute_Stock attribute : productAttributes) {
//            String priceParam = request.getParameter("price_" + attribute.getSizeID());
//
//            if (priceParam != null && !priceParam.isEmpty()) {
//                try {
//                    float price = Float.parseFloat(priceParam);
//
//                    if (price < 0) {
//                        throw new NumberFormatException("Price cannot be negative.");
//                    }
//
//                    // Set price and update attribute in the database
//                    attribute.setPrice(price);
//                    productDAO.updateProductAttribute(attribute);
//
//                } catch (NumberFormatException e) {
//                    throw new IOException("Invalid price format for size " + attribute.getSizeID() + ". Please enter a valid price.");
//                }
//            }
//        }
//    }
    private void handleSubImages(HttpServletRequest request, String uploadPath, int productID) throws IOException, SQLException, ServletException {
        List<Part> subImageParts = request.getParts().stream()
                .filter(part -> part.getName().startsWith("subProductImage"))
                .collect(Collectors.toList());

        String[] subImageIDs = request.getParameterValues("subImageID");

        for (int i = 0; i < subImageParts.size(); i++) {
            Part subImagePart = subImageParts.get(i);
            if (subImagePart.getSize() > 0) {
                String fileName = Paths.get(subImagePart.getSubmittedFileName()).getFileName().toString();
                String filePath = uploadPath + File.separator + fileName;

                // Save sub-image
                saveFile(subImagePart.getInputStream(), filePath);
                String subImageUrl = "uploads/" + fileName;

                // Update sub-image in database
                if (subImageIDs != null && i < subImageIDs.length) {
                    int subImgID = Integer.parseInt(subImageIDs[i]);
                    ProductDAO productDAO = new ProductDAO();
                    productDAO.updateSubImage(subImgID, subImageUrl);
                }
            }
        }
    }

    private void handleNewSubImage(HttpServletRequest request, String uploadPath, int productID) throws IOException, SQLException, ServletException {
        Part newSubImagePart = request.getPart("newSubImage");
        if (newSubImagePart != null && newSubImagePart.getSize() > 0) {
            String newFileName = Paths.get(newSubImagePart.getSubmittedFileName()).getFileName().toString();
            String newFilePath = uploadPath + File.separator + newFileName;

            // Save new sub-image
            saveFile(newSubImagePart.getInputStream(), newFilePath);
            String newSubImageUrl = "uploads/" + newFileName;

            // Add new sub-image to database
            ProductDAO productDAO = new ProductDAO();
            productDAO.addSubImage(newSubImageUrl, productID);
        }
    }

    private void handleDeleteSubImages(HttpServletRequest request) throws SQLException {
        String[] subImageIDsToDelete = request.getParameterValues("deleteSubImageIDs");
        if (subImageIDsToDelete != null) {
            ProductDAO productDAO = new ProductDAO();
            for (String subImageID : subImageIDsToDelete) {
                int subImgID = Integer.parseInt(subImageID);
                boolean isDeleted = productDAO.deleteSubImage(subImgID);

                if (isDeleted) {
                    System.out.println("Sub-image ID " + subImgID + " deleted successfully.");
                } else {
                    System.out.println("Failed to delete sub-image ID " + subImgID + ".");
                }
            }
        }
    }

    private void setSuccessMessage(HttpSession session, String message) {
        session.setAttribute("successMessage", message);
    }

    private void handleError(PrintWriter out, HttpServletRequest request, HttpServletResponse response, String errorMessage) throws ServletException, IOException {
        out.println(errorMessage);
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("editProduct.jsp").forward(request, response);
    }

// Utility method to save a file from InputStream to specified path
    private void saveFile(InputStream fileContent, String filePath) throws IOException {
        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
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
