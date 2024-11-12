<%@page import="VNPay.Config"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>KẾT QUẢ THANH TOÁN</title>
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <%
            // Lấy các tham số từ VNPAY
            Map<String, String> fields = new HashMap<>();
            Map<String, String[]> paramMap = request.getParameterMap();
            for (Map.Entry<String, String[]> entry : paramMap.entrySet()) {
                fields.put(entry.getKey(), entry.getValue()[0]);
            }

            // Lấy giá trị vnp_SecureHash từ URL
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");

            // Loại bỏ các tham số không cần kiểm tra
            fields.remove("vnp_SecureHash");
            fields.remove("vnp_SecureHashType");

            // Tạo chuỗi để kiểm tra chữ ký
            String signValue = Config.hashAllFields(fields);
        %>
        <!--Begin display -->
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label>Mã giao dịch thanh toán:</label>
                    <label><%= request.getParameter("vnp_TxnRef") %></label>
                </div>    
                <div class="form-group">
                    <label>Số tiền:</label>
                    <label><%= request.getParameter("vnp_Amount") %></label>
                </div>  
                <div class="form-group">
                    <label>Mô tả giao dịch:</label>
                    <label><%= request.getParameter("vnp_OrderInfo") %></label>
                </div> 
                <div class="form-group">
                    <label>Mã lỗi thanh toán:</label>
                    <label><%= request.getParameter("vnp_ResponseCode") %></label>
                </div> 
                <div class="form-group">
                    <label>Mã giao dịch tại VNPAY:</label>
                    <label><%= request.getParameter("vnp_TransactionNo") %></label>
                </div> 
                <div class="form-group">
                    <label>Mã ngân hàng thanh toán:</label>
                    <label><%= request.getParameter("vnp_BankCode") %></label>
                </div> 
                <div class="form-group">
                    <label>Thời gian thanh toán:</label>
                    <label><%= request.getParameter("vnp_PayDate") %></label>
                </div> 
                <div class="form-group">
                    <label>Tình trạng giao dịch:</label>
                    <label>
                        <%
                            // Kiểm tra chữ ký và tình trạng giao dịch
                            if (signValue.equals(vnp_SecureHash)) {
                                // Kiểm tra mã phản hồi từ VNPAY
                                if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
                                    out.print("Giao dịch thành công!");
                                } else {
                                    out.print("Giao dịch không thành công! Mã lỗi: " + request.getParameter("vnp_ResponseCode"));
                                }
                            } else {
                                out.print("Chữ ký không hợp lệ!");
                            }
                        %>
                    </label>
                </div> 
            </div>
            <p>&nbsp;</p>
            <footer class="footer">
                <p>&copy; VNPAY 2024</p>
            </footer>
        </div>  
    </body>
</html>
