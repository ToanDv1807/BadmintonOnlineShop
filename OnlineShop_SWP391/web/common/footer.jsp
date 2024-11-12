<%-- 
    Document   : footer
    Created on : Sep 27, 2024, 5:05:57 PM
    Author     : Acer
--%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Badminton Shop</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/logo.png">
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


    <!-- Plugins CSS File -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

    <!-- Main CSS File -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/demo18.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">


</head>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<body>
    <footer>
        <section class="explore-section d-flex align-items-center" data-parallax="{'speed': 1.8,  'enableOnMobile': true}" data-image-src="${pageContext.request.contextPath}/assets/images/bg-2.jpg" style="background-color: #111;">
            <div class="container-fluid text-center position-relative appear-animate" data-animation-name="fadeInUpShorter">
                <h3 class="line-height-1 ls-n-25 text-white text-uppercase m-b-4">Explore the best of you</h3>
                <a href="demo18-shop.jsp" class="btn btn-light">Shop Now</a>
            </div>
            <!-- End .container -->
        </section>
        <!-- End .explore-section -->

        <section class="feature-boxes-container">
            <div class="container-fluid appear-animate" data-animation-name="fadeInUpShorter">
                <div class="row no-gaps m-0 ">
                    <div class="col-sm-6 col-lg-3">
                        <div class="feature-box feature-box-simple text-center mb-2">
                            <div class="feature-box-icon">
                                <i class="icon-earphones-alt text-white"></i>
                            </div>

                            <div class="feature-box-content p-0">
                                <h3 class="text-white">Customer Support</h3>
                                <h5 class="line-height-1">Need Assistance?</h5>

                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vestibulum magna, et dapib.</p>
                            </div>
                            <!-- End .feature-box-content -->
                        </div>
                        <!-- End .feature-box -->
                    </div>
                    <!-- End .col-sm-6.col-lg-3 -->

                    <div class="col-sm-6 col-lg-3">
                        <div class="feature-box feature-box-simple text-center mb-2">
                            <div class="feature-box-icon">
                                <i class="icon-credit-card text-white"></i>
                            </div>

                            <div class="feature-box-content p-0">
                                <h3 class="text-white">Secured Payment</h3>
                                <h5 class="line-height-1">Safe &amp; Fast</h5>

                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vestibulum magna, et dapibus lacus. Lorem ipsum dolor sit amet.</p>
                            </div>
                            <!-- End .feature-box-content -->
                        </div>
                        <!-- End .feature-box -->
                    </div>
                    <!-- End .col-sm-6 col-lg-3 -->

                    <div class="col-sm-6 col-lg-3">
                        <div class="feature-box feature-box-simple text-center mb-2">
                            <div class="feature-box-icon">
                                <i class="icon-action-undo text-white"></i>
                            </div>
                            <div class="feature-box-content p-0">
                                <h3 class="text-capitalize text-white">Free Returns</h3>
                                <h5 class="line-height-1">Easy &amp; Free</h5>

                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec vestibulum magna, et dapib.</p>
                            </div>
                            <!-- End .feature-box-content -->
                        </div>
                        <!-- End .feature-box -->
                    </div>
                    <!-- col-sm-6 col-lg-3 -->

                    <div class="col-sm-6 col-lg-3">
                        <div class="feature-box feature-box-simple text-center mb-2">
                            <div class="feature-box-icon">
                                <i class="icon-shipping text-white"></i>
                            </div>
                            <div class="feature-box-content p-0">
                                <h3 class="text-white">Free Shipping</h3>
                                <h5 class="line-height-1">Made To Help You</h5>

                                <p>Porto has very powerful admin features to help customer to build their own shop in minutes without any special skills in web development.</p>
                            </div>
                            <!-- End .feature-box-content -->
                        </div>
                        <!-- End .feature-box -->
                    </div>
                    <!-- End .col-sm-6 col-lg-3 -->
                </div>
                <!-- End .row -->
            </div>
            <!-- End .container-->
        </section>
        <!-- End .feature-boxes-container -->
    </footer>
</body>


