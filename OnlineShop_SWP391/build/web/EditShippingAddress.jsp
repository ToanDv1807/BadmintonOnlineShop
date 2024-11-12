<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Address</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            form {
                max-width: 850px;
                margin: auto;
                background-color: #f4f4f4;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 100px;
            }
            h1 {
                text-align: center;
                color: #333;
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
            }
            .input-group {
                display: flex;
                align-items: center;
            }
            input[type="text"] {
                width: 70%; /* Điều chỉnh độ rộng của input */
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-right: 10px; /* Khoảng cách giữa input và các nút */
                box-sizing: border-box;
                height: 40px; /* Đảm bảo chiều cao của input */
            }
            .btn {
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 0.9rem;
                margin-top: 0; /* Remove top margin for buttons */
                height: 40px; /* Ensure all buttons have the same height */
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: black; /* Default button background color */
                color: white; /* Default button text color */
            }

            .a {
                text-decoration: none; /* Remove underline for anchor tags */
            }

            .btn-edit {
                background-color: #ffc107;
                color: white;
                margin-right: 10px;
                padding-right: 8px;
                padding-left: 8px;
            }

            .btn-delete {
                background-color: #dc3545;
                color: white;
                margin-right: 10px;
                text-decoration: none; /* Ensure no underline for delete button */
                padding-top: 0px;
                padding-bottom: 0px;
                padding-right: 7px;
                padding-left: 7px;
            }

            .btn-back {
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                border-radius: 4px;
            }

            .btn-add {
                background-color: #28a745;
                color: white;
                display: inline-block;
                padding: 5px 10px;
            }
            /* Modal styling */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                max-width: 500px;
                width: 100%;
            }
            .modal-content h2 {
                margin-top: 0;
            }
            .modal-footer {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
            }

            .button-group {
                position: absolute; /* Đặt vị trí tuyệt đối */
                top: 20px; /* Khoảng cách từ đầu trang */
                right: 20px; /* Khoảng cách từ bên phải */
                display: flex;
                justify-content: flex-end; /* Căn giữa nếu có nhiều nút */
            }
            /* Notification styling */
            #notification {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                display: none; /* Ẩn notification ban đầu */
                z-index: 2000; /* Đảm bảo notification nằm trên cùng */
            }
            .modal-content input[type="text"] {
                width: calc(100% - 20px); /* Make the input take almost full width, considering padding */
                padding: 10px; /* Keep existing padding */
                border: 1px solid #ccc; /* Keep existing border */
                border-radius: 4px; /* Keep existing border radius */
                box-sizing: border-box; /* Ensure padding and border are included in width */
            }
            .btn-default {
                text-decoration: none; /* Remove underline */
                background-color: black; /* Default background color for buttons */
                color: white;
                text-decoration: none; /* Ensure no underline for delete button */
                padding-left: 7px;
            }

            a {
                text-decoration: none; /* Remove underline from all links */
            }
        </style>
    </head>
    <body>
        <jsp:include page="common/header.jsp"></jsp:include>
        <div id="notification">${requestScope.message}</div> <!-- Thông báo -->
        <h1 style="margin-bottom: 40px; margin-top: 200px">Edit Shipping Address</h1>
        <form action="EditAddressServlet" method="POST">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <div class="input-group">
                    <input type="text" id="fullName" name="fullName" value="${sessionScope.customerToGetAddress.fullName}" readonly />
                    <button type="button" class="btn btn-edit" onclick="openEditFullNameModal('${sessionScope.customerToGetAddress.fullName}')"><i class="fas fa-edit"></i>Edit</button>
                </div>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <div class="input-group">
                    <input type="text" id="phone" name="phone" value="${sessionScope.customerToGetAddress.phone}" readonly />
                    <button type="button" class="btn btn-edit" onclick="openEditPhoneModal('${sessionScope.customerToGetAddress.phone}')"><i class="fas fa-edit"></i>Edit</button>
                </div>
            </div>
            <div class="button-group" style="margin-right: 180px; margin-top: 220px">
                <button type="button" class="btn-add" onclick="openAddModal()"><i class="fas fa-plus"></i>Add New Address</button>
            </div>  
            <div id="addressContainer">
                <!-- Display the main customer address -->
                <div class="form-group address-group">
                    <label>Address 1:</label>
                    <div class="input-group">
                        <input type="text" name="primaryAddress" value="${sessionScope.customerToGetAddress.address}" readonly />
                        <button type="button" class="btn btn-edit" onclick="openEditModal('primary', '${sessionScope.customerToGetAddress.address}')"><i class="fas fa-edit"></i>Edit</button>
                    </div>
                </div>

                <c:forEach var="address" items="${sessionScope.addresses}" varStatus="status">
                    <div class="form-group address-group">
                        <label>Address ${status.index + 2}:</label> <!-- Thêm 1 để bắt đầu từ 1 thay vì 0 -->
                        <div class="input-group">
                            <input type="text" name="addresses" value="${address.addressName}" readonly />
                            <button type="button" class="btn btn-edit" onclick="openEditModal(${address.addressID}, '${address.addressName}')"><i class="fas fa-edit"></i>Edit</button>
                            <a href="javascript:void(0);" class="btn btn-delete" onclick="confirmDelete('${address.addressID}')">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                            <a href="SetDefaultAddressServlet?addressID=${address.addressID}" class="btn btn-default">
                                <i class="fas fa-star"></i> Set to Default
                            </a>  
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Add Address button -->
            <div style="margin-top: 30px">
                <a href="checkout" class="btn-back"><i class="fas fa-arrow-left"></i>Back to Checkout</a>
            </div>
        </form>

        <!-- Modal for editing an address -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <h2>Edit Address</h2>
                <form action="EditAddressServlet" method="POST">
                    <input type="hidden" name="addressId" id="addressIdInput">
                    <input type="text" id="editAddressInput" name="editedAddress" value="" required>

                    <div class="modal-footer">
                        <button type="button" class="btn" onclick="closeEditModal()" style="margin-right: 10px">Cancel</button>
                        <button type="submit" class="btn btn-edit">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal for adding a new address -->
        <div id="addModal" class="modal">
            <div class="modal-content">
                <h2>Add New Address</h2>
                <form action="AddAddressServlet" method="POST">
                    <input type="text" id="newAddressInput" name="newAddress" placeholder="Enter new address" required>
                    <input type="hidden" id="customerID" name="customerID" value="${sessionScope.customerToGetAddress.customerID}">
                    <div class="modal-footer">
                        <button type="button" class="btn" onclick="closeAddModal()" style="margin-right: 10px">Cancel</button>
                        <button type="submit" class="btn btn-add">Add Address</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Full Name Edit Modal -->
        <div id="editFullNameModal" class="modal">
            <div class="modal-content">
                <h2>Edit Full Name</h2>
                <form action="edit-shipping-address" method="POST">
                    <input type="hidden" name="field" value="fullName">
                    <input type="text" id="editFullNameInput" name="editedFullName" required>
                    <div class="modal-footer">
                        <button type="button" class="btn" onclick="closeEditFullNameModal()" style="margin-right: 10px">Cancel</button>
                        <button type="submit" class="btn btn-edit">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Phone Edit Modal -->
        <div id="editPhoneModal" class="modal">
            <div class="modal-content">
                <h2>Edit Phone</h2>
                <form id="editPhoneForm" action="edit-shipping-address" method="POST">
                    <input type="hidden" name="field" value="phone">
                    <input type="text" id="editPhoneInput" name="editedPhone" required>
                    <div class="modal-footer">
                        <button type="button" class="btn" onclick="closeEditPhoneModal()" style="margin-right: 10px">Cancel</button>
                        <button type="submit" class="btn btn-edit">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            document.getElementById('editPhoneForm').addEventListener('submit', function (event) {
                const phoneInput = document.getElementById('editPhoneInput').value;
                const phonePattern = /^0\d{9,10}$/; // Bắt đầu với 0, sau đó là 9 hoặc 10 chữ số

                if (!phonePattern.test(phoneInput)) {
                    event.preventDefault(); // Ngăn chặn gửi biểu mẫu nếu không hợp lệ
                    alert("The phone number must start with 0 and contain 10 or 11 digits.");
                }
            });
        </script>

        <!-- footer -->
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
    <script>
        function openEditModal(addressId, currentAddress) {
            // Show the modal
            document.getElementById('editModal').style.display = 'flex';

            // Set the current address value in the modal input field
            document.getElementById('editAddressInput').value = currentAddress;

            // Set the address ID in a hidden field so it can be submitted with the form
            document.getElementById('addressIdInput').value = addressId;
        }

        function closeEditModal() {
            // Hide the modal
            document.getElementById('editModal').style.display = 'none';
        }

        function openAddModal() {
            // Show the Add Address modal
            document.getElementById('addModal').style.display = 'flex';
        }

        function closeAddModal() {
            // Hide the Add Address modal
            document.getElementById('addModal').style.display = 'none';
        }

        // Function to open the Full Name edit modal
        function openEditFullNameModal(currentFullName) {
            document.getElementById('editFullNameModal').style.display = 'flex';
            document.getElementById('editFullNameInput').value = currentFullName; // Set the current full name value
        }

// Function to close the Full Name edit modal
        function closeEditFullNameModal() {
            document.getElementById('editFullNameModal').style.display = 'none';
        }

// Function to open the Phone edit modal
        function openEditPhoneModal(currentPhone) {
            document.getElementById('editPhoneModal').style.display = 'flex';
            document.getElementById('editPhoneInput').value = currentPhone; // Set the current phone value
        }

// Function to close the Phone edit modal
        function closeEditPhoneModal() {
            document.getElementById('editPhoneModal').style.display = 'none';
        }

        // Hiển thị thông báo nếu có
        window.onload = function () {
            var notification = document.getElementById("notification");
            if (notification.innerText.trim() !== "") {
                notification.style.display = "block"; // Hiển thị thông báo
                setTimeout(function () {
                    notification.style.display = "none"; // Ẩn thông báo sau 2 giây
                }, 3000);
            }
        };

        function confirmDelete(addressID) {
            if (confirm("Are you sure you want to delete this address?")) {
                // If the user confirmed, redirect to the DeleteAddressServlet
                window.location.href = "DeleteAddressServlet?addressID=" + addressID;
            }
        }
        document.querySelector('form').addEventListener('submit', function (event) {
            const phoneInput = document.getElementById('editPhoneInput').value;
            const phonePattern = /^0\d{9,10}$/; // Must start with 0, followed by 9 or 10 more digits

            if (!phonePattern.test(phoneInput)) {
                event.preventDefault(); // Prevent form submission if invalid
                alert("The phone number must start with 0 and contain 10 or 11 digits.");
            }
        });
    </script>
    <!-- Plugins JS File -->
    <script data-cfasync="false" src="../../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

    <!-- Main JS File -->
    <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
</body>
</html>
