<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:15:03 GMT -->
    <!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
    <head>
        <script>


            function validateCartItems() {
            const cartItems = [
            <c:forEach items="${listCartItem}" var="ci" varStatus="loop">
                <c:set var="pro1" value=""></c:set>
                <c:forEach items="${listProductAttribute}" var="pa">
                    <c:if test="${ci.productID == pa.productID && ci.sizeID == pa.sizeID}">
                        <c:set var="pro1" value="${pa}" />
                    </c:if>
                </c:forEach>
            {
            id: ${ci.productID},
                    size: ${ci.sizeID},
                    quantity: ${ci.stock},
                    availableStock: ${pro1.stock - pro1.hold}
            }<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];
            // Lặp qua các sản phẩm để kiểm tra tồn kho khả dụng
            for (const item of cartItems) {
            if (item.quantity > item.availableStock) {
            // Hiển thị thông báo lỗi nếu số lượng vượt quá tồn kho
            const errorMessage = `Đang có sản phẩm có số lượng đặt hàng vượt quá số lượng tồn kho khả dụng!`;
            document.getElementById("error-message").innerText = errorMessage;
            document.getElementById("error-message").style.display = "block";
            return false; // Ngăn không cho form submit
            }
            }
            return true; // Cho phép submit nếu tất cả số lượng hợp lệ
            }
        </script>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Badminton Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            /* Simplified button style for adding new address */
            .add-button {
                margin-top: 20px;
                background-color: black; /* Change background to black */
                color: white; /* Change text color to white for contrast */
                border: none; /* Remove border for a cleaner look */
                border-radius: 5px; /* Slightly rounded corners */
                width: 30px; /* Width of the button */
                height: 30px; /* Height of the button */
                font-size: 18px; /* Smaller font size for the "+" symbol */
                cursor: pointer; /* Pointer cursor on hover */
                display: flex; /* Flexbox for centering */
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
                transition: background-color 0.3s, transform 0.3s; /* Smooth transition effects */
                margin-left: 10px; /* Space between the select and the button */
            }

            /* Hover effect for the button */
            .add-button:hover {
                background-color: #333; /* Darker shade of black on hover */
                transform: scale(1.05); /* Slightly enlarge on hover */
            }
            #addressSelect {
                width: 100%; /* Full width */
                padding: 8px 8px; /* Add padding for comfort */
                margin-bottom: 10px; /* Space between the select and other elements */
                margin-left: 8px; /* Space from the left */
                font-size: 12px; /* Increase font size for readability */
                color: #333; /* Text color */
                background-color: #f9f9f9; /* Light background */
                border: 1px solid #ccc; /* Subtle border */
                border-radius: 4px; /* Rounded corners */
                outline: none; /* Remove outline on focus */
                transition: border-color 0.3s ease; /* Smooth border color transition */
            }

            #addressSelect:focus {
                border-color: #007bff; /* Highlight border on focus */
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Soft shadow on focus */
            }

            /* Optional: Style dropdown icon */
            #addressSelect::-ms-expand {
                display: none; /* Remove default icon in IE */
            }
            #addressSelect::after {
                content: "▼"; /* Custom arrow */
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                pointer-events: none;
            }
        </style>

    </head>

    <body>

        <jsp:include page="common/header.jsp"></jsp:include>

            <div class="page-wrapper" style="margin-top: 200px">



                <main class="main main-test">
                    <div class="container checkout-container">
                        <ul class="checkout-progress-bar d-flex justify-content-center flex-wrap" style="margin-bottom: 0px">
                            <li>
                                <a href="cart?">Shopping Cart</a>
                            </li>
                            <li class="active">
                                <a href="checkout?cartID=${cartID}&customerID=${customerID}">Checkout</a>
                            </li>
                            <li class="disabled">
                                <a href="#">Order Complete</a>
                            </li>
                        </ul>



                    <div class="row">

                        <!-- Billing details -->

                        <div class="col-lg-10 offset-lg-1">
                            <div class="order-summary" style="margin-bottom: 10px">
                                <h3 style="color:#0088CC">YOUR ORDER</h3>

                                <table class="table table-mini-cart">
                                    <thead>
                                        <tr>
                                            <th colspan="2">Product</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:set var="total" value="0"></c:set>
                                        <c:forEach items="${listCartItem}" var="ci">
                                            <c:set var="pro" value=""></c:set>
                                            <c:forEach items="${listProduct}" var="p">
                                                <c:if test="${ci.productID == p.productID}">
                                                    <c:set var="pro" value="${p}"></c:set>
                                                </c:if>
                                            </c:forEach>
                                            <tr>
                                                <td class="product-col">
                                                    <h3 class="product-title">
                                                        <c:forEach items="${listSizeAll}" var="size">
                                                            <c:if test="${ci.sizeID == size.sizeID}">
                                                                ${pro.productName} (${size.sizeName})
                                                            </c:if>

                                                        </c:forEach>
                                                        <span class="product-qty"> × ${ci.stock}</span>
                                                    </h3>
                                                </td>

                                                <td class="price-col">
                                                    <span> 



                                                        <div class="price">

                                                            <span class="new-price">
                                                                <fmt:formatNumber value="${ci.price * ci.stock}" type="currency" currencySymbol="đ" />
                                                                <c:set var="total" value="${total + (ci.price * ci.stock)}" />
                                                            </span>
                                                        </div>

                                                    </span>

                                                </td>
                                            </tr>

                                        </c:forEach>

                                    </tbody>
                                    <tfoot>

                                        <tr class="order-shipping">


                                        </tr>

                                        <tr class="order-total">
                                            <td>
                                                <h4>Total</h4>
                                            </td>
                                            <td>
                                                <b class="total-price"><span>
                                                        <fmt:formatNumber value="${total}"  type="currency" currencySymbol="đ"/>
                                                    </span></b>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>

                                <form action="${pageContext.request.contextPath}/submitOrder" method="post" onsubmit="return validateCartItems()" style="margin-bottom: 15px"> 
                                    <div class="payment-methods">

                                        <h4>Payment methods
                                            <abbr class="required" title="required">*</abbr>
                                        </h4>

                                        <!-- Payment options -->
                                        <c:choose>
                                            <c:when test="${total >= 2000000}">
                                                <input type="radio" id="cod" name="payment" value="Cash on delivery - COD" disabled/>
                                                <label for="cod">Cash on delivery - COD</label>
                                                <p style="color: red; font-size: 12px;">Đơn hàng từ 2 triệu trở lên không hỗ trợ thanh toán khi nhận hàng.</p>
                                            </c:when>
                                                
                                            <c:otherwise>
                                                <input type="radio" id="cod" name="payment" value="Cash on delivery - COD" required checked/>
                                                <label for="cod">Cash on delivery - COD</label>
                                                <br/> <br/>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Label for Credit Card -->
                                        <input type="radio" id="VN Pay" name="payment" value="VN Pay" required/>
                                        <label for="credit-card">VN Pay</label>


                                    </div>
                                    <!-- Billing Details Section -->

                                    <ul class="checkout-steps" style="padding-bottom: 0;">
                                        <li style="margin-bottom: 0;">
                                            <h4 style="margin-left: 7px">
                                                <i class="fas fa-map-marker-alt" style="margin-right: 5px;"></i>
                                                Shipping Address
                                            </h4>
                                            <div class="d-flex justify-content-between align-items-center">
                                                <!-- Billing details -->
                                                <div class="billing-info d-flex align-items-center" style="margin-top: 10px;
                                                     margin-left: 15px">
                                                    <div class="form-group mr-3"> <!-- Reduced margin-right to 3 -->
                                                        <p style="margin-bottom: 5px;
                                                           color:#222529"><b>${sessionScope.customerCheckOut.fullName}</b></p> <!-- Reduced margin between paragraphs -->
                                                    </div>
                                                    <div class="form-group mr-3">
                                                        <p style="margin-bottom: 5px;
                                                           margin-left: 8px;
                                                           color:#222529"><b>${sessionScope.customerCheckOut.phone}</b></p>
                                                    </div>
                                                    <div class="form-group">
                                                        <select style="margin-bottom: 5px;
                                                                margin-left: 8px" id="addressSelect" name="selectedAddress">
                                                            <option>
                                                                ${sessionScope.customerCheckOut.getAddress()}
                                                            </option>
                                                            <c:forEach items="${sessionScope.addresses}" var="subAddress">
                                                                <option>
                                                                    ${subAddress.addressName}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <!-- Edit button -->
                                                <a href="edit-address?cid=${sessionScope.customerCheckOut.customerID}" class="btn btn-dark btn-sm ml-3" style="margin-bottom: 10px;
                                                   align-self: center;">Edit</a>                                         </div>
                                        </li>
                                    </ul>

                                    <div class="form-group">
                                        <label class="order-comments">Order notes (optional)</label>
                                        <textarea name="note" class="form-control" placeholder="Notes about your order, e.g. special notes for delivery."></textarea>
                                    </div>
                                    <input type="submit" value="Submit Order"  class="btn btn-dark btn-place-order"/>
                                    <p id="error-message" style="color: red; display: none; margin-top: 10px;"></p>
                                </form>

                            </div>
                            <!-- End .cart-summary -->
                        </div>

                        <!-- End .col-lg-4 -->
                    </div>
                    <!-- End .row -->
                </div>
                <!-- End .container -->
            </main>
            <!-- End .main -->

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
            <!-- End .footer -->
        </div>
        <!-- End .page-wrapper -->

        <div class="loading-overlay">
            <div class="bounce-loader">
                <div class="bounce1"></div>
                <div class="bounce2"></div>
                <div class="bounce3"></div>
            </div>
        </div>

        <div class="mobile-menu-overlay"></div>
        <!-- End .mobil-menu-overlay -->

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
                        <li>
                            <a href="#">Elements</a>
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
                            <a href="https://1.envato.market/DdLk5" target="_blank">
                                Buy Porto!
                                <span class="tip tip-hot">Hot</span>
                            </a>
                        </li>
                    </ul>

                    <ul class="mobile-menu">
                        <li><a href="dashboard.html">My Account</a></li>
                        <li><a href="about.html">About Us</a></li>
                        <li><a href="blog.html">Blog</a></li>
                        <li><a href="wishlist.html">My Wishlist</a></li>
                        <li><a href="cart.html">Cart</a></li>
                        <li><a href="login.html" class="login-link">Log In</a></li>
                    </ul>
                </nav>
                <!-- End .mobile-nav -->

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
            </div>
            <!-- End .mobile-menu-wrapper -->
        </div>
        <!-- End .mobile-menu-container -->

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
                <a href="https://www.portotheme.com/html/porto_ecommerce/my-account.html" class="">
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
        <script data-cfasync="false" src="../../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
    </body>


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:15:07 GMT -->
</html>
