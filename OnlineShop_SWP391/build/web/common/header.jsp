<%-- 
    Document   : header
    Created on : Sep 27, 2024, 4:42:36 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header header-transparent"   >
    <div class="header-middle sticky-header" style="background-color: black">
        <div class="container-fluid">

            <div class="header-left">
                <button class="mobile-menu-toggler text-white mr-2" type="button">
                    <i class="fas fa-bars"></i>
                </button>
                <a href="home" class="logo">
                    <img src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" alt="Porto Logo">
                </a>
            </div>
            <!-- End .header-left -->




            <div class="header-center justify-content-between">
                <nav class="main-nav w-100">
                    <ul class="menu">
                        <li class="active">
                            <a href="home">Home</a>
                        </li>
                        <li>
                            <a href="product-list">Categories & Products</a>
                            <div class="megamenu megamenu-fixed-width megamenu-3cols-wide">
                                <div class="row">
                                    <!-- Iterate through the categories -->
                                    <c:forEach items="${sessionScope.categories}" var="c">
                                        <!-- Check if the category status is 1 -->
                                        <c:if test="${c.status == 1}">
                                            <div class="col-lg-4">
                                                <ul class="submenu">
                                                    <!-- Display the category title -->
                                                    <li>
                                                        <a href="product-list?catID=${c.catID}" class="category-title" style="font-size: 15px; color: black">
                                                            ${c.catName}
                                                        </a>
                                                    </li>

                                                    <!-- Iterate through the brands associated with this category -->
                                                    <c:forEach items="${sessionScope.brands}" var="b">
                                                        <li>
                                                            <a href="product-list?catID=${c.catID}&brandID=${b.brandID}" class="brand-title" style="font-size: 14px; color: gray">
                                                                ${c.catName} ${b.brandName}
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>

                        </li>
                        <li><a href="blog-list">Blogs</a></li>
                    </ul>
                </nav>
            </div>





            <div class="header-right justify-content-end">


                <!-- End .header-dropown -->


                <!-- End .header-dropown -->


                <!-- End .header-dropown -->

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
                            <li><a href="cart">Shopping Cart</a></li>
                                <c:choose>
                                    <c:when test="${listCartItem != null && !listCartItem.isEmpty()}">
                                    <li><a href="checkout">Checkout</a></li>
                                    </c:when>
                                    <c:otherwise>
                                    <li><a href="cart">Checkout</a></li>
                                    </c:otherwise>
                                </c:choose>

                            <c:if test="${a !=null}">
                                <li><a href="logout">Log out</a></li>
                                <li><a href="myOrder">My Orders</a></li>

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



                <!-- End .header-menu -->

                <!-- End .header-dropdowns -->



                <a href="wishlist" class="header-icon" title="Wishlist"><i class="icon-wishlist-2"><span
                            class="badge-circle"></span></i></a>

                <div class="header-icon header-search header-search-popup header-search-category text-right">
                    <a href="#" class="search-toggle" role="button"><i class="icon-magnifier"></i></a>
                    <form action="SearchProduct" method="get">
                        <div class="header-search-wrapper">
                            <input required="" type="search" class="form-control" name="name" id="name" placeholder="Search..." >
                            <div class="select-custom">
                                <select id="catID" name="catID">
                                    <option value="0">All Categories</option>


                                    <c:forEach items="${sessionScope.categories}" var="c">
                                        <option value="${c.catID}">${c.catName}</option>
                                    </c:forEach>





                                </select>
                            </div>
                            <!-- End .select-custom -->
                            <button class="btn icon-magnifier p-0" title="search" type="submit"></button>
                        </div>
                        <!-- End .header-search-wrapper -->
                    </form>
                </div>
                <!-- End .header-search -->

                <div class="dropdown cart-dropdown">
                    <a href="cart" title="Cart" class="dropdown-toggle dropdown-arrow cart-toggle" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-display="static">
                        <i class="minicart-icon"></i>
                        <span class="cart-count badge-circle"></span>
                    </a>

                    <div class="cart-overlay"></div>

                    <div class="dropdown-menu mobile-cart">
                        <a href="#" title="Close (Esc)" class="btn-close">×</a>

                        <div class="dropdownmenu-wrapper custom-scrollbar">
                            <div class="dropdown-cart-header">Shopping Cart</div>
                            <!-- End .dropdown-cart-header -->




                            <!-- End .dropdown-cart-total -->

                            <div class="dropdown-cart-action">
                                <a href="cart" class="btn btn-gray btn-block view-cart">View Cart</a>
                                <a href="checkout" class="btn btn-dark btn-block">Checkout</a>
                            </div>
                            <!-- End .dropdown-cart-total -->
                        </div>
                        <!-- End .dropdownmenu-wrapper -->
                    </div>
                    <!-- End .dropdown-menu -->
                </div>
                <!-- End .dropdown -->
            </div>
            <!-- End .header-right -->
        </div>
        <!-- End .container-fluid -->
        <!-- End .header-middle -->
    </div>

    <!-- End .header-middle -->
</header>



