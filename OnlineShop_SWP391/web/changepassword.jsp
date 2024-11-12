<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%
    if (session.getAttribute("account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Change Password - Online Badminton shop</title>

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

            .login-container {
                margin-top: 0px;
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

            @media (max-width: 768px) {
                .login-card {
                    padding: 20px;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="common/header.jsp"></jsp:include>

            <div class="container login-container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
                <div class="col-lg-6">
                    <div class="login-card">
                        <div class="heading mb-3">
                            <h2 class="title">Change Password</h2>
                        </div>
                        <form action="changePassword" method="post">
                            <!-- Current Password Field -->
                            <div class="form-group">
                                <label for="currentPassword">Current Password: <span class="required">*</span></label>
                                <div class="input-group">
                                    <input type="password" class="form-input form-control" name="currentPassword" id="currentPassword" required />
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <input type="checkbox" id="showCurrentPassword" onclick="togglePasswordVisibility('currentPassword', 'showCurrentPassword')">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- New Password Field -->
                            <div class="form-group">
                                <label for="newPassword">New Password: <span class="required">*</span></label>
                                <div class="input-group">
                                    <input type="password" class="form-input form-control" name="newPassword" id="newPassword" required />

                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <input type="checkbox" id="showNewPassword" onclick="togglePasswordVisibility('newPassword', 'showNewPassword')">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <small class="text-muted">
                                Password must start with a capital letter.<br>
                                Password must contain at least one special character.<br>
                                Please only enter a password with a maximum length of 8 characters.
                            </small><br>
                            <!-- Confirm Password Field -->
                            <div class="form-group">
                                <label for="confirmPassword">Confirm New Password: <span class="required">*</span></label>
                                <div class="input-group">
                                    <input type="password" class="form-input form-control" name="confirmPassword" id="confirmPassword" required />
                                    <div class="input-group-append">
                                        <div class="input-group-text">
                                            <input type="checkbox" id="showConfirmPassword" onclick="togglePasswordVisibility('confirmPassword', 'showConfirmPassword')">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Message Display Section -->
                        <c:if test="${not empty mess}">
                            <div class="alert alert-info" role="alert">
                                ${mess}
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-dark btn-block mt-4">Change</button>
                    </form>
                </div>
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
