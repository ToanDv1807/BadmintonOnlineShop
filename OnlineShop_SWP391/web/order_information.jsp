<%-- 
    Document   : order_information
    Created on : Oct 16, 2024, 2:49:27 PM
    Author     : MSI1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dal.marketer.ProductImageDAO" %>
<%@ page import="model.OrderDetail" %>
<%@ page import="dal.common.OrderDetailDAO" %>
<%@ page import="dal.common.ChangeDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
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
                .title-mini {
                    color: red; /* Màu chữ đỏ */
                    font-family: 'Cursive', sans-serif; /* Kiểu chữ điệu đà */
                    font-size: 24px; /* Kích thước chữ */
                    text-align: center; /* Căn giữa chữ */
                    margin-bottom: 20px; /* Khoảng cách bên dưới */
                    font-weight: bold; /* Đậm chữ */
                }
            }


        </style>


    </head>

    <body>

        <jsp:include page="common/header.jsp"></jsp:include>


            <div class="orders">
                <h2>Order Information</h2>
                <div class="total-search-container">
                    <div class="total-amount">
                        <h4>Total Amount of Order: 
                            <span style="color: #007bff;">
                            <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" />
                        </span>
                    </h4>
                    <c:set var="status" value="${statusName}" /> 
                    <br/>
                    <h4>Status:
                        <span style="color: #007bff;">
                            ${status}
                        </span>
                    </h4>
                </div>


            </div>

            <div class="row">
                <table class="order-table col-7" >

                    <thead>
                        <tr>
                            <th></th>
                            <th>Products</th>
                            <th>Size</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" /> 
                        <c:forEach items="${listOrderDetail}" var="od">
                            <c:set var="pro" value=""></c:set>
                            <c:forEach items="${listProduct}" var="p">
                                <c:if test="${od.productID == p.productID}">
                                    <c:set var="pro" value="${p}"></c:set>
                                </c:if>
                            </c:forEach>
                            <tr>
                                <td style="font-weight: bold; padding: 8px;"> 
                                    <figure class="product-image-container">
                                        <a href="product-detail?productID=${od.productID}" class="product-image">
                                            <% 
                                                ProductImageDAO imageDAO = new ProductImageDAO();
                                                OrderDetail orderDetail = (OrderDetail) pageContext.getAttribute("od");
                                                String imageURL = imageDAO.getImageURLByProductId(orderDetail.getProductID());
                                            %>
                                            <img src="<%= imageURL != null ? imageURL : "/assets" %>" alt="product" style="width: 100px; height: auto;">
                                        </a>
                                    </figure>
                                </td>
                                <td class="product-col" style="font-weight: bold; padding: 8px;">
                                    <h5 class="product-title">
                                        <a href="product-detail?productID=${pro.productID}">${pro.productName}</a>
                                    </h5>
                                </td>
                                <td style="font-weight: bold; padding: 8px;">
                                    <c:forEach items="${listSizeAll}" var="size">
                                        <c:if test="${size.sizeID == od.sizeID}">
                                            ${size.sizeName}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td style="font-weight: bold; padding: 8px;">

                                    <div class="price">

                                        <span class="new-price">
                                            <fmt:formatNumber value="${od.price}" type="currency" currencySymbol="đ" />
                                        </span>
                                    </div>


                                </td>
                                <td style="padding: 8px; font-weight: bold; text-align: center; vertical-align: middle; padding-right: 30px;">
                                    ${od.quantity}
                                </td>

                                <td style="font-weight: bold; padding: 8px;">

                                    <div class="price">

                                        <span class="new-price">
                                            <fmt:formatNumber value="${od.price * od.quantity}" type="currency" currencySymbol="đ" />
                                        </span>
                                    </div>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>


                </table>

                <div class="col-lg-5">
                    <div class="order-summary">
                        <h3 style="padding-bottom: 20px ;padding-left: 180px;;">Information about Customer</h3>

                        <table class="table table-mini-cart" style="width: 100%; border-collapse: separate; border-spacing: 0 15px;">
                            <tbody>
                                <c:set var="c" value="${customer}"/>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Full Name:</td>
                                    <td style="padding: 10px;">${c.fullName}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Email:</td>
                                    <td style="padding: 10px;">${c.email}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Phone Number:</td>
                                    <td style="padding: 10px;">${c.phone}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Address:</td>
                                    <td style="padding: 10px;">${c.address}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Payment Methods:</td>
                                    <td style="padding: 10px;">${c.paymentMethod}</td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold; padding: 10px;">Note:</td>
                                    <td style="padding: 10px;">${c.note}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- End .cart-summary -->
            </div>
        </div>


        <!-- Footer -->
        <footer class="footer bg-dark">
            <div class="footer-middle">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-sm-6">
                            <div class="widget">
                                <h4 class="widget-title">Contact Info</h4>
                                <ul class="contact-info">
                                    <li>
                                        <span class="contact-info-label">Address:</span>123 Street Name, City, England
                                    </li>
                                    <li>
                                        <span class="contact-info-label">Phone:</span><a href="tel:">(123)
                                            456-7890</a>
                                    </li>
                                    <li>
                                        <span class="contact-info-label">Email:</span> <a href="https://portotheme.com/cdn-cgi/l/email-protection#462b272f2a06233e272b362a236825292b"><span class="__cf_email__" data-cfemail="204d41494c604558414d504c450e434f4d">[email&#160;protected]</span></a>
                                    </li>
                                    <li>
                                        <span class="contact-info-label">Working Days/Hours:</span> Mon - Sun / 9:00 AM - 8:00 PM
                                    </li>
                                </ul>
                                <div class="social-icons">
                                    <a href="#" class="social-icon social-facebook icon-facebook" target="_blank" title="Facebook"></a>
                                    <a href="#" class="social-icon social-twitter icon-twitter" target="_blank" title="Twitter"></a>
                                    <a href="#" class="social-icon social-instagram icon-instagram" target="_blank" title="Instagram"></a>
                                </div>
                                <!-- End .social-icons -->
                            </div>
                            <!-- End .widget -->
                        </div>
                        <!-- End .col-lg-3 -->

                        <div class="col-lg-3 col-sm-6">
                            <div class="widget">
                                <h4 class="widget-title">Customer Service</h4>

                                <ul class="links">
                                    <li><a href="#">Help & FAQs</a></li>
                                    <li><a href="#">Order Tracking</a></li>
                                    <li><a href="#">Shipping & Delivery</a></li>
                                    <li><a href="#">Orders History</a></li>
                                    <li><a href="#">Advanced Search</a></li>
                                    <li><a href="dashboard.html">My Account</a></li>
                                    <li><a href="#">Careers</a></li>
                                    <li><a href="about.html">About Us</a></li>
                                    <li><a href="#">Corporate Sales</a></li>
                                    <li><a href="#">Privacy</a></li>
                                </ul>
                            </div>
                            <!-- End .widget -->
                        </div>
                        <!-- End .col-lg-3 -->

                        <div class="col-lg-3 col-sm-6">
                            <div class="widget">
                                <h4 class="widget-title">Popular Tags</h4>

                                <div class="tagcloud">
                                    <a href="#">Bag</a>
                                    <a href="#">Black</a>
                                    <a href="#">Blue</a>
                                    <a href="#">Clothes</a>
                                    <a href="#">Fashion</a>
                                    <a href="#">Hub</a>
                                    <a href="#">Shirt</a>
                                    <a href="#">Shoes</a>
                                    <a href="#">Skirt</a>
                                    <a href="#">Sports</a>
                                    <a href="#">Sweater</a>
                                </div>
                            </div>
                            <!-- End .widget -->
                        </div>
                        <!-- End .col-lg-3 -->

                        <div class="col-lg-3 col-sm-6">
                            <div class="widget widget-newsletter">
                                <h4 class="widget-title">Subscribe newsletter</h4>
                                <p>Get all the latest information on events, sales and offers. Sign up for newsletter:
                                </p>
                                <form action="#" class="mb-0">
                                    <input type="email" class="form-control m-b-3" placeholder="Email address" required>

                                    <input type="submit" class="btn btn-primary shadow-none" value="Subscribe">
                                </form>
                            </div>
                            <!-- End .widget -->
                        </div>
                        <!-- End .col-lg-3 -->
                    </div>
                    <!-- End .row -->
                </div>
                <!-- End .container -->
            </div>
            <!-- End .footer-middle -->

            <div class="container">
                <div class="footer-bottom">
                    <div class="container d-sm-flex align-items-center">
                        <div class="footer-left">
                            <span class="footer-copyright">© Porto eCommerce. 2021. All Rights Reserved</span>
                        </div>

                        <div class="footer-right ml-auto mt-1 mt-sm-0">
                            <div class="payment-icons">
                                <span class="payment-icon visa" style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-visa.svg)"></span>
                                <span class="payment-icon paypal" style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-paypal.svg)"></span>
                                <span class="payment-icon stripe" style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-stripe.png)"></span>
                                <span class="payment-icon verisign" style="background-image:  url(${pageContext.request.contextPath}/assets/images/payments/payment-verisign.svg)"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End .footer-bottom -->
            </div>
            <!-- End .container -->
        </footer>


        <!-- Plugins JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>
        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
    </body>


</html>


