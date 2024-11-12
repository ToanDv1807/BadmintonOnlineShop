<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Register - Online Badminton shop</title>

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
                height: 100vh;
            }

            .container {
                margin-top: 50px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .register-card {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                max-width: 1000px;
                width: 100%;
            }

            .register-card h2 {
                text-align: center;
                margin-bottom: 20px;
                font-weight: 600;
                font-size: 24px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: 500;
                margin-bottom: 5px;
            }

            .form-control {
                border-radius: 5px;
                padding: 10px;
                box-shadow: none;
                border: 1px solid #ced4da;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: none;
            }

            .btn-dark {
                background-color: #333;
                border-color: #333;
                padding: 10px 15px;
                width: 100%;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 500;
            }

            .message {
                margin-top: 20px;
                text-align: center;
            }
            .tieude{
                font-size: 15px;
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

        <div class="container">
            <div class="register-card">
                <h2>Make new account</h2>
                <form action="register" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="tieude" for="email">Email:</label>
                        <input id="email" class="form-control" type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="password">Password:</label>
                        <input id="password" class="form-control" type="password" name="password" required>
                        <small class="text-muted">
                            Password must start with a capital letter.<br>
                            Password must contain at least one special character.<br>
                            Please only enter a password with a maximum length of 8 characters.
                        </small>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="fullName">Full Name:</label>
                        <input id="fullName" class="form-control" type="text" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="gender">Gender:</label>
                        <select id="gender" class="form-control" name="gender" required>
                            <option value="1">Nam</option>
                            <option value="0">Nữ</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="img_url">Image:</label>
                        <input id="img_url" class="form-control-file" type="file" name="img_url" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="phone">Phone:</label>
                        <input id="phone" class="form-control" type="text" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="address">Address:</label>
                        <input id="address" class="form-control" type="text" name="address" required>
                    </div>
                    <input class="btn btn-dark mt-4" type="submit" value="Register">
                </form>
                <c:if test="${not empty message}">
                    <div class="alert alert-info" role="alert">
                        ${message}
                    </div>
                </c:if>
            </div>
        </div>
        <div style="padding: 20px; background-color: #343a40; color: white;">
            <div style="max-width: 1200px; margin: auto;">
                <div style="display: flex; justify-content: space-between; flex-wrap: wrap;">
                    <!-- Contact Information -->
                    <div style="flex: 1; min-width: 200px;">
                        <h5 style="color: white">Contact Us</h5>
                        <p><strong>Email:</strong> contact@example.com</p>
                        <p><strong>Phone:</strong> +1 (555) 123-4567</p>
                        <p><strong>Address:</strong> 123 Main Street, Anytown, USA</p>
                    </div>

                    <!-- Useful Links -->
                    <div style="flex: 1; min-width: 200px;">
                        <h5 style="color: white">Useful Links</h5>
                        <ul style="list-style-type: none; padding: 0;">
                            <li><a href="about.html" style="color: #0dcaf0; text-decoration: none;">About Us</a></li>
                            <li><a href="services.html" style="color: #0dcaf0; text-decoration: none;">Services</a></li>
                            <li><a href="blog.html" style="color: #0dcaf0; text-decoration: none;">Blog</a></li>
                            <li><a href="contact.html" style="color: #0dcaf0; text-decoration: none;">Contact</a></li>
                        </ul>
                    </div>

                    <!-- Social Media Links -->
                    <div style="flex: 1; min-width: 200px;">
                        <h5 style="color: white">Follow Us</h5>
                        <a href="https://facebook.com" target="_blank" style="color: #0dcaf0; text-decoration: none; margin-right: 15px;">Facebook</a>
                        <a href="https://twitter.com" target="_blank" style="color: #0dcaf0; text-decoration: none; margin-right: 15px;">Twitter</a>
                        <a href="https://instagram.com" target="_blank" style="color: #0dcaf0; text-decoration: none;">Instagram</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Plugins JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
    </body>
</html>
