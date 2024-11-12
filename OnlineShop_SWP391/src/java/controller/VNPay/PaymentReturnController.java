package controller.VNPay;

import dal.common.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class PaymentReturnController extends HttpServlet {

    OrderDAO orderDao = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tất cả các tham số từ URL trả về từ VNPAY
        Map<String, String> vnp_Params = new HashMap<>();
        Map<String, String[]> paramMap = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : paramMap.entrySet()) {
            vnp_Params.put(entry.getKey(), entry.getValue()[0]);
        }

        // Tách chữ ký bảo mật để kiểm tra
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHash");

        // Tạo chuỗi dữ liệu cần kiểm tra
        String signValue = Config.hashAllFields(vnp_Params);

        // Kiểm tra tính toàn vẹn của dữ liệu
        if (vnp_SecureHash.equals(Config.hmacSHA512(Config.secretKey, signValue))) {
            String responseCode = vnp_Params.get("vnp_ResponseCode");

            if ("00".equals(responseCode)) {
                // Thanh toán thành công
                request.setAttribute("message", "Giao dịch thành công!");
                int orderId = Integer.parseInt(vnp_Params.get("vnp_TxnRef"));
                orderDao.updateOrderStatus(orderId, "PAID");
            } else {
                // Giao dịch thất bại
                request.setAttribute("message", "Giao dịch thất bại! Mã lỗi: " + responseCode);
            }
        } else {
            // Dữ liệu không hợp lệ
            request.setAttribute("message", "Giao dịch không hợp lệ!");
        }

        // Chuyển hướng đến trang JSP để hiển thị thông báo
        RequestDispatcher dispatcher = request.getRequestDispatcher("vnpay_report.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet handles return URL from VNPAY payment gateway.";
    }
}
