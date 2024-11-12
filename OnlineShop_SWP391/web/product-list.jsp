<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">


    <!-- Mirrored from portotheme.com/html/porto_ecommerce/demo18-shop.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:13:09 GMT -->
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


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

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <!-- noUiSlider CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/nouislider@15.6.1/dist/nouislider.min.css">

        <!-- noUiSlider JS -->
        <script src="https://cdn.jsdelivr.net/npm/nouislider@15.6.1/dist/nouislider.min.js"></script>

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

            .custom-maga-sale-container {
                background-color: #fff; /* Nền trắng tinh */
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ để nổi trên nền */
            }

            .custom-maga-sale-container .widget-title {
                font-size: 1.8rem;
                font-weight: 700;
                color: #000; /* Màu đen cho chữ */
                margin-bottom: 15px;
                text-align: center;
                text-transform: uppercase;
                letter-spacing: 2px; /* Khoảng cách giữa các chữ */
                position: relative;
            }

            .custom-maga-sale-container .widget-title a {
                text-decoration: none;
                color: #000; /* Màu đen cho liên kết */
                display: inline-block;
                padding-bottom: 5px;
                border-bottom: 2px solid transparent;
                transition: color 0.3s ease, border-color 0.3s ease;
            }

            .custom-maga-sale-container .widget-title a:hover {
                color: #888888; /* Chuyển sang màu xám khi hover */
                border-bottom: 2px solid #888888; /* Gạch chân xám khi hover */
            }

            .custom-maga-sale-container .widget-title::after {
                content: '';
                position: absolute;
                width: 100px;
                height: 3px;
                background-color: #000; /* Gạch chân đen dưới tiêu đề */
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
            }

            .custom-maga-sale-container .widget-title:hover::after {
                width: 150px;
                transition: width 0.4s ease; /* Gạch chân dài ra khi hover */
            }

            /* Hiệu ứng đổ bóng chữ */
            .custom-maga-sale-container .widget-title a {
                text-shadow: 2px 2px 5px rgba(255, 255, 255, 0.3); /* Đổ bóng trắng nhẹ */
            }

            /* Styling cho hình ảnh và căn giữa ảnh */
            .mega-image {
                display: flex;
                justify-content: center; /* Căn giữa hình ảnh ngang */
                align-items: center; /* Căn giữa hình ảnh dọc */
                margin-bottom: 15px;
            }

            .mega-image img {
                max-width: 100%;
                border-radius: 8px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .mega-image img:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                filter: grayscale(0); /* Hình ảnh trở lại màu khi hover */
            }

            .mega-image a {
                display: block;
                width: 100%;
                max-width: 205px;
            }

            @media (max-width: 768px) {
                .custom-maga-sale-container {
                    padding: 10px;
                }

                .mega-image a {
                    max-width: 100%;
                }
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
    <!-- Main CSS File -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo18.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">
</head>

<body>
    <div class="page-wrapper">
        <jsp:include page="common/header.jsp"></jsp:include>

            <main class="main bg-gray" style="padding-top: 200px">


                <nav aria-label="breadcrumb" class="breadcrumb-nav mb-3">
                    <div class="container-fluid">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Shop</li>
                        </ol>
                    </div>
                </nav>

                <div class="container-fluid bg-gray">
                    <div class="row">
                        <div class="col-lg-9 main-content shop-content">
                            <nav class="toolbox sticky-header" data-sticky-options="{'mobile': true}">
                                <div class="toolbox-left">
                                    <a href="#" class="sidebar-toggle"><svg data-name="Layer 3" id="Layer_3"
                                                                            viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
                                        <line x1="15" x2="26" y1="9" y2="9" class="cls-1"></line>
                                        <line x1="6" x2="9" y1="9" y2="9" class="cls-1"></line>
                                        <line x1="23" x2="26" y1="16" y2="16" class="cls-1"></line>
                                        <line x1="6" x2="17" y1="16" y2="16" class="cls-1"></line>
                                        <line x1="17" x2="26" y1="23" y2="23" class="cls-1"></line>
                                        <line x1="6" x2="11" y1="23" y2="23" class="cls-1"></line>
                                        <path
                                            d="M14.5,8.92A2.6,2.6,0,0,1,12,11.5,2.6,2.6,0,0,1,9.5,8.92a2.5,2.5,0,0,1,5,0Z"
                                            class="cls-2"></path>
                                        <path d="M22.5,15.92a2.5,2.5,0,1,1-5,0,2.5,2.5,0,0,1,5,0Z" class="cls-2"></path>
                                        <path d="M21,16a1,1,0,1,1-2,0,1,1,0,0,1,2,0Z" class="cls-3"></path>
                                        <path
                                            d="M16.5,22.92A2.6,2.6,0,0,1,14,25.5a2.6,2.6,0,0,1-2.5-2.58,2.5,2.5,0,0,1,5,0Z"
                                            class="cls-2"></path>
                                        </svg>
                                        <span>Filter</span>
                                    </a>




                            </nav>



                            <div class="row product-ajax-grid mb-2">




                            <c:forEach items="${sessionScope.products}" var="lP">
                                <c:if test="${lP.status == 1}"><!-- Kiểm tra status ở đây -->
                                    <c:forEach items="${sessionScope.images}" var="i">
                                        <c:if test="${i.productID==lP.productID}">
                                            <c:if test="${lP.quantity > 0}">
                                                <div class="col-6 col-md-4 col-lg-3 col-xl-5col">
                                                    <div class="product-default inner-quickview inner-icon">

                                                        <div class="product-default">
                                                            <figure>
                                                                <a href="product-detail?productID=${lP.productID}">
                                                                    <img src="${i.productImgUrl}" width="205"
                                                                         height="205" alt="product">
                                                                </a>

                                                            </figure>
                                                            <div class="product-detail?productID=${lP.productID}" style="padding-left: 20px">
                                                                <c:if test="${not empty sessionScope.DiscountedProducts}">
                                                                    <div class="label-group">
                                                                        <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                            <c:if test="${pr.productID == lP.productID}">
                                                                                <div class="product-label label-hot">HOT</div>
                                                                                <div class="product-label label-sale">-${pr.discountRate}%</div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:if>
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
                                                                <c:set var="isDiscounted" value="false"/>
                                                                <c:forEach items="${sessionScope.DiscountedProducts}" var="pr">
                                                                    <c:if test="${pr.productID == lP.productID}">
                                                                        <c:set var="isDiscounted" value="true"/>
                                                                        <div class="price">
                                                                            <span class="old-price">
                                                                                <fmt:formatNumber value="${lP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                            <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                                <fmt:formatNumber value="${lP.price - (lP.price * pr.discountRate / 100)}" pattern="#,##0" currencySymbol="" />đ
                                                                            </span>
                                                                        </div>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${isDiscounted == false}">
                                                                    <div class="price">
                                                                        <span class="old-price">
                                                                            <fmt:formatNumber value="${lP.price + lP.price * 20 / 100}" pattern="#,##0" currencySymbol="" />đ
                                                                        </span>
                                                                        <span class="new-price" style="color: #c82333; font-weight: bold">
                                                                            <fmt:formatNumber value="${lP.price}" pattern="#,##0" currencySymbol="" />đ
                                                                        </span>
                                                                    </div>
                                                                </c:if>

                                                                <!-- End .price-box -->
                                                                <div class="product-container">
                                                                    <div class="product-action">
                                                                        <a href="wishlist.html" title="Wishlist" class="btn-icon-wish"><i class="icon-heart"></i></a>
                                                                        <a href="product-detail?productID=${lP.productID}" class="btn-icon btn-add-cart"><i class="fa fa-arrow-right"></i><span>VIEW DETAIL</span></a>

                                                                    </div>
                                                                    <a href="feedback.jsp"  title="Feedback" style="width: 40px; padding-left: 10px; padding-bottom: 20px"><i
                                                                            class=""><img src="assets/images/icons/feedback.png" alt="alt"/></i></a>
                                                                </div>


                                                            </div>
                                                            <!-- End .product-details -->
                                                        </div>  





                                                    </div>
                                                </div><!-- End .col-lg-3 -->
                                            </c:if>
                                            <c:if test="${lP.quantity <= 0}">
                                                <div class="col-6 col-md-4 col-lg-3 col-xl-5col">
                                                    <div class="product-default inner-quickview inner-icon">
                                                        <div class="product-default out-of-stock"> <!-- Thêm lớp out-of-stock -->
                                                            <figure>
                                                                <a href="product-detail?productID=${lP.productID}">
                                                                    <img src="${i.productImgUrl}" width="205" height="205" alt="product">
                                                                </a>
                                                            </figure>
                                                            <div class="product-details">
                                                                <c:forEach items="${sessionScope.categories}" var="c">
                                                                    <c:if test="${c.catID==lP.catID}">
                                                                        <div class="category-list">
                                                                            <a href="product-list" class="product-category"></a>
                                                                        </div>
                                                                        <h3 class="product-title">
                                                                            <a href="product-detail?productID=${lP.productID}">${lP.productName}</a>
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


                        </div><!-- End .row -->


                        <nav class="toolbox toolbox-pagination" style="display: flex; justify-content: center; align-items: center;">
                            <div style="height: 80px; color: black; display: flex; align-items: center; justify-content: center;">
                                <nav aria-label="Page navigation">
                                    <c:if test="${sessionScope.option == 1}">
                                        <ul class="pagination">
                                            <c:forEach begin="1" end="${sessionScope.endPage}" var="i">
                                                <li class="page-item ${sessionScope.tag == i ? 'active' : ''}">
                                                    <form action="product-list"  style="display: inline;">
                                                        <input type="hidden" name="index" value="${i}" />
                                                        <!-- Các tham số khác -->
                                                        <c:forEach var="catID" items="${sessionScope.selectedCatID}">
                                                            <input type="hidden" name="catID" value="${catID}" />
                                                        </c:forEach>
                                                        <c:forEach var="brandID" items="${sessionScope.selectedBrandID}">
                                                            <input type="hidden" name="brandID" value="${brandID}" />
                                                        </c:forEach>
                                                        <c:forEach var="priceRange" items="${sessionScope.selectedPriceRanges}">
                                                            <input type="hidden" name="priceRange" value="${priceRange}" />
                                                        </c:forEach>
                                                        <button type="submit" class="page-link">${i}</button>
                                                    </form>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                    <c:if test="${sessionScope.option == 2}">
                                        <ul class="pagination">
                                            <c:forEach begin="1" end="${sessionScope.endPage}" var="i">
                                                <li class="page-item ${sessionScope.tag == i ? 'active' : ''}">
                                                    <form action="CheckBox" method="post" style="display: inline;">
                                                        <input type="hidden" name="index" value="${i}" />
                                                        <c:forEach var="catID" items="${sessionScope.selectedCatID}">
                                                            <input type="hidden" name="catID" value="${catID}" />
                                                        </c:forEach>
                                                        <c:forEach var="brandID" items="${sessionScope.selectedBrandID}">
                                                            <input type="hidden" name="brandID" value="${brandID}" />
                                                        </c:forEach>
                                                        <c:forEach var="priceRange" items="${sessionScope.selectedPriceRanges}">
                                                            <input type="hidden" name="priceRange" value="${priceRange}" />
                                                        </c:forEach>
                                                        <button type="submit" class="page-link">${i}</button>
                                                    </form>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>

                                    <c:if test="${sessionScope.option == 3}">
                                        <ul class="pagination">
                                            <c:forEach begin="1" end="${sessionScope.endPage}" var="i">
                                                <li class="page-item ${sessionScope.tag == i ? 'active' : ''}">
                                                    <form action="SearchProduct" style="display: inline;">
                                                        <input type="hidden" name="index" value="${i}" />
                                                        <input type="hidden" name="name" value="${param.name}" />
                                                        <input type="hidden" name="catID" value="${param.catID}" />
                                                        <button type="submit" class="page-link">${i}</button>
                                                    </form>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </c:if>
                                </nav>
                            </div>
                        </nav>


                    </div><!-- End .col-lg-9 -->

                    <div class="sidebar-overlay"></div>
                    <aside class="sidebar-shop col-lg-3 order-lg-first mobile-sidebar">
                        <div class="sidebar-wrapper">
                            <form action="CheckBox" method="post">
                                <div class="widget">
                                    <h3 class="widget-title">
                                        <a data-toggle="collapse" href="#widget-body-2" role="button" aria-expanded="true"
                                           aria-controls="widget-body-2">Categories</a>
                                    </h3>

                                    <div class="collapse show" id="widget-body-2">
                                        <div class="widget-body">
                                            <ul class="cat-list">

                                                <c:set value="${sessionScope.categories}" var="c"/>

                                                <c:forEach begin="0" end="${c.size()-1}" var="i">
                                                    <input type="checkbox" name="catID" value="${c.get(i).getCatID()}"
                                                           ${sessionScope.cID[i]?"checked":""} />
                                                    ${c.get(i).getCatName()}
                                                    <br/>
                                                </c:forEach>
                                            </ul>
                                        </div><!-- End .widget-body -->
                                    </div><!-- End .collapse -->
                                </div><!-- End .widget -->

                                <div class="widget">
                                    <h3 class="widget-title">
                                        <a data-toggle="collapse" href="#widget-body-6" role="button" aria-expanded="true"
                                           aria-controls="widget-body-6">Brand</a>
                                    </h3>

                                    <div class="collapse show" id="widget-body-6">
                                        <div class="widget-body pb-0">
                                            <ul class="brand-list">

                                                <c:set value="${sessionScope.brands}" var="b"/>
                                                <c:forEach begin="0" end="${b.size()-1}" var="i">
                                                    <input type="checkbox" name="brandID" value="${b.get(i).getBrandID()}"
                                                           ${sessionScope.bID[i]?"checked":""} />
                                                    ${b.get(i).getBrandName()}
                                                    <br/>
                                                </c:forEach>
                                            </ul>
                                        </div><!-- End .widget-body -->
                                    </div><!-- End .collapse -->
                                </div>


                                <div class="widget">
                                    <h3 class="widget-title">
                                        <a data-toggle="collapse" href="#widget-body-3" role="button" aria-expanded="true"
                                           aria-controls="widget-body-3">Price</a>
                                    </h3>

                                    <div class="collapse show" id="widget-body-6">
                                        <div class="widget-body pb-0">
                                            <ul class="brand-list" >
                                                <%@ page import="java.util.Set" %>

                                                <input type="checkbox" id="price1" name="priceRange" value="0-500000"
                                                       <%= (session.getAttribute("selectedPriceRanges") != null 
                && ((Set<String>) session.getAttribute("selectedPriceRanges")).contains("0-500000")) ? "checked" : "" %>>
                                                <label style="font-weight: normal" for="price1">Giá dưới 500.000đ</label><br>

                                                <input type="checkbox" id="price2" name="priceRange" value="500000-1000000"
                                                       <%= (session.getAttribute("selectedPriceRanges") != null 
                && ((Set<String>) session.getAttribute("selectedPriceRanges")).contains("500000-1000000")) ? "checked" : "" %>>
                                                <label  style="font-weight: normal" for="price2">500.000đ - 1 triệu</label><br>

                                                <input type="checkbox" id="price3" name="priceRange" value="1000000-2000000"
                                                       <%= (session.getAttribute("selectedPriceRanges") != null 
                && ((Set<String>) session.getAttribute("selectedPriceRanges")).contains("1000000-2000000")) ? "checked" : "" %>>
                                                <label style="font-weight: normal" for="price3">1 - 2 triệu</label><br>

                                                <input type="checkbox" id="price4" name="priceRange" value="2000000-3000000"
                                                       <%= (session.getAttribute("selectedPriceRanges") != null 
                && ((Set<String>) session.getAttribute("selectedPriceRanges")).contains("2000000-3000000")) ? "checked" : "" %>>
                                                <label style="font-weight: normal" for="price4">2 - 3 triệu</label><br>

                                                <input type="checkbox" id="price5" name="priceRange" value="3000000-10000000"
                                                       <%= (session.getAttribute("selectedPriceRanges") != null 
                && ((Set<String>) session.getAttribute("selectedPriceRanges")).contains("3000000-10000000")) ? "checked" : "" %>>
                                                <label style="font-weight: normal" for="price5">Giá trên 3 triệu</label><br>
                                            </ul>



                                        </div><!-- End .widget-body -->
                                    </div><!-- End .collapse -->
                                </div>
                                <h3 class="widget-title">

                                </h3>

                                <div class="collapse show" id="widget-body-3">

                                </div><!-- End .collapse -->
                                <button type="submit" class="btn btn-primary font2">Filter</button>
                            </form>






                            <div class="widget">
                                <div class="maga-sale-container custom-maga-sale-container">
                                    <h3 class="widget-title">
                                        <a data-toggle="collapse" href="#widget-body-3" role="button" aria-expanded="true"
                                           aria-controls="widget-body-3">The Latest Product</a>
                                    </h3>
                                    <c:forEach items="${sessionScope.latest1Products}" var="l1">
                                        <c:forEach items="${sessionScope.images}" var="i">
                                            <c:if test="${i.productID==l1.productID}">
                                                <figure class="mega-image">
                                                    <a href="product-detail?productID=${l1.productID}">
                                                        <img src="${i.productImgUrl}" width="205"
                                                             height="205" alt="product">
                                                    </a>
                                                </figure>
                                            </c:if>
                                        </c:forEach>
                                    </c:forEach>


                                </div>
                            </div>


                        </div><!-- End .sidebar-wrapper -->
                    </aside><!-- End .col-lg-3 -->
                </div><!-- End .row -->
            </div><!-- End .container-fluid -->
        </main><!-- End .main -->

        <jsp:include page="common/footer.jsp"></jsp:include>
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
                        <li><a href="demo18.html">Home</a></li>
                        <li>
                            <a href="demo18-shop.html">Categories</a>
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
                            <a href="demo18-product.html">Products</a>
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
                        <li><a href="login.html">My Account</a></li>
                        <li><a href="demo18-contact.html">Contact Us</a></li>
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
                <a href="demo18.html">
                    <i class="icon-home"></i>Home
                </a>
            </div>
            <div class="sticky-info">
                <a href="demo18-shop.html" class="">
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
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/nouislider.min.js"></script>

    <!-- Main JS File -->
    <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>

</body>


<!-- Mirrored from portotheme.com/html/porto_ecommerce/demo18-shop.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Jun 2024 15:13:24 GMT -->
</html>
