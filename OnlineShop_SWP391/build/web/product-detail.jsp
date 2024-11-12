<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="en">


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/product.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:14:18 GMT -->
    <!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=UTF-8" /><!-- /Added by HTTrack -->
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Badminton Shop</title>

        <meta name="keywords" content="HTML5 Template" />
        <meta name="description" content="Porto - Bootstrap eCommerce Template">
        <meta name="author" content="SW-THEMES">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/R.png">

        <script>
            WebFontConfig = {
                google: {
                    families: ['Open+Sans:300,400,600,700,800', 'Poppins:300,400,500,600,700', 'Shadows+Into+Light:400']
                }
            };
            (function (d) {
                var wf = d.createElement('script'),
                        s = d.scripts[0];
                wf.src = 'assets/js/webfont.js';
                wf.async = true;
                s.parentNode.insertBefore(wf, s);
            })(document);
        </script>

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="assets/css/style.min.css">
        <link rel="stylesheet" type="text/css" href="assets/vendor/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>

            .product-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%; /* Bảo đảm container chiếm toàn bộ chiều rộng */
            }

            .product-action {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 20px; /* Khoảng cách giữa các nút */
            }

            .product-action a {
                text-align: center;
                display: inline-block;
            }

            .btn-add-cart {
                display: inline-block;
                background-color: #000; /* Màu nền cho nút */
                color: #fff; /* Màu chữ và icon */
                font-size: 16px; /* Kích thước chữ */
                padding: 10px 20px; /* Khoảng cách bên trong nút */
                border-radius: 5px; /* Bo góc nút */
                border: none; /* Xóa đường viền mặc định */

                text-decoration: none; /* Xóa gạch chân liên kết */

            }
            .error-message {
                color: #ff4d4f; /* Màu đỏ nhạt để nổi bật lỗi */
                background-color: #fff1f0; /* Nền đỏ nhạt cho rõ ràng */
                border: 1px solid #ffa39e; /* Đường viền đồng màu với nền */
                padding: 10px 15px; /* Khoảng cách bên trong để thông báo dễ nhìn */
                border-radius: 5px; /* Góc bo tròn cho mềm mại */
                font-size: 14px; /* Cỡ chữ vừa phải */
                font-weight: 500; /* Đậm nhẹ để dễ đọc */
                margin: 10px 0; /* Khoảng cách trên và dưới */
                display: inline-block; /* Cho phép căn chỉnh dễ dàng */
            }

            .error-message p {
                margin: 0; /* Loại bỏ khoảng cách của thẻ <p> */
            }



            .btn-add-cart i {
                margin-right: 10px; /* Khoảng cách giữa icon và text */
                font-size: 18px; /* Kích thước của icon */
                vertical-align: middle; /* Căn chỉnh icon với văn bản */
            }

            .btn-add-cart span {
                vertical-align: middle; /* Căn chỉnh văn bản với icon */
                font-weight: bold; /* Đậm chữ */
            }

            .product-single-gallery {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 20px 0; /* Thêm khoảng cách trên và dưới */
            }

            .product-slider-container {
                position: relative;
                width: 100%; /* Chiếm toàn bộ chiều rộng */
                max-width: 500px; /* Giới hạn chiều rộng tối đa */
            }

            .label-group {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 10px; /* Khoảng cách dưới nhãn sản phẩm */
            }

            .product-label {
                margin: 0 5px; /* Khoảng cách giữa các nhãn */
                padding: 5px 10px; /* Padding cho nhãn */
                border-radius: 5px; /* Bo tròn các góc */
                color: #fff; /* Màu chữ trắng */
            }

            .label-hot {
                background-color: red; /* Màu nền cho nhãn HOT */
            }

            .label-sale {
                background-color: green; /* Màu nền cho nhãn giảm giá */
            }

            .product-single-carousel {
                display: flex;
                overflow: hidden; /* Ẩn các phần tràn ra ngoài */
            }

            .product-item {
                min-width: 100%; /* Chiếm toàn bộ chiều rộng */
                transition: transform 0.3s ease; /* Hiệu ứng chuyển động mượt mà */
            }

            .product-single-image {
                width: 100%; /* Chiếm toàn bộ chiều rộng của phần item */
                height: auto; /* Tự động điều chỉnh chiều cao */
                border-radius: 5px; /* Bo tròn các góc của ảnh */
            }

            .prod-full-screen {
                position: absolute;
                top: 10px; /* Đưa lên một chút từ trên */
                right: 10px; /* Đưa sang phải một chút */
                cursor: pointer; /* Hiển thị con trỏ như tay khi hover */
            }

            .prod-thumbnail {
                display: flex;
                justify-content: center;
                margin-top: 10px; /* Khoảng cách trên giữa thumbnail và carousel */
            }

            .owl-dot {
                margin: 0 5px; /* Khoảng cách giữa các thumbnail */
                cursor: pointer; /* Hiển thị con trỏ như tay khi hover */
                transition: transform 0.3s; /* Hiệu ứng chuyển động mượt mà */
            }

            .owl-dot img {
                border-radius: 5px; /* Bo tròn các góc của ảnh thumbnail */
                width: 100%; /* Chiếm toàn bộ chiều rộng của ô dot */
            }

            .owl-dot:hover {
                transform: scale(1.1); /* Tăng kích thước khi hover */
            }

            /* Điều chỉnh cho các thiết bị di động */
            @media (max-width: 768px) {
                .product-single-gallery {
                    margin: 10px 0; /* Giảm khoảng cách trên và dưới cho thiết bị nhỏ */
                }

                .product-slider-container {
                    max-width: 100%; /* Chiếm toàn bộ chiều rộng trên thiết bị nhỏ */
                }
            }

            .product-single-container {
                display: flex; /* Dùng Flexbox để sắp xếp hình ảnh và chữ bên cạnh nhau */
                justify-content: space-between; /* Tạo khoảng cách giữa các phần */
                margin: 20px; /* Khoảng cách xung quanh */
            }

            .product-single-gallery {
                flex: 0 0 50%; /* Phần hình ảnh chiếm 50% chiều rộng */
                max-width: 50%; /* Đảm bảo phần hình ảnh không chiếm quá 50% */
            }

            .product-single-details {
                flex: 1; /* Phần chi tiết chiếm phần còn lại */
                padding-left: 20px; /* Khoảng cách giữa phần hình ảnh và chi tiết */
            }

            .product-title {
                font-size: 24px; /* Kích thước chữ tiêu đề sản phẩm */
                margin-bottom: 10px; /* Khoảng cách dưới tiêu đề */
            }

            .product-desc {
                margin-top: 10px; /* Khoảng cách trên phần mô tả */
                font-size: 14px; /* Kích thước chữ mô tả */
                line-height: 1.5; /* Khoảng cách giữa các dòng */
            }

            .price {
                margin: 10px 0; /* Khoảng cách trên và dưới cho phần giá */
                font-size: 18px; /* Kích thước chữ giá */
            }

            .old-price {
                text-decoration: line-through; /* Gạch ngang cho giá cũ */
                color: #999; /* Màu sắc cho giá cũ */
            }

            .new-price {
                color: #c82333; /* Màu sắc cho giá mới */
                font-weight: bold; /* In đậm giá mới */
            }

            .product-action {
                margin-top: 15px; /* Khoảng cách trên cho phần hành động */
            }

            .btn-icon {
                padding: 10px 15px; /* Padding cho các nút */
                border-radius: 5px; /* Bo tròn các góc của nút */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }

            .btn-icon:hover {
                background-color: #f0f0f0; /* Màu nền khi hover */
            }

            .product-default.out-of-stock {
                pointer-events: none; /* Ngăn tất cả các sự kiện chuột */
                opacity: 0.5; /* Làm mờ sản phẩm */
            }

            .product-default.out-of-stock .overlay {
                pointer-events: none; /* Ngăn tất cả các sự kiện chuột */
                opacity: 0.5; /* Làm mờ sản phẩm */
            }


        </style>
    </head>

    <body>
        <div class="page-wrapper">


            <jsp:include page="common/header.jsp"></jsp:include>
                <!-- End .header -->

                <main class="main"style=" padding-top: 200px">
                    <div class="container">
                        <nav aria-label="breadcrumb" class="breadcrumb-nav">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="home"><i class="icon-home"></i></a></li>
                                <li class="breadcrumb-item"><a href="product-list">Products</a></li>
                            </ol>
                        </nav>

                        <div class="product-single-container product-single-default">
                        <c:forEach items="${sessionScope.products}" var="p">
                            <c:if test="${sessionScope.productID_request == p.productID}">


                                <div class="row">
                                    <section class="product-single-gallery">
                                        <div class="product-slider-container">
                                            <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                <div class="label-group">
                                                    <div class="product-label label-hot">HOT</div>
                                                    <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                        <c:if test="${pr.productID == p.productID}">
                                                            <div class="product-label label-sale">-${pr.discountRate}%</div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <div class="product-single-carousel owl-carousel owl-theme show-nav-hover">
                                                <c:forEach items="${sessionScope.subImages}" var="si">
                                                    <c:if test="${sessionScope.productID_request == si.productID}">
                                                        <div class="product-item">
                                                            <img class="product-single-image" 
                                                                 src="${si.imgUrl}" 
                                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/products/default.png';" 
                                                                 data-zoom-image="${si.imgUrl}" 
                                                                 width="468" 
                                                                 height="468" 
                                                                 alt="product" />
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <!-- End .product-single-carousel -->
                                            <span class="prod-full-screen">
                                                <i class="icon-plus"></i>
                                            </span>
                                        </div>

                                        <div class="prod-thumbnail owl-dots">
                                            <c:forEach items="${sessionScope.subImages}" var="si">
                                                <c:if test="${sessionScope.productID_request == si.productID}">
                                                    <div class="owl-dot">
                                                        <img src="${si.imgUrl}" 
                                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/products/default.png';" 
                                                             width="110" height="110" alt="product-thumbnail" />
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </section>


                                    <!-- End .product-single-gallery -->

                                    <div class="col-lg-7 col-md-6 product-single-details">
                                        <h1 class="product-title">${p.productName}</h1>

                                        <div class="product-nav">
                                            <c:forEach items="${sessionScope.images}" var="i">
                                                <c:if test="${i.productID==p.productID-1}">
                                                    <div class="product-prev">
                                                        <a href="product-detail?productID=${p.productID-1}">
                                                            <span class="product-link"></span>
                                                            <span class="product-popup">
                                                                <span class="box-content">
                                                                    <img alt="product" width="150" height="150" src="${i.productImgUrl}" style="padding-top: 0px;">
                                                                    <span>${sessionScope.productPre.productName}</span>
                                                                </span>
                                                            </span>
                                                        </a>
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                            <c:forEach items="${sessionScope.images}" var="i">
                                                <c:if test="${i.productID==p.productID+1}">
                                                    <div class="product-next">
                                                        <a href="product-detail?productID=${p.productID+1}">
                                                            <span class="product-link"></span>
                                                            <span class="product-popup">
                                                                <span class="box-content">
                                                                    <img alt="product" width="150" height="150" src="${i.productImgUrl}" style="padding-top: 0px;">
                                                                    <span>${sessionScope.productAfter.productName}</span>
                                                                </span>
                                                            </span>
                                                        </a>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>

                                        <div class="ratings-container">
                                            <div class="product-ratings">
                                                <span class="ratings" style="width:${sessionScope.avgRating *20}%"></span>
                                                <span class="tooltiptext tooltip-top">${sessionScope.avgRating}/5</span>
                                            </div>
                                            <a href="#" class="rating-link">( ${sessionScope.countfb} Reviews )</a>
                                        </div>

                                        <hr class="short-divider">

                                        <c:set var="isDiscounted" value="false" />
                                        <c:set var="discountedPrice" value="${p.price}" />

                                        <!-- Check if DiscountedProducts list has discounts for this product -->
                                        <c:if test="${not empty sessionScope.DiscountedProducts}">
                                            <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                <c:if test="${pr.productID == p.productID}">
                                                    <c:set var="isDiscounted" value="true" />
                                                    <c:set var="discountedPrice" value="${p.price - (p.price * pr.discountRate / 100)}" />
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <!-- Display price depending on whether the product is discounted -->
                                        <div id="price-display" style="font-weight: bold; margin-top: 10px;">
                                            <c:choose>
                                                <c:when test="${isDiscounted}">
                                                    <span class="old-price" id="product-old-price">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" currencySymbol="" />đ
                                                    </span>
                                                    <span class="new-price" id="product-new-price" style="color: #c82333; font-weight: bold; display: inline-block;">
                                                        <fmt:formatNumber value="${discountedPrice}" pattern="#,##0" currencySymbol="" />đ
                                                    </span>
                                                    <br />
                                                    <div class="discount-label" style="
                                                         background-color: #ffcccb;
                                                         color: #c82333;
                                                         font-weight: bold;
                                                         margin-top: 2px; /* Adjusts spacing below the price */
                                                         padding: 5px 10px;
                                                         border-radius: 5px;
                                                         display: inline-block;">
                                                        Sales from ${sessionScope.promotion.startDate.substring(0, 10)} -> ${sessionScope.promotion.endDate.substring(0, 10)}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="old-price" id="product-old-price">
                                                        <fmt:formatNumber value="${p.price + p.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                    </span>
                                                    <span class="new-price" id="product-new-price" style="color: #c82333; font-weight: bold">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" currencySymbol="" />đ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="product-desc">
                                            <p>
                                                ${p.description}
                                            </p>
                                        </div>

                                        <c:if test="${not empty sessionScope.errorMessage}">
                                            <div class="alert alert-danger">
                                                ${sessionScope.errorMessage}
                                                <c:remove var="errorMessage" />
                                            </div>
                                        </c:if>

                                        <form action="addProduct" method="post">
                                            <c:if test="${not empty sessionScope.productAttributes}">
                                                <h5>Size:</h5>
                                                <div class="attribute-options">
                                                    <c:forEach items="${sizes}" var="size">
                                                        <c:forEach items="${sessionScope.productAttributes}" var="attribute">
                                                            <c:if test="${size.status == 1 && size.sizeID == attribute.sizeID}">
                                                                <div>
                                                                    <c:set var="available" value="${attribute.stock - attribute.hold}" />

                                                                    <!-- Default discount rate is set to 0% -->
                                                                    <c:set var="discountRate" value="0" />

                                                                    <!-- Loop through DiscountedSize to find a matching size ID -->
                                                                    <c:forEach items="${sessionScope.DiscountedSize}" var="discountedSize">
                                                                        <c:if test="${discountedSize.sizeID == size.sizeID && discountedSize.productID == attribute.productID}">
                                                                            <c:set var="discountRate" value="${discountedSize.discountRate}" />
                                                                        </c:if>
                                                                    </c:forEach>

                                                                    <input type="radio" id="size_${size.sizeID}" name="size" value="${size.sizeID}" required=""
                                                                           data-price="${attribute.price}" 
                                                                           data-discount="${discountRate}" 
                                                                           <c:if test="${available <= 0}">disabled</c:if>
                                                                               onclick="updatePrice(this)" />
                                                                           <!-- Debug output for validation -->
                                                                           <label for="size_${size.sizeID}">${size.sizeName}</label>

                                                                    <!-- Display stock information based on availability -->
                                                                    <c:if test="${available <= 0}">
                                                                        <span style="color: red;">(Out of stock)</span>
                                                                    </c:if>
                                                                    <c:if test="${available > 0}">
                                                                        <span style="color: green;">(Available: ${available})</span>
                                                                    </c:if>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <ul class="single-info-list">
                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                    <c:if test="${p.catID == c.catID}">
                                                        <li>
                                                            CATEGORY:
                                                            <strong>
                                                                <a href="product-list?catID=${c.catID}" class="product-category">${c.catName}</a>
                                                            </strong>
                                                        </li>

                                                        <c:forEach items="${sessionScope.brands}" var="b">
                                                            <c:if test="${p.brandID == b.brandID}">
                                                                <li>
                                                                    TAGs:
                                                                    <strong>
                                                                        <a href="product-list?catID=${c.catID}&brandID=${b.brandID}" class="product-category">${c.catName} ${b.brandName}</a>
                                                                    </strong>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>

                                            <div class="product-action">
                                                <input type="hidden" name="id" value="${productID_request}">
                                                <div class="product-single-qty">
                                                    <input class="horizontal-quantity form-control" type="number" name="stock" min="1" required="" placeholder="Enter quantity">
                                                </div>



                                                <c:if test="${sessionScope.c == null}">
                                                    <a href="login.jsp" class="btn-icon btn-add-cart"><span>ADD TO CART</span></a>
                                                </c:if>

                                                <c:if test="${sessionScope.c != null}">
                                                    <button type="submit" class="btn btn-dark add-cart icon-shopping-cart mr-2" title="Add to Cart" onclick="return this.closest('form').submit();">
                                                        Add to Cart
                                                    </button>
                                                </c:if>

                                                <a href="cart" class="btn btn-gray view-cart d-none">View cart</a>
                                            </div>
                                        </form>
                                        <p class="error-message">${errorMessageSize}</p>
                                        <hr class="divider mb-0 mt-0">

                                        <div class="product-single-share mb-3">
                                            <label class="sr-only">Share:</label>

                                            <div class="social-icons mr-2">
                                                <a href="#" class="social-icon social-facebook icon-facebook" target="_blank" title="Facebook"></a>
                                                <a href="#" class="social-icon social-twitter icon-twitter" target="_blank" title="Twitter"></a>
                                                <a href="#" class="social-icon social-linkedin fab fa-linkedin-in" target="_blank" title="Linkedin"></a>
                                                <a href="#" class="social-icon social-gplus fab fa-google-plus-g" target="_blank" title="Google +"></a>
                                                <a href="#" class="social-icon social-mail icon-mail-alt" target="_blank" title="Mail"></a>
                                            </div>
                                            <!-- End .social-icons -->

                                            <a href="wishlist.html" class="btn-icon-wish add-wishlist" title="Add to Wishlist"><i class="icon-wishlist-2"></i><span>Add to Wishlist</span></a>
                                        </div>
                                        <!-- End .product single-share -->
                                    </div>

                                    <!-- End .product-single-details -->
                                </div>


                                <!-- End .row -->
                            </div>
                            <!-- End .product-single-container -->

                            <div class="product-single-tabs">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="product-tab-desc" data-toggle="tab" href="#product-desc-content" role="tab" aria-controls="product-desc-content" aria-selected="true">Description</a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link" id="product-tab-size" data-toggle="tab" href="#product-size-content" role="tab" aria-controls="product-size-content" aria-selected="true">Size Guide</a>
                                    </li>



                                    <li class="nav-item">
                                        <a class="nav-link" id="product-tab-reviews" data-toggle="tab" href="#product-reviews-content" role="tab" aria-controls="product-reviews-content" aria-selected="false">Reviews (${sessionScope.countfb})</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="product-desc-content" role="tabpanel" aria-labelledby="product-tab-desc">
                                        <div class="product-desc-content">
                                            <p>${p.description}</p>


                                        </div>
                                        <!-- End .product-desc-content -->
                                    </div>
                                    <!-- End .tab-pane -->

                                    <div class="tab-pane fade" id="product-size-content" role="tabpanel" aria-labelledby="product-tab-size">
                                        <div class="product-size-content">
                                            <c:forEach items="${sessionScope.categories}" var="c">
                                                <c:if test="${c.catID==p.catID }">


                                                    <img src="${pageContext.request.contextPath}/assets/images/products/${c.url_size_guide}" alt="body shape" >

                                                    <!-- End .col-md-4 -->
                                                </c:if>


                                            </c:forEach>
                                            <!-- End .row -->
                                        </div>
                                        <!-- End .product-size-content -->
                                    </div>
                                    <!-- End .tab-pane -->


                                    <!-- End .tab-pane -->

                                    <div class="tab-pane fade" id="product-reviews-content" role="tabpanel" aria-labelledby="product-tab-reviews">
                                        <div class="product-reviews-content">
                                            <c:forEach items="${sessionScope.listf}" var="listf">
                                                <div class="comment-list">
                                                    <div class="comments">
                                                        <figure class="img-thumbnail">
                                                            <img src="assets/images/blog/author.jpg" alt="author" width="80" height="80">
                                                        </figure>

                                                        <div class="comment-block">
                                                            <div class="comment-header">
                                                                <div class="comment-arrow"></div>

                                                                <div class="ratings-container float-sm-right">
                                                                    <div class="product-ratings">
                                                                        <span class="ratings" style="width:${listf.rated*20}%"></span>
                                                                        <!-- End .ratings -->
                                                                        <span class="tooltiptext tooltip-top">${listf.rated}/5</span>
                                                                    </div>
                                                                    <!-- End .product-ratings -->
                                                                </div>

                                                                <span class="comment-by">
                                                                    <strong>${listf.customerName}/</strong>  ${listf.feedbackDate} <br>
                                                                    <strong>Size: ${listf.attributeValue}</strong>
                                                                </span>
                                                            </div>

                                                            <div class="comment-content">
                                                                <p>${listf.content}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <div class="divider"></div>

                                        </div>
                                        <!-- End .tab-pane -->
                                    </div>
                                    <!-- End .tab-content -->
                                </div>
                                <!-- End .product-single-tabs -->
                            </c:if>
                        </c:forEach>





                        <div class="products-section pt-0">
                            <h2 class="section-title">Related Products</h2>

                            <div class="products-slider owl-carousel owl-theme dots-top dots-small">
                                <c:forEach items="${sessionScope.listProbyID}" var="lP">
                                    <c:forEach items="${sessionScope.images}" var="i">
                                        <c:if test="${i.productID==lP.productID}">
                                            <c:if test="${lP.quantity > 0}">
                                                <div class="product-default">
                                                    <figure>
                                                        <a href="product-detail?productID=${lP.productID}">
                                                            <img src="${i.productImgUrl}" width="205"
                                                                 height="205" alt="product">
                                                        </a>


                                                    </figure>
                                                    <div class="label-group">

                                                        <%--
                                                        <div class="product-label label-hot">HOT</div>
                                                        <c:forEach items="${promotions}" var="pr">
                                                            <c:if test="${pr.productID == lP.productID}">
                                                                <div class="product-label label-sale">-${pr.discountPercentage}%</div>
                                                            </c:if>
                                                        </c:forEach>
                                                        --%>
                                                    </div>
                                                    <div class="product-detail?productID=${lP.productID}" style="padding-left: 20px">
                                                        <c:forEach items="${sessionScope.categories}" var="c">
                                                            <c:if test="${c.catID==lP.catID}">
                                                                <div class="category-list">
                                                                    <a href="product-list" class="product-category">${c.catName}</a>
                                                                </div>

                                                            </c:if>
                                                        </c:forEach>
                                                        <h3 class="product-title">
                                                            <a href="product-detail">${lP.productName}</a>
                                                        </h3>
                                                        <div class="ratings-container">
                                                            <div class="product-ratings">
                                                                <span class="ratings" style="width:80%"></span>
                                                                <!-- End .ratings -->
                                                                <span class="tooltiptext tooltip-top"></span>
                                                            </div>
                                                            <!-- End .product-ratings -->
                                                        </div>
                                                        <!-- End .product-container -->

                                                        <div class="price-box">
                                                            <span class="old-price" id="product-old-price">
                                                                <fmt:formatNumber value="${lP.price + lP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                            </span>
                                                            <span class="new-price" id="product-new-price" style="color: #c82333; font-weight: bold">
                                                                <fmt:formatNumber value="${lP.price}" pattern="#,##0" currencySymbol="" />đ
                                                            </span>
                                                        </div>

                                                        <!-- End .price-box -->



                                                    </div>
                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>
                                            <c:if test="${lP.quantity <= 0}">
                                                <div class="product-default out-of-stock">
                                                    <figure>
                                                        <a href="product-detail?productID=${lP.productID}">
                                                            <img src="${i.productImgUrl}" width="205"
                                                                 height="205" alt="product">
                                                        </a>


                                                    </figure>
                                                    <div class="label-group">

                                                        <%--
                                                        <div class="product-label label-hot">HOT</div>
                                                        <c:forEach items="${promotions}" var="pr">
                                                            <c:if test="${pr.productID == lP.productID}">
                                                                <div class="product-label label-sale">-${pr.discountPercentage}%</div>
                                                            </c:if>
                                                        </c:forEach>
                                                        --%>
                                                    </div>
                                                    <div class="product-detail?productID=${lP.productID}" style="padding-left: 20px">
                                                        <c:forEach items="${sessionScope.categories}" var="c">
                                                            <c:if test="${c.catID==lP.catID}">
                                                                <div class="category-list">
                                                                    <a href="product-list" class="product-category">${c.catName}</a>
                                                                </div>

                                                            </c:if>
                                                        </c:forEach>
                                                        <h3 class="product-title">
                                                            <a href="product-detail">${lP.productName}</a>
                                                        </h3>
                                                        <div class="ratings-container">
                                                            <div class="product-ratings">
                                                                <span class="ratings" style="width:80%"></span>
                                                                <!-- End .ratings -->
                                                                <span class="tooltiptext tooltip-top"></span>
                                                            </div>
                                                            <!-- End .product-ratings -->
                                                        </div>
                                                        <!-- End .product-container -->
                                                        <h3 class="product-title" style="color: red">
                                                            OUT OF STOCK
                                                        </h3>
                                                        <!-- End .price-box -->



                                                    </div>
                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>

                                        </c:if>
                                    </c:forEach>

                                </c:forEach>





                                <!-- End .products-slider -->
                            </div>
                            <!-- End .products-section -->

                            <hr class="mt-0 m-b-5" />

                            <div class="product-widgets-container row pb-2">
                                <div class="col-lg-3 col-sm-6 pb-5 pb-md-0">
                                    <h4 class="section-sub-title">Featured Products</h4>
                                    <c:forEach items="${sessionScope.featureProducts}" var="fP" begin="0" end="2">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==fP.productID}">
                                                <div class="product-default left-details product-widget">
                                                    <figure>
                                                        <a href="product-detail?productID=${fP.productID}">
                                                            <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                        </a>
                                                    </figure>

                                                    <div class="product-details">
                                                        <div class="category-wrap">
                                                            <%--
                                                                                                                  <div class="label-group">
                                                            
                                                            
                                                                                                                        <div class="product-label label-hot">HOT</div>
                                                            <c:forEach items="${promotions}" var="pr">
                                                                <c:if test="${pr.productID == fP.productID}">
                                                                    <div class="product-label label-sale">-${pr.discountPercentage}%</div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                            --%>
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
                                                                <%--
                                                            <c:forEach items="${sessionScope.promotions}" var="pr">
                                                                <c:if test="${pr.productID == fP.productID}">
                                                                    <div class="price">
                                                                        <span class="old-price">${fP.price}đ</span>
                                                                        <span class="new-price" style="color: #c82333">${fP.price-(fP.price*pr.discountPercentage/100)}đ</span>
                                                                    </div>
                                                                </c:if>

                                                                </c:forEach>
                                                                --%>
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

                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>


                                </div>




                                <div class="col-lg-3 col-sm-6 pb-5 pb-md-0">
                                    <h4 class="section-sub-title">Best Selling Products</h4>
                                    <c:forEach items="${sessionScope.list3BestSelling}" var="bs" begin="0" end="2">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==bs.productID}">
                                                <div class="product-default left-details product-widget">
                                                    <figure>
                                                        <a href="product-detail?productID=${bs.productID}">
                                                            <img src="${i.productImgUrl}" width="205"
                                                                 height="205" alt="product">
                                                        </a>
                                                    </figure>

                                                    <div class="product-details">
                                                        <h3 class="product-title">
                                                            <a href="product-detail?productID=${bs.productID}">${bs.productName}</a>
                                                        </h3>

                                                        <div class="ratings-container">
                                                            <c:set var="found" value="false" />

                                                            <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                <c:if test="${listFP.productID == bs.productID}">
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
                                                        <!-- End .product-container -->

                                                        <c:set var="hasPromotion" value="false" />


                                                        <!-- End .product-container -->

                                                        <!-- End .price-box -->
                                                    </div>
                                                    <!-- End .product-details -->

                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>


                                </div>

                                <div class="col-lg-3 col-sm-6 pb-5 pb-md-0">

                                    <h4 class="section-sub-title">Latest Products</h4>
                                    <c:forEach items="${sessionScope.latest3Products}" var="l3"  begin="0" end="2">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==l3.productID}">
                                                <div class="product-default left-details product-widget">
                                                    <figure>
                                                        <a href="product-detail?productID=${l3.productID}">
                                                            <img src="${i.productImgUrl}" width="205"
                                                                 height="205" alt="product">
                                                        </a>
                                                    </figure>

                                                    <div class="product-details">
                                                        <h3 class="product-title">
                                                            <a href="product-detail?productID=${l3.productID}">${l3.productName}</a>
                                                        </h3>

                                                        <div class="ratings-container">
                                                            <c:set var="found" value="false" />

                                                            <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                <c:if test="${listFP.productID == l3.productID}">
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
                                                        <!-- End .product-container -->
                                                        <%--
                                                        <c:set var="hasPromotion" value="false" />

                                                        <!-- Kiểm tra có khuyến mãi không -->
                                                        <c:forEach items="${sessionScope.promotions}" var="pr">
                                                            <c:if test="${pr.productID == l3.productID}">
                                                                <c:set var="hasPromotion" value="true" />
                                                                <div class="price-box">
                                                                    <span class="new-price" style="color: #c82333">
                                                                        ${l3.price - (l3.price * pr.discountPercentage / 100)}đ
                                                                    </span>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                        --%>
                                                        <!-- Nếu không có khuyến mãi -->
                                                        <%--
                                                        <c:if test="${!hasPromotion}">
                                                            <div class="price-box">
                                                                <span class="new-price" style="color: #c82333">${l3.price}đ</span>
                                                            </div>
                                                        </c:if>
                                                        --%>
                                                        <!-- End .price-box -->
                                                        <!-- End .price-box -->
                                                    </div>
                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </div>

                                <div class="col-lg-3 col-sm-6 pb-5 pb-md-0">
                                    <h4 class="section-sub-title">Top Rated Products</h4>
                                    <c:forEach items="${sessionScope.listTop3Rated}" var="l3"  begin="0" end="2">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==l3.productID}">
                                                <div class="product-default left-details product-widget">
                                                    <figure>
                                                        <a href="product-detail?productID=${l3.productID}">
                                                            <img src="${i.productImgUrl}" width="205"
                                                                 height="205" alt="product">
                                                        </a>
                                                    </figure>

                                                    <div class="product-details">
                                                        <h3 class="product-title">
                                                            <a href="product-detail?productID=${l3.productID}">${l3.productName}</a>
                                                        </h3>

                                                        <div class="ratings-container">
                                                            <c:set var="found" value="false" />

                                                            <c:forEach items="${sessionScope.listFP}" var="listFP">
                                                                <c:if test="${listFP.productID == l3.productID}">
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
                                                        <!-- End .product-container -->
                                                        <%--
                                                        <c:set var="hasPromotion" value="false" />

                                                        <!-- Kiểm tra có khuyến mãi không -->
                                                        <c:forEach items="${sessionScope.promotions}" var="pr">
                                                            <c:if test="${pr.productID == l3.productID}">
                                                                <c:set var="hasPromotion" value="true" />
                                                                <div class="price-box">
                                                                    <span class="new-price" style="color: #c82333">
                                                                        ${l3.price - (l3.price * pr.discountPercentage / 100)}đ
                                                                    </span>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                        --%>
                                                        <!-- Nếu không có khuyến mãi -->
                                                        <%--
                                                        <c:if test="${!hasPromotion}">
                                                        --%>
                                                        <div class="price-box">
                                                            <span class="new-price" style="color: #c82333">${l3.price}đ</span>
                                                        </div>
                                                        <%--
                                                </c:if>
                                                        --%>
                                                        <!-- End .price-box -->
                                                    </div>
                                                    <!-- End .product-details -->
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>
                                </div>
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
                                                        <span class="contact-info-label">Email:</span> <a href="https://portotheme.com/cdn-cgi/l/email-protection#2548444c4965405d44485549400b464a48"><span class="__cf_email__" data-cfemail="204d41494c604558414d504c450e434f4d">[email&#160;protected]</span></a>
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
                                                <span class="payment-icon visa" style="background-image: url(assets/images/payments/payment-visa.svg)"></span>
                                                <span class="payment-icon paypal" style="background-image: url(assets/images/payments/payment-paypal.svg)"></span>
                                                <span class="payment-icon stripe" style="background-image: url(assets/images/payments/payment-stripe.png)"></span>
                                                <span class="payment-icon verisign" style="background-image:  url(assets/images/payments/payment-verisign.svg)"></span>
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
                    <script data-cfasync="false" src="../../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script src="assets/js/jquery.min.js"></script>
                    <script src="assets/js/bootstrap.bundle.min.js"></script>
                    <script src="assets/js/plugins.min.js"></script>

                    <!-- Main JS File -->
                    <script src="assets/js/main.min.js"></script>


                    <script>
                                                        function updatePrice(selectedSize) {
                                                            // Lấy giá và tỷ lệ giảm giá từ thuộc tính data-price và data-discount
                                                            var price = parseFloat(selectedSize.getAttribute('data-price')) || 0;
                                                            var discountPercentage = parseFloat(selectedSize.getAttribute('data-discount')) || 0;

                                                            // Tính toán giá cũ và giá mới sau khi giảm giá
                                                            var oldPrice = price * 1.2; // Giá cũ là giá tăng thêm 20%
                                                            var newPrice = discountPercentage > 0 ? price - (price * discountPercentage / 100) : price;

                                                            // Kiểm tra nếu có id cho giá cũ và giá mới
                                                            var oldPriceElement = document.getElementById('product-old-price');
                                                            var newPriceElement = document.getElementById('product-new-price');

                                                            if (oldPriceElement) {
                                                                oldPriceElement.textContent = oldPrice.toLocaleString('en-US') + 'đ';
                                                            }

                                                            if (newPriceElement) {
                                                                newPriceElement.textContent = newPrice.toLocaleString('en-US') + 'đ';
                                                            }
                                                        }
                    </script>
                    </body>


                    <!-- Mirrored from portotheme.com/html/porto_ecommerce/product.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:14:27 GMT -->
                    </html>




