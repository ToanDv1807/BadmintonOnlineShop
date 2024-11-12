<!DOCTYPE html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>My Order - Online Badminton Shop</title>

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/favicon.png">

        <!-- Google Fonts -->
        <script>
            WebFontConfig = {
                google: {families: ['Open+Sans:300,400,600,700', 'Poppins:300,400,500,600,700']}
            };
            (function (d) {
                var wf = d.createElement('script'), s = d.scripts[0];
                wf.src = '${pageContext.request.contextPath}/assets/js/webfont.js';
                wf.async = true;
                s.parentNode.insertBefore(wf, s);
            })(document);
        </script>

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">

        <style>
            body {
                background: #f4f4f4; /* Light grey background */
                margin: 0;
                font-family: 'Poppins', sans-serif;
                color: #333;
            }

            .container {
                display: flex;
                flex-wrap: wrap;
                margin-top: 100px;
                margin-bottom: 50px;
                justify-content: center;
            }

            .orders {
                width: 85%;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                margin: 0 auto;
                margin-top: 200px;
                margin-bottom: 50px;
                border: 1px solid #e0e0e0;
            }

            .orders h2 {
                font-size: 26px;
                font-weight: 600;
                color: #333;
                text-align: center;
                margin-bottom: 30px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
            }

            .total-search-container {
                display: flex; /* Use flexbox to align items in a row */
                justify-content: space-between; /* Push items to opposite ends */
                align-items: center; /* Center items vertically */
                margin-bottom: 20px; /* Add some space below the container */
            }

            .total-amount h4 {
                margin: 0; /* Remove margin for cleaner alignment */
                font-size: 18px; /* Adjust font size if needed */
            }

            .product-search {
                display: flex;
                align-items: center;
            }

            .product-search .form-control {
                width: 140px; /* Đặt lại chiều rộng cho thanh tìm kiếm */
                height: 34px; /* Giảm chiều cao của thanh tìm kiếm */
                border-radius: 12px; /* Giảm bo góc */
                padding: 6px 10px; /* Khoảng cách trong */
                border: 1px solid #ddd;
                transition: box-shadow 0.3s ease-in-out;
                margin-right: 20px;
            }

            .product-search .form-control:focus {
                box-shadow: 0 0 5px #aaa; /* Tạo hiệu ứng khi người dùng nhấp vào */
            }
            .product-search .form{
                display: flex;
            }
            .product-search h5{
                margin-bottom: 75px;
                margin-right: 20px
            }
            .product-search button {
                width: 140px; /* Đặt chiều rộng bằng với thanh tìm kiếm */
                height: 34px; /* Giảm chiều cao nút */
                background-color: #333;
                color: #fff;
                border-radius: 12px; /* Góc bo tròn cho đồng nhất */
                padding: 6px 10px;
                font-size: 14px;
                font-weight: 600;
                border: none;
                transition: background-color 0.3s ease-in-out, transform 0.3s;
            }

            .product-search button:hover {
                background-color: #555; /* Màu nút khi hover */
                transform: translateY(-2px);
            }

            /* Order Table Styling */
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 16px;
                border-radius: 10px;
                overflow: hidden;
                border: 1px solid #e0e0e0;
            }

            .order-table th {
                background-color: #333;
                color: #ffffff;
                font-weight: bold;
                padding: 12px;
            }

            .order-table td {
                padding: 12px;
                background-color: #ffffff;
                color: #333;
                border-bottom: 1px solid #e0e0e0;
            }

            .order-table tr:nth-child(even) {
                background-color: #f7f7f7;
            }

            .order-table tr:hover {
                background-color: #f1f1f1; /* Slightly darker background on hover */
            }

            .order-table a {
                color: #007bff;
                text-decoration: none;
            }

            .order-table a:hover {
                text-decoration: underline;
            }

            /* Pagination Styling */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: #333;
                padding: 8px 16px;
                text-decoration: none;
                margin: 0 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
            }

            .pagination a.active {
                background-color: #333;
                color: #ffffff;
                border: 1px solid #333;
            }

            .pagination a:hover {
                background-color: #555;
                color: #ffffff;
                border: 1px solid #555;
            }

            /* Responsive Adjustments */
            @media (max-width: 768px) {
                .orders {
                    width: 95%;
                }

                .product-search {
                    text-align: center;
                    margin-bottom: 10px;
                }

                .product-search .form-control {
                    width: 100%;
                    margin-bottom: 10px;
                }

                .product-search button {
                    width: 100%;
                }

                .search-total {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .total-amount, .product-search {
                    text-align: center;
                    width: 100%;
                    margin-top: 10px;
                }
            }

        </style>


    </head>

    <body>
    <body>
        <jsp:include page="common/header.jsp"></jsp:include>

            <div class="orders">
                <h2>My Orders</h2>

                <div class="total-search-container">
                    <div class="total-amount">
                        <h4>Total Amount of All Success Orders: 
                            <span style="color: #007bff;">
                            <fmt:formatNumber value="${totalAmountSum}" type="number" groupingUsed="true"/> vnd
                        </span>
                    </h4>
                </div>
                <div class="product-search">
                    <h5>Search Products</h5>
                    <form action="myOrder" method="get" class="form">
                        <input type="text" class="form-control mb-3" name="query" placeholder="Search products...">
                        <button type="submit" class="btn btn-dark btn-block">Search</button>
                    </form>
                </div>
            </div>
            <a style="color: red">${messOrder}</a>

            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Ordered Date</th>
                        <th>Product</th>
                        <th>Number Of Other Product</th>
                        <th>Total Cost (vnd)</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="order">
                    <td><a href="orderInformation?orderID=${order.orderID}">${order.orderID}</a></td>
                    <td>${order.orderDate}</td>
                    <td>${order.productName}</td>
                    <td>${order.quantity}</td>
                    <td> <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> </td>
                    <td>
                        ${order.statusName}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${order.statusName == 'Success'}">
                                <a href="viewProductToFeedback?orderID=${order.orderID}">Link Feedback</a>
                            </c:when>
                            <c:when test="${order.statusName == 'Submitted'}">
                                <a href="cancelOrder?orderID=${order.orderID}" onclick="return confirm('Are you sure you want to cancel your order?');">Cancel your order</a>
                            </c:when>
                            <c:otherwise>
                                Contact us for support
                            </c:otherwise>
                        </c:choose>
                    </td>

                    </tbody>

                </c:forEach>

            </table>

            <div class="pagination">
                <c:forEach begin="1" end="${endP}" var="i">
                    <a href="myOrder?page=${i}" class="${i == currentPage ? 'page-link active' : 'page-link'}">${i}</a>
                </c:forEach>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="common/footer.jsp"></jsp:include>

        <!-- Plugins JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>
    <!-- Main JS File -->
    <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
</body>


</body>

</html>