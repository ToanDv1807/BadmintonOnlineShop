<%-- 
    Document   : BlogList
    Created on : Sep 13, 2024, 10:57:22 PM
    Author     : LENNOVO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Badminton Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo18.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo18.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">
        <style>
            .container {
                max-width: 100%;
                padding: 0 15px;
            }

            .post-infor {
                margin-bottom: 20px; /* Khoảng cách giữa các post */
                border: 1px solid #ddd; /* Đường viền nhẹ */
                padding: 10px; /* Khoảng cách bên trong */
            }

            .searchbar{
                margin-bottom: auto;
                margin-top: auto;
                height: 40px;
                background-color: white;
                border-radius: 20px;
                padding: 5px;
                border: 2px solid black;
                display: flex;
                align-items: center;
            }

            .search_input{
                color: black;
                border: 0;
                outline: 0;
                background: none;
                width: 850px;
                line-height: 30px;
                padding: 0 10px;
            }

            .search_icon{
                height: 30px;
                width: 30px;
                float: right;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 50%;
                text-decoration:none;
                background: darkgray;
                color: black;
            }

            .search_icon:hover {
                text-decoration: none;
                color: black;
            }

            .categories-btn {
                display: flex;
                align-items: center;
                background-color: #000;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                margin-left: 20px;
                position: relative;
            }

            .categories-btn i {
                margin-right: 10px;
            }

            .categories-dropdown {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                background-color: white;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                border-radius: 5px;
                z-index: 1;
                min-width: 200px;
            }

            .categories-dropdown a {
                color: black;
                padding: 10px 20px;
                text-decoration: none;
                display: block;
            }

            .categories-dropdown a:hover {
                background-color: #f1f1f1;
                color: black;
            }

            /* Hiển thị dropdown khi di chuột vào nút Categories */
            .categories-btn:hover .categories-dropdown {
                display: block;
            }

            .breadcrumb {
                background-color: transparent; /* Loại bỏ màu nền */
                padding: 0; /* Loại bỏ khoảng cách padding */
                margin-bottom: 0; /* Loại bỏ khoảng cách dưới breadcrumb */
            }

            .breadcrumb-item a {
                color: black; /* Đổi màu chữ thành đen */
                text-decoration: underline; /* Gạch chân tất cả các liên kết */
            }

            .breadcrumb-item.active {
                color: black; /* Đổi màu chữ của item hiện tại thành đen */
                text-decoration: none; /* Loại bỏ gạch chân cho item hiện tại */
            }

            .latest-posts {
                display: flex;
                gap: 18px;
                flex-wrap: wrap;
            }

            .post-infor img {
                height: 100%; /* Đảm bảo hình ảnh chiếm toàn bộ chiều cao của phần tử */
                width: auto; /* Giữ tỷ lệ khung hình của hình ảnh */
                object-fit: cover; /* Cắt hình ảnh nếu cần để phù hợp */
                flex-shrink: 0; /* Không co hình ảnh nếu kích thước không vừa */
                cursor: pointer;
            }

            .post-details > div {
                margin-bottom: 3px; /* Loại bỏ khoảng cách giữa các phần tử */
            }

            .post-details {
                padding-left: 15px;
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Không sử dụng khoảng cách giữa các phần tử */
                flex-grow: 1;
            }

            .post-details .brief-info {
                font-size: 1.1rem; /* Kích thước font nhỏ hơn */
                overflow: hidden; /* Ẩn phần văn bản vượt quá */
                text-overflow: ellipsis; /* Thêm dấu ... để cắt văn bản dài */
                display: -webkit-box;
                -webkit-line-clamp: 1; /* Giới hạn số dòng hiển thị */
                -webkit-box-orient: vertical; /* Đặt chiều của box là dọc */
            }

            .post-image-link {
                display: block;
                width: 100%;
                height: 100%;
            }

            .post-infor img {
                height: 100%;
                width: 100%;
                object-fit: cover;
                max-height: 140px; /* Chiều cao tối đa */
                flex-shrink: 0;
                cursor: pointer;
            }

            .category, .title, .brief-info, .read-more {
                margin-bottom: 10px; /* Khoảng cách giữa các dòng */
            }

            a {
                text-decoration: none;
                color: inherit; /* Ensure links inherit color */
            }

            a:hover {
                text-decoration: none; /* Remove underline when hovering over links */
                color: inherit; /* Ensure links still inherit color when hovering */
            }

            @media (max-width: 768px) {
                /* Màn hình vừa: chỉ hiển thị 1 bài post per row */
                .post-infor {
                    flex-direction: column;
                    max-width: 100%;
                    width: 100%;
                }

                .post-image {
                    max-height: 200px; /* Tăng chiều cao ảnh trên màn hình vừa */
                }

                .post-details {
                    padding-left: 0;
                    margin-top: 10px; /* Thêm khoảng cách giữa ảnh và thông tin */
                }
            }

            @media (max-width: 768px) {
                .post-infor {
                    flex-direction: column;
                    align-items: flex-start; /* Căn nội dung về đầu khi cột dọc */
                }

                .post-image {
                    width: 100%;
                    max-height: 200px; /* Tăng chiều cao ảnh */
                }

                .post-details {
                    padding-left: 0;
                    margin-top: 10px;
                }
            }

            /* Responsive cho màn hình nhỏ (từ 576px trở xuống) */
            @media (max-width: 576px) {
                .post-infor {
                    flex-direction: column;
                    align-items: flex-start;
                    max-width: 100%;
                    width: 100%;
                }

                .post-image {
                    width: 100%;
                    max-height: 250px; /* Tăng chiều cao ảnh */
                }

                .post-details {
                    padding-left: 0;
                    margin-top: 10px;
                }
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .page-item {
                margin: 0 5px;
            }

            .page-link {
                display: block;
                padding: 5px 10px;
                color: black;
                text-decoration: none;
                border: 1px solid #ddd;
                font-weight: normal;
                transition: all 0.3s ease;
            }

            .page-item.active .page-link {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
                font-weight: bold;
            }

            .page-link:hover {
                background-color: #e9ecef;
                border-color: #ddd;
            }
        </style>
    </head>
    <body>  
        <div class="page-wrapper" style="height: 130px">
            <header class="header header-transparent" style="background-color: black;"> <!-- Changed background color -->
                <div class="header-middle sticky-header">
                    <div class="container-fluid">
                        <div class="header-left">
                            <button class="mobile-menu-toggler text-white mr-2" type="button">
                                <i class="fas fa-bars"></i>
                            </button>
                            <a href="home" class="logo">
                                <img src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" alt="Porto Logo">
                            </a>
                        </div>
                        <div class="header-center justify-content-between">
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
                            <div style="width: 100px">
                                <a href="dashboard" title="Manage Product"><img style="width: 40%" src="${pageContext.request.contextPath}/assets/images/icons/604106b111d25339e6282b59_interaction.png" alt="alt"/></a>
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
        <div style="height: 50px;
             display: flex;
             justify-content: center; margin-top: 80px; margin-bottom: 20px">  
            <div style="margin-right: 12px; margin-top: 10px">Keywords:</div>
            <form id="searchForm" action="search" method="post">
                <div class="container h-100">
                    <div class="d-flex justify-content-center h-100">
                        <div class="searchbar">
                            <input id="searchInput" class="search_input" type="text" name="input" placeholder="Search" spellcheck="false">
                            <a href="#" class="search_icon" onclick="submitForm(event)"><i class="fa fa-search"></i></a>
                        </div>
                    </div>
                </div>
            </form>
            <div class="categories-btn" style="margin-bottom: 10px">
                <i class="fa fa-bars"></i> Categories
                <!-- Danh sách category -->
                <div class="categories-dropdown">
                    <c:forEach items="${requestScope.categories}" var="c">
                        <a href="blog-category?cid=${c.categoryID}">${c.categoryName}</a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item"><a href="blog-list">BlogList</a></li>
                                <c:if test="${empty requestScope.catName}">
                                <li class="breadcrumb-item active" aria-current="#">All</li>
                                </c:if>
                                <c:if test="${not empty requestScope.catName}">
                                <li class="breadcrumb-item active" aria-current="#">${requestScope.catName}</li>
                                </c:if>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <c:if test="${not empty requestScope.top4}">       
            <div style="margin-top: 20px;
                 margin-left: 65px;
                 margin-bottom: 20px"><b>LATEST BLOGS</b></div>
            <div class="container">
                <div class="latest-posts row">
                    <c:forEach items="${requestScope.top4}" var="o">
                        <div class="post-infor col-12 col-md-6 row"> <!-- col-12 cho màn hình nhỏ, col-md-6 cho màn hình lớn -->
                            <!-- Cột ảnh (4 cột) -->
                            <div class="col-4">
                                <a href="blog-detail?bid=${o.blogId}" class="post-image-link">
                                    <img src="assets/images/blog/BlogImg/${o.blogImgUrl}" alt="alt" class="post-image"/>
                                </a>
                            </div>

                            <!-- Cột thông tin (8 cột) -->
                            <div class="col-8 post-details">
                                <div class="category">
                                    <c:forEach items="${requestScope.categories}" var="c">
                                        <c:if test="${c.categoryID == o.categoryID}">
                                            <a href="blog-category?cid=${c.categoryID}" class="category-link">${c.categoryName}</a>
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <div class="title">
                                    <a href="blog-detail?bid=${o.blogId}"><b>${o.title}</b></a>
                                </div>
                                <div class="brief-info">${o.briefInfo}</div>
                                <div class="read-more" style="color: #007bff">
                                    <a href="blog-detail?bid=${o.blogId}">[Read More]</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="banner" style="display: flex ;justify-content: center; align-items: center; align-content: center">
                <img src="assets/images/page-header-bg.jpg" alt="alt" style="max-height: 180px; max-width: 97%;"/>
            </div></c:if>
        <c:if test="${not empty requestScope.message}">
            <div style="margin-top: 25px;
                 margin-left: 65px;
                 margin-bottom: 12px"><b>ALL BLOGS</b> | ${requestScope.message}</div>
        </c:if>
        <c:if test="${empty requestScope.message}">
            <div style="margin-top: 25px;
                 margin-left: 65px;
                 margin-bottom: 12px"><b>ALL BLOGS</b></div>
        </c:if>
        <div class="container">
            <div class="latest-posts row">
                <c:forEach items="${requestScope.blogs}" var="o">
                    <div class="post-infor col-12 col-md-6 row"> <!-- col-12 cho màn hình nhỏ, col-md-6 cho màn hình lớn -->
                        <!-- Cột ảnh (4 cột) -->
                        <div class="col-4">
                            <a href="blog-detail?bid=${o.blogId}" class="post-image-link">
                                <img src="assets/images/blog/BlogImg/${o.blogImgUrl}" alt="alt" class="post-image"/>
                            </a>
                        </div>

                        <!-- Cột thông tin (8 cột) -->
                        <div class="col-8 post-details">
                            <div class="category">
                                <c:forEach items="${requestScope.categories}" var="c">
                                    <c:if test="${c.categoryID == o.categoryID}">
                                        <a href="blog-category?cid=${c.categoryID}" class="category-link">${c.categoryName}</a>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <div class="title">
                                <a href="blog-detail?bid=${o.blogId}"><b>${o.title}</b></a>
                            </div>
                            <div class="brief-info">${o.briefInfo}</div>
                            <div class="read-more" style="color: #007bff">
                                <a href="blog-detail?bid=${o.blogId}">[Read More]</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div style="height: 80px; color: black; display: flex; align-items: center; justify-content: center;">
            <nav aria-label="Page navigation">
                <c:if test="${requestScope.option == 1}">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${requestScope.endPage}" var="i">
                            <li class="page-item ${requestScope.tag == i ? 'active' : ''}">
                                <a class="page-link" href="blog-list?index=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${requestScope.option == 2}">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${requestScope.endPage}" var="i">
                            <li class="page-item ${requestScope.tag == i ? 'active' : ''}">
                                <a class="page-link" href="blog-category?index=${i}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${requestScope.option == 3}">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${requestScope.endPage}" var="i">
                            <li class="page-item ${requestScope.tag == i ? 'active' : ''}">
                                <a class="page-link" href="search?index=${i}&input=${param.input}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </nav>
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
        <script src="${pageContext.request.contextPath}/assets/js/jquery.appear.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
        <script>
                                document.getElementById('searchForm').addEventListener('submit', function (event) {
                                    var input = document.getElementById("searchInput").value.trim();

                                    if (input === "") {
                                        alert("Please enter a search term.");
                                        event.preventDefault();  // inform user when user input empty
                                    }
                                });

                                function submitForm(event) {
                                    var input = document.getElementById("searchInput").value.trim();

                                    if (input === "") {
                                        alert("Please enter a search term.");
                                        event.preventDefault();  // inform user when user input empty
                                    } else {
                                        document.getElementById("searchForm").submit();
                                    }
                                }
        </script>
    </body>
</html>
