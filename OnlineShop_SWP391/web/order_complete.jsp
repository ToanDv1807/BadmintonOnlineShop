<%-- 
    Document   : cart
    Created on : Jul 10, 2024, 3:30:55 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dal.marketer.ProductImageDAO" %>
<%@ page import="model.CartItem" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from portotheme.com/html/porto_ecommerce/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:15:03 GMT -->
    <!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Badminton Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">

        <meta name="keywords" content="HTML5 Template" />
        <meta name="description" content="Porto - Bootstrap eCommerce Template">
        <meta name="author" content="SW-THEMES">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/favicon.png">


        <script>
            WebFontConfig = {
                google: {families: ['Open+Sans:300,400,600,700,800', 'Poppins:300,400,500,600,700', 'Shadows+Into+Light:400']}
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
        <style>
            /* General button styles */
.buttons a {
    display: inline-block; /* Ensures the button respects padding */
    padding: 10px 15px; /* Reduced padding for a narrower look */
    margin: 10px 5px; /* Margin for spacing between buttons */
    background-color: #000; /* Bright blue background */
    color: white; /* White text color */
    text-align: center; /* Center text */
    border-radius: 30px; /* More rounded corners for a modern look */
    text-decoration: none; /* Remove underline */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
    font-size: 16px; /* Font size */
    width: 300px; /* Set a fixed width for narrower buttons */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Enhanced shadow for depth */
    border: 2px solid transparent; /* Border for hover effect */
}

/* Hover effect */
.buttons a:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: translateY(-2px); /* Slight lift effect on hover */
    border-color: #0056b3; /* Border color on hover */
}

/* Active state */
.buttons a:active {
    background-color: #004085; /* Even darker blue when pressed */
    transform: translateY(0); /* Reset lift effect */
}


        </style>
    </head>

    <body>
        <jsp:include page="common/header.jsp"></jsp:include>
            <div class="page-wrapper" style="margin-top: 200px">




                <main class="main" >
                    <div class="container">
                        <ul class="checkout-progress-bar d-flex justify-content-center flex-wrap">
                            <li class="active">
                                <a href="cart">Shopping Cart</a>
                            </li>
                            <li>
                                <a href="checkout">Checkout</a>
                            </li>
                            <li class="disabled">
                                <a href="cart.html">Order Complete</a>
                            </li>
                        </ul>

                        
                        <div class="container">
<!--                            Mã đơn hàng của quý khách là-->
<!--                            <strong>[2024093064114_200907]</strong>.-->
                            <h1>Thông báo</h1>
                            <p>Đơn hàng của quý khách đã được đặt thành công.  </p>
                            <p>- Thời gian xử lý đơn hàng: Từ 8h30- 17h30 Thứ 2 đến thứ 6 và 8h30-12h30 Thứ 7 hàng tuần. Các đơn hàng sau thời gian này sẽ được xử lý vào ngày làm việc tiếp theo.</p>

                        </div>
                        <div class="buttons">
                            <c:set var="o" value="${orderID}"/>
                            <a href="home" class="btn btn-block btn-dark"  > Back to home Page </a>
                            <a href="orderInformation?orderID=${o}" class="btn btn-block btn-dark" " >View Order Information</a>
                        </div>
                    </div><!-- End .container -->

                    <div class="mb-6"></div><!-- margin -->
                </main><!-- End .main -->

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
                                                <span class="contact-info-label">Email:</span> <a href="https://portotheme.com/cdn-cgi/l/email-protection#1974787075597c61787469757c377a7674"><span class="_cf_email_" data-cfemail="b5d8d4dcd9f5d0cdd4d8c5d9d09bd6dad8">[email&#160;protected]</span></a>
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
        </div><!-- End .page-wrapper -->

        <div class="loading-overlay">
            <div class="bounce-loader">
                <div class="bounce1"></div>
                <div class="bounce2"></div>
                <div class="bounce3"></div>
            </div>
        </div>

        <div class="mobile-menu-overlay"></div><!-- End .mobil-menu-overlay -->

        <div class="mobile-menu-container">
            <div class="mobile-menu-wrapper">
                <span class="mobile-menu-close"><i class="fa fa-times"></i></span>
                <nav class="mobile-nav">
                    <ul class="mobile-menu">
                        <li><a href="demo4.html">Home</a></li>
                        <li>
                            <a href="category.html">Categories</a>
                            <ul>
                                <li><a href="category.html">Full Width Banner</a></li>
                                <li><a href="category-banner-boxed-slider.html">Boxed Slider Banner</a></li>
                                <li><a href="category-banner-boxed-image.html">Boxed Image Banner</a></li>
                                <li><a href="https://www.portotheme.com/html/porto_ecommerce/category-sidebar-left.html">Left Sidebar</a></li>
                                <li><a href="category-sidebar-right.html">Right Sidebar</a></li>
                                <li><a href="category-off-canvas.html">Off Canvas Filter</a></li>
                                <li><a href="category-horizontal-filter1.html">Horizontal Filter 1</a></li>
                                <li><a href="category-horizontal-filter2.html">Horizontal Filter 2</a></li>
                                <li><a href="#">List Types</a></li>
                                <li><a href="category-infinite-scroll.html">Ajax Infinite Scroll<span
                                            class="tip tip-new">New</span></a></li>
                                <li><a href="category.html">3 Columns Products</a></li>
                                <li><a href="category-4col.html">4 Columns Products</a></li>
                                <li><a href="category-5col.html">5 Columns Products</a></li>
                                <li><a href="category-6col.html">6 Columns Products</a></li>
                                <li><a href="category-7col.html">7 Columns Products</a></li>
                                <li><a href="category-8col.html">8 Columns Products</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="product.html">Products</a>
                            <ul>
                                <li>
                                    <a href="#" class="nolink">PRODUCT PAGES</a>
                                    <ul>
                                        <li><a href="product.html">SIMPLE PRODUCT</a></li>
                                        <li><a href="product-variable.html">VARIABLE PRODUCT</a></li>
                                        <li><a href="product.html">SALE PRODUCT</a></li>
                                        <li><a href="product.html">FEATURED & ON SALE</a></li>
                                        <li><a href="product-sticky-info.html">WIDTH CUSTOM TAB</a></li>
                                        <li><a href="product-sidebar-left.html">WITH LEFT SIDEBAR</a></li>
                                        <li><a href="product-sidebar-right.html">WITH RIGHT SIDEBAR</a></li>
                                        <li><a href="product-addcart-sticky.html">ADD CART STICKY</a></li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="#" class="nolink">PRODUCT LAYOUTS</a>
                                    <ul>
                                        <li><a href="product-extended-layout.html">EXTENDED LAYOUT</a></li>
                                        <li><a href="product-grid-layout.html">GRID IMAGE</a></li>
                                        <li><a href="product-full-width.html">FULL WIDTH LAYOUT</a></li>
                                        <li><a href="product-sticky-info.html">STICKY INFO</a></li>
                                        <li><a href="product-sticky-both.html">LEFT & RIGHT STICKY</a></li>
                                        <li><a href="product-transparent-image.html">TRANSPARENT IMAGE</a></li>
                                        <li><a href="product-center-vertical.html">CENTER VERTICAL</a></li>
                                        <li><a href="#">BUILD YOUR OWN</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">Pages<span class="tip tip-hot">Hot!</span></a>
                            <ul>
                                <li>
                                    <a href="wishlist.html">Wishlist</a>
                                </li>
                                <li>
                                    <a href="cart.html">Shopping Cart</a>
                                </li>
                                <li>
                                    <a href="checkout.html">Checkout</a>
                                </li>
                                <li>
                                    <a href="dashboard.html">Dashboard</a>
                                </li>
                                <li>
                                    <a href="login.html">Login</a>
                                </li>
                                <li>
                                    <a href="forgot-password.html">Forgot Password</a>
                                </li>
                            </ul>
                        </li>
                        <li><a href="blog.html">Blog</a></li>                                
                        <li><a href="#">Elements</a>
                            <ul class="custom-scrollbar">
                                <li><a href="element-accordions.html">Accordion</a></li>
                                <li><a href="element-alerts.html">Alerts</a></li>
                                <li><a href="element-animations.html">Animations</a></li>
                                <li><a href="element-banners.html">Banners</a></li>
                                <li><a href="element-buttons.html">Buttons</a></li>
                                <li><a href="element-call-to-action.html">Call to Action</a></li>
                                <li><a href="element-countdown.html">Count Down</a></li>
                                <li><a href="element-counters.html">Counters</a></li>
                                <li><a href="element-headings.html">Headings</a></li>
                                <li><a href="element-icons.html">Icons</a></li>
                                <li><a href="element-info-box.html">Info box</a></li>
                                <li><a href="element-posts.html">Posts</a></li>
                                <li><a href="element-products.html">Products</a></li>
                                <li><a href="element-product-categories.html">Product Categories</a></li>
                                <li><a href="element-tabs.html">Tabs</a></li>
                                <li><a href="element-testimonial.html">Testimonials</a></li>
                            </ul>
                        </li>
                    </ul>

                    <ul class="mobile-menu mt-2 mb-2">
                        <li class="border-0">
                            <a href="#">
                                Special Offer!
                            </a>
                        </li>
                        <li class="border-0">
                            <a href="#" target="_blank">
                                Buy Porto!
                                <span class="tip tip-hot">Hot</span>
                            </a>
                        </li>
                    </ul>

                    <ul class="mobile-menu">
                        <li><a href="login.html">My Account</a></li>
                        <li><a href="contact.html">Contact Us</a></li>
                        <li><a href="blog.html">Blog</a></li>
                        <li><a href="wishlist.html">My Wishlist</a></li>
                        <li><a href="cart.html">Cart</a></li>
                        <li><a href="login.html" class="login-link">Log In</a></li>
                    </ul>
                </nav><!-- End .mobile-nav -->

                <form class="search-wrapper mb-2" action="#">
                    <input type="text" class="form-control mb-0" placeholder="Search..." required />
                    <button class="btn icon-search text-white bg-transparent p-0" type="submit"></button>
                </form>

                <div class="social-icons">
                    <a href="#" class="social-icon social-facebook icon-facebook" target="_blank">
                    </a>
                    <a href="#" class="social-icon social-twitter icon-twitter" target="_blank">
                    </a>
                    <a href="#" class="social-icon social-instagram icon-instagram" target="_blank">
                    </a>
                </div>
            </div><!-- End .mobile-menu-wrapper -->
        </div><!-- End .mobile-menu-container -->

        <div class="sticky-navbar">
            <div class="sticky-info">
                <a href="demo4.html">
                    <i class="icon-home"></i>Home
                </a>
            </div>
            <div class="sticky-info">
                <a href="category.html" class="">
                    <i class="icon-bars"></i>Categories
                </a>
            </div>
            <div class="sticky-info">
                <a href="wishlist.html" class="">
                    <i class="icon-wishlist-2"></i>Wishlist
                </a>
            </div>
            <div class="sticky-info">
                <a href="login.html" class="">
                    <i class="icon-user-2"></i>Account
                </a>
            </div>
            <div class="sticky-info">
                <a href="cart.html" class="">
                    <i class="icon-shopping-cart position-relative">
                        <span class="cart-count badge-circle">3</span>
                    </i>Cart
                </a>
            </div>
        </div>



        <a id="scroll-top" href="#top" title="Top" role="button"><i class="icon-angle-up"></i></a>

        <!-- Plugins JS File -->
        <script data-cfasync="false" src="${pageContext.request.contextPath}/assets/js/email-decode.min.js"></script><script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>



        <script>
            window.onload = function () {
                updateSubTotal();
            };

            function updateSubTotal() {
                let totalPriceOfEachProduct = document.querySelectorAll('form td.text-right');
                let totalCart = 0;
                totalPriceOfEachProduct.forEach(e => {
                    let totalPrice = parseFloat(e.textContent.trim());
                    totalCart += totalPrice;
                })
                document.querySelector('#totalCart').innerHTML = totalCart;
            }



        </script>



    </body>


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:15:05 GMT -->
</html>

