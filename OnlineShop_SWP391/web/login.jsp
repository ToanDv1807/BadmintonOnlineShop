<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Login - Online Badminton shop</title>

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/favicon.png">

        <!-- Google Fonts -->
        <script>
            WebFontConfig = {
                google: {families: ['Open+Sans:300,400,600,700', 'Poppins:300,400,500,600,700']}
            };
            (function (d) {
                var wf = d.createElement('script'), s = d.scripts[ 0 ];
                wf.src = '${pageContext.request.contextPath}/assets/js/webfont.js';
                wf.async = true;
                s.parentNode.insertBefore(wf, s);
            })(document);
        </script>

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">

        <!-- Custom CSS for design improvements -->
        <style>
            body {
                background: url('${pageContext.request.contextPath}/assets/images/backgrounds/login-bg.jpg') no-repeat center center;
                background-size: cover;
            }

            .login-container {
                margin-top: 0px;
            }

            .login-card {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .heading {
                text-align: center;
            }

            .btn-dark {
                background-color: #333;
                border-color: #333;
            }

            .form-input {
                border-radius: 5px;
                margin-bottom: 15px;
            }

            .form-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .forget-password {
                color: #007bff;
                text-decoration: none;
            }

            .forget-password:hover {
                text-decoration: underline;
            }

            .login-container h1 {
                color: #333;
            }

            @media (max-width: 768px) {
                .login-card {
                    padding: 20px;
                }
            }
        </style>
    </head>

    <body>
        <div class="page-wrapper" style="height: 130px">
            <header class="header header-transparent" style="background-color: black;"> <!-- Changed background color -->
                <div class="header-middle sticky-header">
                    <div class="container-fluid" style="background-color: black; height: 80px">
                        <div class="header-left">
                            <button class="mobile-menu-toggler text-white mr-2" type="button">
                                <i class="fas fa-bars"></i>
                            </button>
                            <a href="home" class="logo">
                                <img style="width: 80px; margin-left: 50px" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" alt="Porto Logo">
                            </a>
                        </div>
                        <div class="header-center justify-content-between" >
                            <nav class="main-nav w-100">
                                <ul class="menu">
                                    <li class="active"><a href="home">Home</a></li>
                                    <li>
                                        <a href="shop">Categories & Products</a>
                                        <div class="megamenu megamenu-fixed-width megamenu-3cols-wide">
                                            <div class="row">
                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                    <div class="col-lg-4">
                                                        <ul class="submenu">
                                                            <li><a href="home" class="category-title" style="font-size: 15px; color: black">${c.catName}</a></li>
                                                        </ul>
                                                        <ul class="submenu">
                                                            <c:forEach items="${sessionScope.products}" var="p">
                                                                <c:if test="${p.catID == c.catID}">
                                                                    <li><a href="">${p.productName}</a></li>
                                                                    </c:if>
                                                                </c:forEach>
                                                        </ul>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </li>
                                    <li><a href="blog-list">Blogs</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="header-right justify-content-end">
                            <div style="width: 40px">
                                <a href="dashboard" title="Manage Product"><img style="width: 100%" src="${pageContext.request.contextPath}/assets/images/icons/604106b111d25339e6282b59_interaction.png" alt="alt"/></a>
                            </div>
                            <div class="header-dropdown" style="width: 100px">
                                <c:set var="a" value="${sessionScope.account}"/>
                                <c:if test="${a !=null}">
                                    <a href="userProfile"  title=""><img style="width: 40%" src="${pageContext.request.contextPath}/assets/images/icons/vector-people-user-icon.jpg" alt="alt"/></a>

                                </c:if>
                                <c:if test="${a ==null}">
                                    <a href="login.jsp"  title="login"><img style="width: 40%" src="${pageContext.request.contextPath}/assets/images/icons/vector-sign-of-user-icon.jpg" alt="alt"/></a>

                                </c:if>



                                <div class="header-menu">
                                    <ul>
                                        <li><a href="wishlist">Wishlist</a></li>
                                        <li><a href="cart.jsp">Shopping Cart</a></li>
                                        <li><a href="checkout.jsp">Checkout</a></li>

                                        <c:if test="${a !=null}">
                                            <li><a href="logout">Log out</a></li>
                                            <li><a href="myorder">My Order</a></li>
                                            </c:if>
                                            <c:if test="${a ==null}">
                                            <li><a href="login.jsp">Login</a></li>
                                            <li>
                                                <a href="forgot-password.jsp">Forgot Password</a>
                                            </li>

                                        </c:if>
                                        <c:if test="${a !=null}">
                                            <li>
                                                <a href="changePassword">Change Password</a>
                                            </li>


                                        </c:if>


                                    </ul>
                                </div>
                                <!-- End .header-menu -->
                            </div>
                            <a href="wishlist" class="header-icon" title="Wishlist"><i class="icon-wishlist-2"><span class="badge-circle"></span></i></a>
                            <div class="header-icon header-search header-search-popup header-search-category text-right">
                                <a href="#" class="search-toggle" role="button"><i class="icon-magnifier"></i></a>
                                <form action="home" method="get">
                                    <div class="header-search-wrapper">
                                        <input type="search" class="form-control" name="name" id="name" placeholder="Search...">
                                        <div class="select-custom">
                                            <select id="catID" name="catID">
                                                <option value="0">All Categories</option>
                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                    <option value="${c.catID}">${c.catName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <button class="btn icon-magnifier p-0" title="search" type="submit"></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
        </div>
        <div class="container login-container d-flex justify-content-center align-items-center" >
            <div class="col-lg-6">
                <div class="login-card">
                    <div class="heading mb-3">
                        <h2 class="title">Login</h2>
                    </div>

                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="login-email">Enter your email: <span class="required">*</span></label>
                            <input type="email" class="form-input form-control" name="email" id="login-email" required />
                        </div>

                        <div class="form-group">
                            <label for="login-password">Enter password: <span class="required">*</span></label>
                            <input type="password" class="form-input form-control" name="password" id="login-password" required />
                        </div>

                        <div class="form-footer">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="remember-me" />
                                <label class="custom-control-label" for="remember-me">Remember me</label>
                            </div>
                            <a href="forgot-password.jsp" class="forget-password">Forgot password?</a>
                        </div>
                        <!-- Phần hiển thị thông báo -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-info" role="alert">
                                ${message}
                            </div>
                        </c:if>
                        <button type="submit" class="btn btn-dark btn-block mt-4">LOGIN</button>

                        <div class="text-center mt-3">
                            <span>Don't have an account yet?</span> 
                            <a href="register.jsp" class="forget-password">Register</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <footer class="footer bg-dark" style="margin-top: 80px">
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
                                        <span class="contact-info-label">Email:</span> <a href="https://portotheme.com/cdn-cgi/l/email-protection#9ef3fff7f2defbe6fff3eef2fbb0fdf1f3"><span class="__cf_email__" data-cfemail="5439353d3814312c35392438317a373b39">[email&#160;protected]</span></a>
                                    </li>
                                    <li>
                                        <span class="contact-info-label">Working Days/Hours:</span>
                                        Mon - Sun / 9:00 AM - 8:00 PM
                                    </li>
                                </ul>
                                <div class="social-icons">
                                    <a href="#" class="social-icon social-facebook icon-facebook" target="_blank"
                                       title="Facebook"></a>
                                    <a href="#" class="social-icon social-twitter icon-twitter" target="_blank"
                                       title="Twitter"></a>
                                    <a href="#" class="social-icon social-instagram icon-instagram" target="_blank"
                                       title="Instagram"></a>
                                </div><!-- End .social-icons -->
                            </div><!-- End .widget -->
                        </div><!-- End .col-lg-3 -->

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
                            </div><!-- End .widget -->
                        </div><!-- End .col-lg-3 -->

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
                            </div><!-- End .widget -->
                        </div><!-- End .col-lg-3 -->

                        <div class="col-lg-3 col-sm-6">
                            <div class="widget widget-newsletter">
                                <h4 class="widget-title">Subscribe newsletter</h4>
                                <p>Get all the latest information on events, sales and offers. Sign up for newsletter:
                                </p>
                                <form action="#" class="mb-0">
                                    <input type="email" class="form-control m-b-3" placeholder="Email address" required>

                                    <input type="submit" class="btn btn-primary shadow-none" value="Subscribe">
                                </form>
                            </div><!-- End .widget -->
                        </div><!-- End .col-lg-3 -->
                    </div><!-- End .row -->
                </div><!-- End .container -->
            </div><!-- End .footer-middle -->

            <div class="container">
                <div class="footer-bottom">
                    <div class="container d-sm-flex align-items-center">
                        <div class="footer-left">
                            <span class="footer-copyright">© Porto eCommerce. 2021. All Rights Reserved</span>
                        </div>

                        <div class="footer-right ml-auto mt-1 mt-sm-0">
                            <div class="payment-icons">
                                <span class="payment-icon visa"
                                      style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-visa.svg)"></span>
                                <span class="payment-icon paypal"
                                      style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-paypal.svg)"></span>
                                <span class="payment-icon stripe"
                                      style="background-image: url(${pageContext.request.contextPath}/assets/images/payments/payment-stripe.png)"></span>
                                <span class="payment-icon verisign"
                                      style="background-image:  url(${pageContext.request.contextPath}/assets/images/payments/payment-verisign.svg)"></span>
                            </div>
                        </div>
                    </div>
                </div><!-- End .footer-bottom -->
            </div><!-- End .container -->
        </footer><!-- End .footer -->
        <!-- Plugins JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
    </body>
</html>
