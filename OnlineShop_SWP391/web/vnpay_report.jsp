<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="controller.VNPay.Config"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="dal.common.OrderDAO"%>
<%@page import="dal.common.OrderDetailDAO"%>
<%@page import="dal.common.ChangeDAO"%>
<%@page import="model.Order"%>
<%@page import="model.Invoice"%>
<%@page import="model.Account"%>
<%@page import="model.Customers"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Kết Quả Thanh Toán</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #e9ecef;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #ffffff;
            padding: 80px; /* Increased padding for larger block */
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 600px; /* Increased width for better balance */
            width: 90%; /* Responsive width */
            transition: transform 0.3s;
        }
        .container:hover {
            transform: translateY(-5px); /* Hover effect */
        }
        .container .icon {
            font-size: 100px; /* Increased icon size */
            color: #28a745; /* Green color for success */
            transition: color 0.3s;
        }
        .container .icon.fail {
            color: #dc3545; /* Red color for failure */
        }
        .container h1 {
            color: #343a40; /* Title color */
            font-size: 40px; /* Increased title size */
            margin: 30px 0; /* Increased margin */
        }
        .container h1.fail {
            color: #dc3545;
        }
        .container p {
            font-size: 22px; /* Increased font size for paragraphs */
            color: #495057; /* Content color */
            margin: 15px 0; /* Increased margin */
        }
        .container p span {
            font-weight: bold;
            color: #007bff; /* Highlight color */
        }
        .container .button {
            background-color: #007bff;
            color: #ffffff;
            padding: 15px 30px; /* Increased button padding */
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 30px; /* Increased margin */
            transition: background-color 0.3s;
            font-size: 18px; /* Increased button font size */
        }
        .container .button:hover {
            background-color: #0056b3;
        }
        .countdown {
            font-size: 24px; /* Increased countdown font size */
            color: #6c757d; /* Countdown color */
        }
    </style>
</head>
<body>
    <%
        ChangeDAO cd = new ChangeDAO();
        OrderDAO orderDao = new OrderDAO();
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();
        
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
        Account a = (Account) session.getAttribute("account");
        Customers cus = cd.getCustomersByEmail(a.getEmail());
        int orderID = orderDao.getOrderIdByCustomerID(cus.getCustomerID());

        long amount = (long) orderDao.getTotalAmountOfOrderByOrderID(orderID);
        String responseCode = request.getParameter("vnp_ResponseCode");

        // Định dạng số tiền
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedAmount = formatter.format(amount);
    %>
    <div class="container">
        <% if ("00".equals(responseCode)) { %>
        <div class="icon">&#10004;</div>
        <h1>THANH TOÁN THÀNH CÔNG</h1>
        <p>Mã đơn: <span><%= orderID %></span> - Tổng tiền: <span><%= formattedAmount %> đồng</span></p>
        <p>Kiểu thanh toán: Online</p>
        <p class="countdown">Đang chuyển hướng trong <span id="countdown">3</span> giây...</p>

        <script>
            // Đếm ngược thời gian chuyển hướng
            var countdown = 3;
            var countdownElement = document.getElementById('countdown');

            var timer = setInterval(function () {
                countdown--;
                countdownElement.textContent = countdown;
                if (countdown <= 0) {
                    clearInterval(timer);
                    window.location.href = "paymentResult?orderID=" + <%= orderID %> + "&responseCode=" + "<%= responseCode %>";
                }
            }, 1000);
        </script>

        <% } else { %>
        <div class="icon fail">&#10008;</div>
        <h1 class="fail">THANH TOÁN THẤT BẠI</h1>
        <p>Mã đơn: <span><%= orderID %></span></p>
        <p>Mã lỗi: <span><%= responseCode %></span></p>
        <p><a class="button" href="home">Quay lại trang chính</a></p>
        <% 
            orderDao.deleteOrderAssignmentByOrderID(orderID);
            orderDao.deleteOrderByOrderID(orderID);
            orderDetailDao.deleteListOrderDetailByOrderID(orderID);
        %>
        <% } %>
    </div>

    <script>
        // Chuyển giá trị cho JavaScript
        var orderID = <%= orderID %>;
        var responseCode = "<%= responseCode %>";
    </script>

</body>
</html>
