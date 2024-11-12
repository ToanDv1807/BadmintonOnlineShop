package controller.common.product;

import dal.marketer.BrandDAO;
import dal.marketer.CategoryDAO;
import dal.marketer.ProductDAO;
import dal.marketer.PromotionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Brand;
import model.Category;
import model.ProductImage;
import model.Products;
import model.Promotion;

public class CheckBoxServlet extends HttpServlet {

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
        processRequest(request, response);
    }

    // Phương thức trợ giúp để kiểm tra xem một giá trị có tồn tại trong mảng hay không
    private boolean ischeck(int id, int[] ids) {
        for (int i : ids) {
            if (i == id) {
                return true; // Nếu tìm thấy ID, trả về true
            }
        }
        return false; // Nếu không tìm thấy, trả về false
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy đối tượng session từ yêu cầu hiện tại
        HttpSession session = request.getSession();

        // Tạo DAO để truy cập cơ sở dữ liệu
        CategoryDAO cd = new CategoryDAO();
        BrandDAO bd = new BrandDAO();
        ProductDAO pd = new ProductDAO();
        PromotionDAO prd = new PromotionDAO();

        // Lấy dữ liệu từ cơ sở dữ liệu
        List<Category> listCat = cd.getAllCategories();
        List<Brand> listBrands = bd.getAllBrands();
        List<Products> listLatestPro = pd.getLatestProducts();
        List<ProductImage> listImage = pd.getAllProductImage();
        List<Promotion> listPromotion = prd.getAllPromotions();

        // Lấy các tham số lọc: catID, brandID, priceRanges
        String[] catID_raw = request.getParameterValues("catID");
        String[] brandID_raw = request.getParameterValues("brandID");
        String[] priceRangeRaw = request.getParameterValues("priceRange");

        // Xử lý các tham số khoảng giá
        Set<String> selectedPriceRanges = new HashSet<>();
        List<int[]> priceRanges = new ArrayList<>();

        if (priceRangeRaw != null) {
            for (String range : priceRangeRaw) {
                range = range.trim();
                String[] bounds = range.split("-");
                if (bounds.length == 2) {
                    try {
                        int minPrice = Integer.parseInt(bounds[0].trim());
                        int maxPrice = Integer.parseInt(bounds[1].trim());
                        priceRanges.add(new int[]{minPrice, maxPrice});
                        selectedPriceRanges.add(range);
                    } catch (NumberFormatException e) {
                        e.printStackTrace(); // Có thể thay bằng log lỗi
                    }
                }
            }
        }

        // Xử lý chỉ số trang cho phân trang
        String index_raw = request.getParameter("index");
        if (index_raw == null) {
            index_raw = "1";
        }
        int index = Integer.parseInt(index_raw.trim());

        // Lọc sản phẩm dựa trên catID, brandID và khoảng giá
        int[] catID = null;
        int[] brandID = null;

        if (catID_raw != null) {
            catID = new int[catID_raw.length];
            for (int i = 0; i < catID_raw.length; i++) {
                catID[i] = Integer.parseInt(catID_raw[i].trim());
            }
        }

        if (brandID_raw != null) {
            brandID = new int[brandID_raw.length];
            for (int i = 0; i < brandID_raw.length; i++) {
                brandID[i] = Integer.parseInt(brandID_raw[i].trim());
            }
        }

        List<Products> listPro = pd.getProductsByFilterByPaging(catID, brandID, priceRanges, index);

        // Tính tổng số sản phẩm cho phân trang
        int totalProducts = pd.getTotalProductsByFilter(catID, brandID, priceRanges);
        int endPage = (totalProducts + 9) / 10; // Tính toán endPage

        // Lưu trữ các thuộc tính trong session
        session.setAttribute("endPage", endPage);
        session.setAttribute("tag", index);

        // Tạo mảng boolean cho các danh mục và thương hiệu đã chọn
        boolean[] cID = new boolean[listCat.size()];
        boolean[] bID = new boolean[listBrands.size()];

        for (int i = 0; i < listCat.size(); i++) {
            cID[i] = catID != null && ischeck(listCat.get(i).getCatID(), catID);
        }

        for (int i = 0; i < listBrands.size(); i++) {
            bID[i] = brandID != null && ischeck(listBrands.get(i).getBrandID(), brandID);
        }

        // Lưu trữ dữ liệu liên quan đến bộ lọc trong session
        session.setAttribute("bID", bID);
        session.setAttribute("cID", cID);
        session.setAttribute("selectedCatID", catID);
        session.setAttribute("selectedBrandID", brandID);
        session.setAttribute("selectedPriceRanges", selectedPriceRanges);
        session.setAttribute("option", 2);  // Tùy chọn cho sản phẩm đã lọc
        session.setAttribute("products", listPro);
        session.setAttribute("categories", listCat);
        session.setAttribute("brands", listBrands);
        session.setAttribute("images", listImage);
        session.setAttribute("promotions", listPromotion);
        session.setAttribute("latestProducts", listLatestPro);

        // Chuyển tiếp tới trang JSP để hiển thị danh sách sản phẩm
        request.getRequestDispatcher("product-list.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
