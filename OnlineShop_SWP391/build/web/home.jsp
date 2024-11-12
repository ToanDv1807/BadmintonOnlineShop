

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/demo18.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:11:16 GMT -->
    <!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Badminton Shop</title>
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/logo.png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <meta name="keywords" content="HTML5 Template" />
        <meta name="description" content="Porto - Bootstrap eCommerce Template">
        <meta name="author" content="SW-THEMES">

        <!-- Favicon -->



        <script>
            WebFontConfig = {
                google: {
                    families: ['Open+Sans:300,400,600,700,800', 'Poppins:200,300,400,500,600,700,800', 'Oswald:300,400,500,600,700,800']
                }
            };
            (function (d) {
                var wf = d.createElement('script'),
                        s = d.scripts[0];
                wf.src = '${pageContext.request.contextPath}/assets/js/webfont.js';
                wf.async = true;
                s.parentNode.insertBefore(wf, s);
            })(document);
        </script>
        <style>
            .post-image {
                width: 100%;
                height: auto;
            }

            .post-details .title {
                font-size: 1.5em; /* Tăng kích thước tiêu đề */
            }

            .post-details .brief-info {
                font-size: 1.2em; /* Tăng kích thước mô tả */
            }
            .post-infor {
                border: 1px solid #ddd; /* Viền xám nhạt */
                border-radius: 10px; /* Bo tròn góc nhẹ */
                padding: 20px; /* Tạo khoảng cách bên trong */
                margin-bottom: 30px; /* Tạo khoảng cách giữa các bài viết */
                background-color: #f9f9f9; /* Nền xám nhạt */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* Bóng đổ nhẹ nhàng */
                transition: transform 0.2s ease, box-shadow 0.2s ease; /* Hiệu ứng chuyển động nhẹ */
            }

            .post-infor:hover {
                transform: translateY(-5px); /* Hiệu ứng nổi lên khi hover */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Tăng bóng đổ khi hover */
            }

            .post-image {
                width: 100%; /* Giữ nguyên kích thước hình ảnh */
                border-radius: 8px; /* Bo tròn nhẹ hình ảnh */
            }

            .post-details .title {
                color: #333; /* Màu xám đậm cho tiêu đề */
                font-size: 1.4em; /* Kích thước tiêu đề */
                margin-bottom: 10px;
            }

            .post-details .brief-info {
                color: #666; /* Màu xám nhạt cho thông tin tóm tắt */
                font-size: 1em; /* Kích thước nội dung tóm tắt */
                margin-bottom: 10px;
            }

            .read-more a {
                color: #007bff; /* Màu xanh đơn giản cho link Read More */
                text-decoration: none; /* Bỏ gạch chân */
            }

            .read-more a:hover {
                text-decoration: underline; /* Hiệu ứng gạch chân khi hover */
            }
            .latest-posts {
                display: flex;
                gap: 40px;
                flex-wrap: wrap;

                .hot-sale-products {
                    margin: 40px 0;
                }

                .hot-sale-products h2 {
                    font-size: 32px;
                    text-align: center;
                    text-transform: uppercase;
                    color: #333;
                    margin-bottom: 20px;
                }

            }
            .banner {
                position: relative;
                border-radius: 8px;
                overflow: hidden;
                transition: box-shadow 0.2s;
                margin-bottom: 20px; /* Space between banners */
            }

            .banner:hover {
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .banner img {
                width: 100%;
                height: auto;
            }

            .banner-layer {
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                padding: 10px;

                text-align: center;
            }

            .banner-layer h4 {
                margin: 0;
                font-size: 18px;
                font-weight: bold;
                color: #000;
            }

            .banner-layer h5 {
                margin: 5px 0 0;
                font-size: 16px;
                color: #d9534f; /* Sale color */
            }

            .btn-dark {
                display: inline-block;
                background-color: #007bff;
                color: white;
                padding: 8px 15px;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .btn-dark:hover {
                background-color: #0056b3; /* Darker shade on hover */
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .banner-layer {
                    padding: 15px;
                    display: flex; /* Sử dụng Flexbox để căn chỉnh */
                    flex-direction: column; /* Xếp dọc các phần tử */
                    justify-content: center; /* Căn giữa theo chiều dọc */
                    align-items: flex-start; /* Căn trái theo chiều ngang */
                    text-align: left; /* Căn trái văn bản */
                    height: 100%; /* Đảm bảo chiều cao đầy đủ */
                }

                .banner-layer h4 {
                    font-size: 16px;
                    margin-bottom: 5px; /* Thêm khoảng cách giữa h4 và h5 */
                }

                .banner-layer h5 {
                    font-size: 14px;
                    margin-top: 0; /* Đảm bảo không có khoảng cách phía trên */
                }

                .banner-layer a {
                    margin-top: 10px; /* Thêm khoảng cách cho nút */
                    align-self: stretch; /* Đảm bảo nút rộng toàn bộ chiều ngang */
                    text-align: center; /* Căn giữa nút */
                }
            }

            @media (max-width: 576px) {
                .banner-layer {
                    padding: 10px; /* Giảm khoảng cách padding */
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                    align-items: flex-start;
                    height: auto; /* Đảm bảo chiều cao tự động */
                }

                .banner-layer h4 {
                    font-size: 14px; /* Giảm kích thước chữ cho tiêu đề */
                    margin-bottom: 3px; /* Khoảng cách nhỏ hơn giữa các tiêu đề */
                }

                .banner-layer h5 {
                    font-size: 12px; /* Giảm kích thước chữ cho phụ đề */
                    margin-top: 0; /* Không có khoảng cách phía trên */
                }

                .banner-layer a {
                    margin-top: 5px; /* Giảm khoảng cách cho nút */
                    padding: 8px 12px; /* Điều chỉnh padding cho nút */
                    font-size: 12px; /* Kích thước chữ nhỏ hơn cho nút */
                }

                /* Đảm bảo hình ảnh banner không quá lớn */
                .banner img {
                    max-width: 100%; /* Hình ảnh chiếm toàn bộ chiều rộng */
                    height: auto; /* Giữ tỷ lệ hình ảnh */
                }
            }

            .price-box {
                margin-top: 10px; /* Khoảng cách phía trên của price-box */
            }

            .price {
                font-size: 20px; /* Kích thước chữ cho giá */
                font-weight: bold; /* Đậm chữ để nổi bật */
                color: #e74c3c; /* Màu sắc cho giá (đỏ tươi) */
                display: inline-block; /* Để có thể điều chỉnh thêm */
                padding: 5px; /* Padding xung quanh giá */
                border-radius: 3px; /* Bo góc nhẹ cho giá */
                background-color: #f9f9f9; /* Nền nhẹ cho giá */
            }









            .product-banner-section {
                padding-top: 210px; /* Điều chỉnh phần padding trên */
                background-color: black; /* Nền đen cho section */
            }

            .banner-carousel .banner {
                background-color: #111;
                padding: 10px;
                text-align: center;
            }

            .banner-carousel .banner img {
                max-width: 100%;
                height: auto;
                display: block;
            }

            .banner-thumbs {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .banner-thumbs .owl-dot {
                margin: 0 10px;
            }

            .banner-thumbs img {
                width: 80px;
                height: auto;
                border: 2px solid transparent;
                cursor: pointer;
                transition: border 0.3s;
            }

            .banner-thumbs img:hover {
                border-color: #fff;
            }

            .coming-soon {
                pointer-events: none; /* Ngăn tất cả các sự kiện chuột */
                opacity: 0.5; /* Làm mờ sản phẩm */
            }



        </style>

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo18.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">


    </head>

    <body>
        <div class="page-wrapper">
            <jsp:include page="common/header.jsp"></jsp:include>
                <!-- End .header -->

                <main class="main">







                    <div class="container-fluid">
                        <section class="product-banner-section">
                            <!-- Banner Carousel -->
                            <div class="banner-carousel owl-carousel with-dots-container" data-owl-options="{'nav': false}">
                                <!-- Lặp qua các sliders, chỉ hiển thị banner khi status == 1 -->
                            <c:forEach items="${sessionScope.sliders}" var="s">
                                <!-- Kiểm tra xem trạng thái của slider có bằng 1 hay không -->
                                <c:if test="${s.status == 1}">
                                    <div class="banner">
                                        <!-- Hình ảnh của banner sẽ có hiệu ứng animate với tên "fadeIn" -->
                                        <figure class="w-100 appear-animate" data-animation-name="fadeIn">
                                            <!-- Nếu backlink không rỗng, bọc hình ảnh trong thẻ <a> để tạo liên kết -->
                                            <c:if test="${!empty s.backlink}">
                                                <a href="${s.backlink}">
                                                    <img src="${pageContext.request.contextPath}/assets/images/product-section-slider/${s.sliderImgUrl}" alt="product banner">
                                                </a>
                                            </c:if>
                                            <c:if test="${empty s.backlink}">
                                                <img src="${pageContext.request.contextPath}/assets/images/product-section-slider/${s.sliderImgUrl}" alt="product banner">
                                            </c:if>

                                        </figure>
                                    </div>
                                </c:if>
                            </c:forEach>

                        </div>

                        <!-- Thumbnails (Thumbs) - Chỉ hiển thị khi status == 1 -->
                        <div class="banner-thumbs owl-dots">
                            <c:forEach items="${sessionScope.sliders}" var="s">
                                <c:if test="${s.status == 1}">
                                    <a href="${s.backlink}" class="owl-dot">
                                        <img src="${pageContext.request.contextPath}/assets/images/product-section-slider/${s.sliderImgUrl}" alt="Slide Thumb">
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                    </section>



                    <h1>${requestScope.error}
                    </h1>
                    <div class="product-default inner-quickview inner-icon coming-soon">
                        <div class="feature" style="margin-top: 120px">


                            <div class="container-fluid">
                                <h2 style="font-size: 30px" class="subtitle text-center text-uppercase mb-2 appear-animate" data-animation-name="fadeIn">
                                    Coming Soon Products 
                                </h2>

                                <div class="featured-products owl-carousel owl-theme show-nav-hover nav-outer nav-image-center mb-3 appear-animate" data-owl-options="{ 
                                     'dots': false, 
                                     'nav': true, 
                                     'margin': 20, 
                                     'responsive': {
                                     '992': {
                                     'items': 4
                                     },
                                     '1200': {
                                     'items': 6
                                     }
                                     } 
                                     }" data-animation-name="fadeIn">
                                    <c:forEach items="${sessionScope.comingSoonProducts}" var="fP">
                                        <c:if test="${fP.status == 1}"> <!-- Kiểm tra status ở đây -->
                                            <c:forEach items="${sessionScope.images}" var="i">
                                                <c:if test="${i.productID==fP.productID}">
                                                    <div class="product-default inner-quickview inner-icon">
                                                        <figure>
                                                            <a href="product-detail?productID=${fP.productID}">
                                                                <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                            </a>
                                                            <div class="btn-icon-group">
                                                                <a href="#" class="btn-icon btn-add-cart product-type-simple"><i class="icon-shopping-cart"></i></a>
                                                            </div>

                                                        </figure>
                                                        <div class="product-details">
                                                            <div class="category-wrap">
                                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                                    <c:if test="${c.catID==fP.catID}">
                                                                        <div class="category-list">
                                                                            <a href="product-list?catID=${c.catID}" class="product-category">${c.catName}</a>
                                                                        </div>

                                                                        <a href="wishlist.jsp" title="Wishlist" class="btn-icon-wish"><i class="icon-heart"></i></a>
                                                                    </div>
                                                                    <h3 class="product-title">
                                                                         <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                    </h3>

                                                                    <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                                        <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                            <c:if test="${pr.productID == fP.productID}">
                                                                                <div class="price">
                                                                                    <span class="old-price">
                                                                                        <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                                    </span>
                                                                                    <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                        <fmt:formatNumber value="${fP.price - (fP.price * pr.discountRate / 100)}" pattern="#,##0" currencySymbol="" />đ
                                                                                    </span>
                                                                                </div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </c:if>
                                                                    <c:if test="${empty sessionScope.DiscountedProducts}">
                                                                        <div class="price">
                                                                            <span class="old-price">
                                                                                <fmt:formatNumber value="${fP.price + fP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                            <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="ratings-container">
                                                                        <c:set var="found" value="false" />

                                                                        <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                            <c:if test="${listFP.productID == fP.productID}">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:${listFP.rated * 20}%"></span>
                                                                                    <!-- End .ratings -->
                                                                                    <span class="tooltiptext tooltip-top">${listFP.rated}/5</span>
                                                                                </div>
                                                                                <c:set var="found" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>

                                                                        <c:if test="${!found}">
                                                                            <div class="product-ratings">
                                                                                <span class="ratings" style="width:0%"></span>
                                                                                <!-- End .ratings -->
                                                                                <span class="tooltiptext tooltip-top">0/5</span>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:if> <!-- Kết thúc điều kiện kiểm tra status -->
                                    </c:forEach>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="feature" style="margin-top: 120px">


                        <div class="container-fluid">
                            <h2 style="font-size: 30px" class="subtitle text-center text-uppercase mb-2 appear-animate" data-animation-name="fadeIn">
                                Featured products 
                            </h2>

                            <div class="featured-products owl-carousel owl-theme show-nav-hover nav-outer nav-image-center mb-3 appear-animate" data-owl-options="{ 
                                 'dots': false, 
                                 'nav': true, 
                                 'margin': 20, 
                                 'responsive': {
                                 '992': {
                                 'items': 4
                                 },
                                 '1200': {
                                 'items': 6
                                 }
                                 } 
                                 }" data-animation-name="fadeIn">
                                <c:forEach items="${sessionScope.featureProducts}" var="fP">
                                    <c:if test="${fP.status == 1}"> <!-- Kiểm tra status ở đây -->
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==fP.productID}">
                                                <c:if test="${fP.quantity > 0}">
                                                    <div class="product-default inner-quickview inner-icon">

                                                        <figure>
                                                            <a href="product-detail?productID=${fP.productID}">
                                                                <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                            </a>
                                                            <div class="btn-icon-group">
                                                                <a href="#" class="btn-icon btn-add-cart product-type-simple"><i
                                                                        class="icon-shopping-cart"></i></a>
                                                            </div>

                                                        </figure>
                                                        <div class="product-details">
                                                            <div class="category-wrap">
                                                                <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                                    <div class="label-group">
                                                                        <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                            <c:if test="${pr.productID == fP.productID}">
                                                                                <div class="product-label label-hot">HOT</div>
                                                                                <div class="product-label label-sale">-${pr.discountRate}%</div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>
                                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                                    <c:if test="${c.catID==fP.catID}">
                                                                        <div class="category-list">
                                                                            <a href="product-list?catID=${c.catID}" class="product-category">${c.catName}</a>
                                                                        </div>

                                                                        <a href="wishlist.jsp" title="Wishlist" class="btn-icon-wish"><i
                                                                                class="icon-heart"></i></a>
                                                                    </div>
                                                                    <h3 class="product-title">
                                                                         <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                    </h3>
                                                                    <c:set var="isDiscounted" value="false"/>
                                                                    <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                        <c:if test="${pr.productID == fP.productID}">
                                                                            <c:set var="isDiscounted" value="true"/>
                                                                            <div class="price">
                                                                                <span class="old-price">
                                                                                    <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                                <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                    <fmt:formatNumber value="${fP.price - (fP.price * pr.discountRate / 100)}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:if test="${isDiscounted == false}">
                                                                        <div class="price">
                                                                            <span class="old-price">
                                                                                <fmt:formatNumber value="${fP.price + fP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                            <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="ratings-container">
                                                                        <c:set var="found" value="false" />

                                                                        <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                            <c:if test="${listFP.productID == fP.productID}">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:${listFP.rated * 20}%"></span>
                                                                                    <!-- End .ratings -->
                                                                                    <span class="tooltiptext tooltip-top">${listFP.rated}/5</span>
                                                                                </div>
                                                                                <c:set var="found" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>

                                                                        <c:if test="${!found}">
                                                                            <div class="product-ratings">
                                                                                <span class="ratings" style="width:0%"></span>
                                                                                <!-- End .ratings -->
                                                                                <span class="tooltiptext tooltip-top">0/5</span>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                            <!-- End .product-container -->

                                                            <!-- End .price-box -->
                                                        </div>
                                                        <!-- End .product-details -->
                                                    </div>

                                                </c:if>
                                                <c:if test="${fP.quantity <= 0}">
                                                    <div class="product-default inner-quickview inner-icon">
                                                        <div class="product-default inner-quickview inner-icon">
                                                            <div class="product-default out-of-stock"> <!-- Thêm lớp out-of-stock -->
                                                                <figure>
                                                                    <a href="product-detail?productID=${fP.productID}">
                                                                        <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                                    </a>
                                                                </figure>
                                                                <div class="product-details">
                                                                    <c:forEach items="${sessionScope.categories}" var="c">
                                                                        <c:if test="${c.catID==fP.catID}">
                                                                            <div class="category-list">
                                                                                <a href="product-list" class="product-category"></a>
                                                                            </div>
                                                                            <h3 class="product-title">
                                                                                <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                            </h3>
                                                                            <div class="ratings-container">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:80%"></span>
                                                                                    <span class="tooltiptext tooltip-top"></span>
                                                                                </div>
                                                                            </div>
                                                                            <h3 class="product-title" style="color: red">
                                                                                OUT OF STOCK
                                                                            </h3>    
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                                <!-- Thêm lớp overlay -->
                                                                <div class="overlay"></div>
                                                            </div>  
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </c:if> <!-- Kết thúc điều kiện kiểm tra status -->
                                </c:forEach>
                            </div>
                        </div>

                    </div>






                    <!--                ArcSarber 11 Pro-->


                    <div class="feature" style="margin-top: 120px">


                        <div class="container-fluid">
                            <h2 style="font-size: 30px" class="subtitle text-center text-uppercase mb-2 appear-animate" data-animation-name="fadeIn">
                                Best Selling Products 
                            </h2>

                            <div class="featured-products owl-carousel owl-theme show-nav-hover nav-outer nav-image-center mb-3 appear-animate" data-owl-options="{ 
                                 'dots': false, 
                                 'nav': true, 
                                 'margin': 20, 
                                 'responsive': {
                                 '992': {
                                 'items': 4
                                 },
                                 '1200': {
                                 'items': 6
                                 }
                                 } 
                                 }" data-animation-name="fadeIn">
                                <c:forEach items="${sessionScope.bestSelling}" var="fP">
                                    <c:if test="${fP.status == 1}"> <!-- Kiểm tra status ở đây -->
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==fP.productID}">
                                               <c:if test="${fP.quantity > 0}">
                                                    <div class="product-default inner-quickview inner-icon">

                                                        <figure>
                                                            <a href="product-detail?productID=${fP.productID}">
                                                                <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                            </a>
                                                            <div class="btn-icon-group">
                                                                <a href="#" class="btn-icon btn-add-cart product-type-simple"><i
                                                                        class="icon-shopping-cart"></i></a>
                                                            </div>

                                                        </figure>
                                                        <div class="product-details">
                                                            <div class="category-wrap">
                                                                <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                                    <div class="label-group">
                                                                        <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                            <c:if test="${pr.productID == fP.productID}">
                                                                                <div class="product-label label-hot">HOT</div>
                                                                                <div class="product-label label-sale">-${pr.discountRate}%</div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>
                                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                                    <c:if test="${c.catID==fP.catID}">
                                                                        <div class="category-list">
                                                                            <a href="product-list?catID=${c.catID}" class="product-category">${c.catName}</a>
                                                                        </div>

                                                                        <a href="wishlist.jsp" title="Wishlist" class="btn-icon-wish"><i
                                                                                class="icon-heart"></i></a>
                                                                    </div>
                                                                    <h3 class="product-title">
                                                                         <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                    </h3>
                                                                    <c:set var="isDiscounted" value="false"/>
                                                                    <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                        <c:if test="${pr.productID == fP.productID}">
                                                                            <c:set var="isDiscounted" value="true"/>
                                                                            <div class="price">
                                                                                <span class="old-price">
                                                                                    <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                                <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                    <fmt:formatNumber value="${fP.price - (fP.price * pr.discountRate / 100)}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:if test="${isDiscounted == false}">
                                                                        <div class="price">
                                                                            <span class="old-price">
                                                                                <fmt:formatNumber value="${fP.price + fP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                            <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="ratings-container">
                                                                        <c:set var="found" value="false" />

                                                                        <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                            <c:if test="${listFP.productID == fP.productID}">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:${listFP.rated * 20}%"></span>
                                                                                    <!-- End .ratings -->
                                                                                    <span class="tooltiptext tooltip-top">${listFP.rated}/5</span>
                                                                                </div>
                                                                                <c:set var="found" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>

                                                                        <c:if test="${!found}">
                                                                            <div class="product-ratings">
                                                                                <span class="ratings" style="width:0%"></span>
                                                                                <!-- End .ratings -->
                                                                                <span class="tooltiptext tooltip-top">0/5</span>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                            <!-- End .product-container -->

                                                            <!-- End .price-box -->
                                                        </div>
                                                        <!-- End .product-details -->
                                                    </div>

                                                </c:if>
                                                <c:if test="${fP.quantity <= 0}">
                                                    <div class="product-default inner-quickview inner-icon">
                                                        <div class="product-default inner-quickview inner-icon">
                                                            <div class="product-default out-of-stock"> <!-- Thêm lớp out-of-stock -->
                                                                <figure>
                                                                    <a href="product-detail?productID=${fP.productID}">
                                                                        <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                                    </a>
                                                                </figure>
                                                                <div class="product-details">
                                                                    <c:forEach items="${sessionScope.categories}" var="c">
                                                                        <c:if test="${c.catID==fP.catID}">
                                                                            <div class="category-list">
                                                                                <a href="product-list" class="product-category"></a>
                                                                            </div>
                                                                            <h3 class="product-title">
                                                                                <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                            </h3>
                                                                            <div class="ratings-container">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:80%"></span>
                                                                                    <span class="tooltiptext tooltip-top"></span>
                                                                                </div>
                                                                            </div>
                                                                            <h3 class="product-title" style="color: red">
                                                                                OUT OF STOCK
                                                                            </h3>    
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                                <!-- Thêm lớp overlay -->
                                                                <div class="overlay"></div>
                                                            </div>  
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </c:if> <!-- Kết thúc điều kiện kiểm tra status -->
                                </c:forEach>
                            </div>
                        </div>

                    </div>




                    <section class="product-slider-section bg-gray">
                        <div class="container-fluid">
                            <h2 style="font-size: 30px" class="subtitle text-center text-uppercase mb-2 appear-animate" data-animation-name="fadeIn">
                                NEW ARRIVALs </h2>

                            <div class="featured-products owl-carousel owl-theme show-nav-hover nav-outer nav-image-center mb-3 appear-animate" data-owl-options="{ 
                                 'dots': false, 
                                 'nav': true, 
                                 'margin': 20, 
                                 'responsive': {
                                 '992': {
                                 'items': 4
                                 },
                                 '1200': {
                                 'items': 6
                                 }
                                 } 
                                 }" data-animation-name="fadeIn">
                                <c:forEach items="${sessionScope.latestProducts}" var="fP">
                                    <c:if test="${fP.status == 1}"> 
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==fP.productID}">
                                                <c:if test="${fP.quantity > 0}">
                                                    <div class="product-default inner-quickview inner-icon">

                                                        <figure>
                                                            <a href="product-detail?productID=${fP.productID}">
                                                                <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                            </a>
                                                            <div class="btn-icon-group">
                                                                <a href="#" class="btn-icon btn-add-cart product-type-simple"><i
                                                                        class="icon-shopping-cart"></i></a>
                                                            </div>

                                                        </figure>
                                                        <div class="product-details">
                                                            <div class="category-wrap">
                                                                <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                                    <div class="label-group">
                                                                        <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                            <c:if test="${pr.productID == fP.productID}">
                                                                                <div class="product-label label-hot">HOT</div>
                                                                                <div class="product-label label-sale">-${pr.discountRate}%</div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>
                                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                                    <c:if test="${c.catID==fP.catID}">
                                                                        <div class="category-list">
                                                                            <a href="product-list?catID=${c.catID}" class="product-category">${c.catName}</a>
                                                                        </div>

                                                                        <a href="wishlist.jsp" title="Wishlist" class="btn-icon-wish"><i
                                                                                class="icon-heart"></i></a>
                                                                    </div>
                                                                    <h3 class="product-title">
                                                                         <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                    </h3>
                                                                    <c:set var="isDiscounted" value="false"/>
                                                                    <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                        <c:if test="${pr.productID == fP.productID}">
                                                                            <c:set var="isDiscounted" value="true"/>
                                                                            <div class="price">
                                                                                <span class="old-price">
                                                                                    <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                                <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                    <fmt:formatNumber value="${fP.price - (fP.price * pr.discountRate / 100)}" pattern="#,##0" currencySymbol="" />đ
                                                                                </span>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    <c:if test="${isDiscounted == false}">
                                                                        <div class="price">
                                                                            <span class="old-price">
                                                                                <fmt:formatNumber value="${fP.price + fP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                            <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                <fmt:formatNumber value="${fP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                        </div>
                                                                    </c:if>
                                                                    <div class="ratings-container">
                                                                        <c:set var="found" value="false" />

                                                                        <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                            <c:if test="${listFP.productID == fP.productID}">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:${listFP.rated * 20}%"></span>
                                                                                    <!-- End .ratings -->
                                                                                    <span class="tooltiptext tooltip-top">${listFP.rated}/5</span>
                                                                                </div>
                                                                                <c:set var="found" value="true" />
                                                                            </c:if>
                                                                        </c:forEach>

                                                                        <c:if test="${!found}">
                                                                            <div class="product-ratings">
                                                                                <span class="ratings" style="width:0%"></span>
                                                                                <!-- End .ratings -->
                                                                                <span class="tooltiptext tooltip-top">0/5</span>
                                                                            </div>
                                                                        </c:if>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                            <!-- End .product-container -->

                                                            <!-- End .price-box -->
                                                        </div>
                                                        <!-- End .product-details -->
                                                    </div>

                                                </c:if>
                                                <c:if test="${fP.quantity <= 0}">
                                                    <div class="product-default inner-quickview inner-icon">
                                                        <div class="product-default inner-quickview inner-icon">
                                                            <div class="product-default out-of-stock"> <!-- Thêm lớp out-of-stock -->
                                                                <figure>
                                                                    <a href="product-detail?productID=${fP.productID}">
                                                                        <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                                    </a>
                                                                </figure>
                                                                <div class="product-details">
                                                                    <c:forEach items="${sessionScope.categories}" var="c">
                                                                        <c:if test="${c.catID==fP.catID}">
                                                                            <div class="category-list">
                                                                                <a href="product-list" class="product-category"></a>
                                                                            </div>
                                                                            <h3 class="product-title">
                                                                                <a href="product-detail?productID=${fP.productID}">${fP.productName}</a>
                                                                            </h3>
                                                                            <div class="ratings-container">
                                                                                <div class="product-ratings">
                                                                                    <span class="ratings" style="width:80%"></span>
                                                                                    <span class="tooltiptext tooltip-top"></span>
                                                                                </div>
                                                                            </div>
                                                                            <h3 class="product-title" style="color: red">
                                                                                OUT OF STOCK
                                                                            </h3>    
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                                <!-- Thêm lớp overlay -->
                                                                <div class="overlay"></div>
                                                            </div>  
                                                        </div>
                                                    </div>
                                                </c:if>

                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>



                            </div>


                        </div>
                        <!-- End .featured-produts -->



                        <h2 style="font-size: 30px" class="subtitle text-center text-uppercase mb-2 appear-animate" data-animation-name="fadeIn">
                            Hot Posts</h2>
                        <div class="container" style="margin-bottom: 80px; ">
                            <div class="latest-posts row"  ">
                                <c:forEach items="${sessionScope.blogs}" var="o">
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








                </div>
                <!-- End .container-fluid -->
                </section>



                <jsp:include page="common/footer.jsp"></jsp:include>

                </main>
                <!-- End .main -->

            </div>

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
                            <li><a href="demo18.jsp">Home</a></li>
                            <li>
                                <a href="demo18-shop.jsp">Categories</a>
                                <ul>
                                    <li><a href="category.jsp">Full Width Banner</a></li>
                                    <li><a href="category-banner-boxed-slider.jsp">Boxed Slider Banner</a></li>
                                    <li><a href="category-banner-boxed-image.jsp">Boxed Image Banner</a></li>
                                    <li><a href="https://www.portotheme.com/html/porto_ecommerce/category-sidebar-left.jsp">Left Sidebar</a></li>
                                    <li><a href="category-sidebar-right.jsp">Right Sidebar</a></li>
                                    <li><a href="category-off-canvas.jsp">Off Canvas Filter</a></li>
                                    <li><a href="category-horizontal-filter1.jsp">Horizontal Filter 1</a></li>
                                    <li><a href="category-horizontal-filter2.jsp">Horizontal Filter 2</a></li>
                                    <li><a href="#">List Types</a></li>
                                    <li><a href="category-infinite-scroll.jsp">Ajax Infinite Scroll<span
                                                class="tip tip-new">New</span></a></li>
                                    <li><a href="category.jsp">3 Columns Products</a></li>
                                    <li><a href="category-4col.jsp">4 Columns Products</a></li>
                                    <li><a href="category-5col.jsp">5 Columns Products</a></li>
                                    <li><a href="category-6col.jsp">6 Columns Products</a></li>
                                    <li><a href="category-7col.jsp">7 Columns Products</a></li>
                                    <li><a href="category-8col.jsp">8 Columns Products</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="demo18-product.jsp">Products</a>
                                <ul>
                                    <li>
                                        <a href="#" class="nolink">PRODUCT PAGES</a>
                                        <ul>
                                            <li><a href="product.jsp">SIMPLE PRODUCT</a></li>
                                            <li><a href="product-variable.jsp">VARIABLE PRODUCT</a></li>
                                            <li><a href="product.jsp">SALE PRODUCT</a></li>
                                            <li><a href="product.jsp">FEATURED & ON SALE</a></li>
                                            <li><a href="product-sticky-info.jsp">WIDTH CUSTOM TAB</a></li>
                                            <li><a href="product-sidebar-left.jsp">WITH LEFT SIDEBAR</a></li>
                                            <li><a href="product-sidebar-right.jsp">WITH RIGHT SIDEBAR</a></li>
                                            <li><a href="product-addcart-sticky.jsp">ADD CART STICKY</a></li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="#" class="nolink">PRODUCT LAYOUTS</a>
                                        <ul>
                                            <li><a href="product-extended-layout.jsp">EXTENDED LAYOUT</a></li>
                                            <li><a href="product-grid-layout.jsp">GRID IMAGE</a></li>
                                            <li><a href="product-full-width.jsp">FULL WIDTH LAYOUT</a></li>
                                            <li><a href="product-sticky-info.jsp">STICKY INFO</a></li>
                                            <li><a href="product-sticky-both.jsp">LEFT & RIGHT STICKY</a></li>
                                            <li><a href="product-transparent-image.jsp">TRANSPARENT IMAGE</a></li>
                                            <li><a href="product-center-vertical.jsp">CENTER VERTICAL</a></li>
                                            <li><a href="#">BUILD YOUR OWN</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#">Account<span class="tip tip-hot">Hot!</span></a>
                                <ul>
                                    <li>
                                        <a href="wishlist.jsp">Wishlist</a>
                                    </li>
                                    <li>
                                        <a href="cart.jsp">Shopping Cart</a>
                                    </li>
                                    <li>
                                        <a href="checkout.jsp">Checkout</a>
                                    </li>



                                    <li>
                                        <a href="login">Login</a>
                                    </li>

                                    <li>
                                        <a href="forgot">Forgot Password</a>
                                    </li>


                                </ul>
                            </li>
                            <li><a href="blog.jsp">Blog</a></li>
                            <li>
                                <a href="#">Elements</a>
                                <ul class="custom-scrollbar">
                                    <li><a href="element-accordions.jsp">Accordion</a></li>
                                    <li><a href="element-alerts.jsp">Alerts</a></li>
                                    <li><a href="element-animations.jsp">Animations</a></li>
                                    <li><a href="element-banners.jsp">Banners</a></li>
                                    <li><a href="element-buttons.jsp">Buttons</a></li>
                                    <li><a href="element-call-to-action.jsp">Call to Action</a></li>
                                    <li><a href="element-countdown.jsp">Count Down</a></li>
                                    <li><a href="element-counters.jsp">Counters</a></li>
                                    <li><a href="element-headings.jsp">Headings</a></li>
                                    <li><a href="element-icons.jsp">Icons</a></li>
                                    <li><a href="element-info-box.jsp">Info box</a></li>
                                    <li><a href="element-posts.jsp">Posts</a></li>
                                    <li><a href="element-products.jsp">Products</a></li>
                                    <li><a href="element-product-categories.jsp">Product Categories</a></li>
                                    <li><a href="element-tabs.jsp">Tabs</a></li>
                                    <li><a href="element-testimonial.jsp">Testimonials</a></li>
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
                            <li><a href="login">My Account</a></li>
                            <li><a href="demo18-contact.jsp">Contact Us</a></li>
                            <li><a href="blog.jsp">Blog</a></li>
                            <li><a href="wishlist.jsp">My Wishlist</a></li>
                            <li><a href="cart.jsp">Cart</a></li>
                            <li><a href="login" class="login-link">Log In</a></li>
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
                    <a href="demo18.jsp">
                        <i class="icon-home"></i>Home
                    </a>
                </div>
                <div class="sticky-info">
                    <a href="demo18-shop.jsp" class="">
                        <i class="icon-bars"></i>Categories
                    </a>
                </div>
                <div class="sticky-info">
                    <a href="wishlist.jsp" class="">
                        <i class="icon-wishlist-2"></i>Wishlist
                    </a>
                </div>
                <div class="sticky-info">
                    <a href="login" class="">
                        <i class="icon-user-2"></i>Account
                    </a>
                </div>
                <div class="sticky-info">
                    <a href="cart.jsp" class="">
                        <i class="icon-shopping-cart position-relative">
                            <span class="cart-count badge-circle">3</span>
                        </i>Cart
                    </a>
                </div>
            </div>


            <!-- End .newsletter-popup -->

            <a id="scroll-top" href="#top" title="Top" role="button"><i class="icon-angle-up"></i></a>

            <!-- Plugins JS File -->
            <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/jquery.appear.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
        <script>
            $(document).ready(function () {
                var bannerCarousel = $('.banner-carousel');
                var bannerThumbs = $('.banner-thumbs');

                bannerCarousel.owlCarousel({
                    items: 1,
                    nav: false,
                    dots: false,
                    loop: true,
                    autoplay: true,
                    autoplayTimeout: 5000,
                    smartSpeed: 800
                });

                bannerThumbs.find('.owl-dot').on('click', function (e) {
                    e.preventDefault();
                    var index = $(this).index();
                    bannerCarousel.trigger('to.owl.carousel', [index, 300]);
                });
            });

        </script>
    </body>


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/demo18.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:12:27 GMT -->
</html>

