<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>User Profile - Online Badminton shop</title>

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/icons/favicon.png">

        <!-- Google Fonts -->
        <script>
            WebFontConfig = {
                google: {families: ['Open+Sans:300,400,600,700', 'Poppins:300,400,500,600,700']}
            };
            (function (d) {
                var wf = d.createElement('script'), s = d.scripts[0];
                wf.src = '${pageContext.request.contextPath}/assets/js/webfont.js';
                wf.async = true;
                s.parentNode.insertBefore(wf, s);
            })(document);

            function togglePasswordVisibility(passwordFieldId, checkboxId) {
                const passwordField = document.getElementById(passwordFieldId);
                const checkbox = document.getElementById(checkboxId);
                passwordField.type = checkbox.checked ? "text" : "password";
            }

        </script>

        <!-- Plugins CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">

        <!-- Main CSS File -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css">

        <style>
            body {
                background: url('${pageContext.request.contextPath}/assets/images/backgrounds/login-bg.jpg') no-repeat center center;
                background-size: cover;
            }

            .profile-container {
                margin-top: 190px;
            }

            .login-card {
                background-color: rgba(255, 255, 255, 0.9);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .heading {
                text-align: center;
            }

            .btn-dark {
                background-color: #333;
                border-color: #333;
            }

            .form-input {
                border-radius: 5px;
                margin-bottom: 15px;
            }

            .form-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .forget-password {
                color: #007bff;
                text-decoration: none;
            }

            .forget-password:hover {
                text-decoration: underline;
            }

            .login-container h1 {
                color: #333;
            }
            .profile-image img {
                width: 150px; /* Adjust the width */
                height: 150px; /* Adjust the height */
                border-radius: 50%; /* Optional: to make the image round */
                object-fit: cover; /* Ensure the image covers the container */
                margin-bottom: 10px; /* Space below the image */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional: Add a soft shadow for effect */
            }

            @media (max-width: 768px) {
                .login-card {
                    padding: 20px;
                }
            }
            .changePro{
                margin-bottom: 30px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="common/header.jsp"></jsp:include>

            <div class="container">

                <div class="profile-container">
                <c:set var="c" value="${sessionScope.c}"/>
                <!--Profile cua customer -->

                <c:if test="${c != null}">


                    <form action="changeProfile" method="post" enctype="multipart/form-data">
                        <div class="left-side">
                            <div class="profile-image">
                                <img  src="${c.img_url}" alt="User Profile Picture">
                            </div>
                        </div>

                        <!-- Right Side: User Profile Form -->
                        <div class="right-side">
                            <div class="profile-card">
                                <div class="heading mb-3">
                                    <h2 class="title">User Profile</h2>
                                </div>
                                <!-- Name Field -->
                                <div class="form-group">
                                    <label for="name">Full Name: <span class="required">*</span></label>
                                    <input type="text" class="form-input form-control" name="name" id="name" value="${c.fullName}" readonly />
                                </div>

                                <!-- Email Field -->
                                <div class="form-group">
                                    <label for="email">Email: <span class="required">*</span></label>
                                    <input type="email" class="form-input form-control" name="email" id="email" value="${c.email}" readonly />
                                </div>

                                <!-- Phone Number Field -->
                                <div class="form-group">
                                    <label for="phone">Phone:</label>
                                    <input type="tel" class="form-input form-control" name="phone" id="phone" value="${c.phone}" readonly />
                                </div>
                                <c:if test="${c.gender==1}">
                                    <label for="Gender">Gender: </label>
                                    <input type="tel" class="form-input form-control" name="phone" id="phone" value="Male" readonly />
                                </c:if>
                                <c:if test="${c.gender==0}">
                                    <label for="Gender">Gender: </label>
                                    <input type="tel" class="form-input form-control" name="phone" id="phone" value="Female" readonly />
                                </c:if>
                                <!-- Address Field -->
                                <div class="form-group">
                                    <label for="address">Address:</label>
                                    <textarea class="form-input form-control" name="address" id="address" readonly>${c.address}</textarea>
                                </div>
                                <c:if test="${sessionScope.messProfile != null}">
                                    <div class="alert alert-info" role="alert">
                                        ${sessionScope.messProfile}
                                    </div>
                                </c:if>
                                <!-- Submit Button -->
                                </form>
                            </div>
                        </div>
                    </c:if>
                    <a class="btn btn-dark mt-3 changePro" href="updateuserprofile.jsp">Edit Profile</a>

            </div>
        </div>

        <!-- Footer --> 
        <jsp:include page="common/footer.jsp"></jsp:include>


            <!-- Plugins JS File -->
            <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
    </body>

</html>
