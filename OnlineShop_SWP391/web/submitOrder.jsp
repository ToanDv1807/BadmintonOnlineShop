<%-- 
    Document   : submitOrder
    Created on : Oct 8, 2024, 10:04:18 PM
    Author     : MSI1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thông báo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }
        .container h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .container p {
            font-size: 16px;
            margin-bottom: 20px;
        }
        .container p strong {
            font-weight: bold;
        }
        .container .buttons {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .container .buttons a {
            text-decoration: none;
            color: #fff;
            background-color: #333;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Thông báo</h1>
        <p>Đơn hàng của quý khách đã được đặt thành công. Mã đơn hàng của quý khách là <strong>[2024093064114_200907]</strong>.</p>
        <p>- Thời gian xử lý đơn hàng: Từ 8h30- 17h30 Thứ 2 đến thứ 6 và 8h30-12h30 Thứ 7 hàng tuần. Các đơn hàng sau thời gian này sẽ được xử lý vào ngày làm việc tiếp theo.</p>
        <div class="buttons">
            <a href="#">TRANG CHỦ</a>
            <a href="#">XEM ĐƠN HÀNG</a>
        </div>
    </div>
</body>
</html>