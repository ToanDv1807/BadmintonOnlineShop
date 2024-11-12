<%@ page import="model.Account" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Account account = (Account) session.getAttribute("account");

    if (session == null || account == null || !"Employee".equals(account.getUserType()) || account.getRoleID() != 1) {
        // Chuy?n h??ng n?u không có quy?n truy c?p
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .header .logo {
                display: flex;
                align-items: center;
            }
            .header .logo img {
                width: 40px;
                margin-right: 10px;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px;
            }


            .chart {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                position: fixed;
                height: 100%;
                color: white;
                padding-top: 20px;
            }
            .sidebar .profile {
                text-align: center;
                padding: 10px 0;
            }
            .sidebar .profile img {
                border-radius: 50%;
                width: 80px;
                height: 80px;
            }
            .sidebar .profile h3 {
                margin: 10px 0 5px;
            }
            .sidebar .profile p {
                color: #1abc9c;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar ul li {
                padding: 15px 20px;
                cursor: pointer;
            }
            .sidebar ul li:hover {
                background-color: #34495e;
            }
            .sidebar ul li i {
                margin-right: 10px;
            }
            .sidebar ul li.active {
                background-color: #e74c3c;
            }
            .user-management-container {
                margin-top: 20px;
                margin-bottom: 50px;
            }

            .form-control {
                width: 300px;
            }
            /* Sidebar styles */
            .sidebar ul li a {
                width: 100%;
                color: white;
                text-decoration: none;
                padding: 15px 20px;
            }
            .sidebar ul li a:hover {
                background-color: #34495e; /* Color change on hover */
                text-decoration: none;
            }
            .sidebar ul li.active a {
                background-color: #e74c3c;
                color: white;
            }
            /* Button styles */
            .btn-primary {
                background-color: #007bff;
                border: none;
                color: #fff;
                border-radius: 5px;
                padding: 10px 20px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(0, 123, 255, 0.3);
            }

            .btn-primary:hover {
                background-color: #0056b3;
                color: #fff;
                box-shadow: 0 4px 15px rgba(0, 123, 255, 0.5);
                transform: translateY(-2px);
            }

            .btn-logout {
                align-items: center;
                padding: 10px 20px;
                color: #fff;
                background-color: #e74c3c;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
            }

            .btn-logout {
                align-items: center;
                padding: 10px 20px;
                color: #fff;
                background-color: #e74c3c;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
            }
            .btn-logout:hover {
                background-color: #c0392b;
                box-shadow: 0 4px 15px rgba(231, 76, 60, 0.5);
                transform: translateY(-2px);
            }
            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                background-color: #f4f7f6;
            }

            .register-card {
                width: 600px; /* Width of the form */
                background-color: #ffffff; /* Background color */
                padding: 40px; /* Internal padding */
                border-radius: 15px; /* Rounded corners */
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* Shadow for depth */
                text-align: center; /* Center align text */
            }

            .register-card h2 {
                font-weight: 700; /* Bold title */
                margin-bottom: 30px; /* Space below the title */
                color: #2c3e50;
            }

            .form-group {
                margin-bottom: 20px; /* Space between fields */
            }

            .form-group label {
                font-weight: 600; /* Bold labels */
                margin-bottom: 5px; /* Space below the label */
                display: block;
                text-align: left;
                color: #34495e;
            }

            .form-control,
            .form-control-file,
            .form-group select {
                width: 100%; /* Full width of the form */
                padding: 10px 15px; /* Padding inside fields */
                border: 1px solid #ddd; /* Light border */
                border-radius: 10px; /* Rounded corners */
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05); /* Shadow for depth */
                transition: all 0.3s ease-in-out; /* Smooth transition */
            }

            .form-control:focus,
            .form-control-file:focus,
            .form-group select:focus {
                outline: none;
                border-color: #007bff; /* Focus border color */
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2); /* Focus shadow effect */
            }

            .form-control-file {
                border: none; /* No border for file input */
                padding: 5px 0; /* Padding for file input */
            }

            small.text-muted {
                display: block; /* Separate line for small text */
                margin-top: 5px; /* Space above small text */
                color: #999;
                font-size: 12px;
                text-align: left;
            }

            .btn {
                width: 100%; /* Full width button */
                background-color: #007bff; /* Primary color */
                border: none;
                padding: 10px 25px; /* Button padding */
                color: #fff;
                font-weight: 600; /* Bold text */
                border-radius: 30px; /* Rounded button */
                text-transform: uppercase; /* Uppercase text */
                cursor: pointer; /* Pointer cursor */
                margin-top: 20px;
                transition: all 0.3s ease-in-out;
            }

            .btn:hover {
                background-color: #0056b3; /* Darker color on hover */
                transform: translateY(-3px); /* Lift effect on hover */
                box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3); /* Enhanced shadow on hover */
            }

            .alert {
                margin-top: 20px;
                color: #333;
                background-color: #f9f9f9;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .text-left {
                text-align: left; /* Text alignment for better spacing */
            }

            @media (max-width: 768px) {
                .register-card {
                    width: 95%; /* Full width for small screens */
                    padding: 20px; /* Smaller padding */
                }

                .btn {
                    width: 100%; /* Full width for small screens */
                }
            }
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .header .logo {
                display: flex;
                align-items: center;
            }
            .header .logo img {
                width: 40px;
                margin-right: 10px;
            }
            .main-content {
                margin-left: 250px;
                padding: 20px;
            }


            .chart {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                position: fixed;
                height: 100%;
                color: white;
                padding-top: 20px;
            }
            .sidebar .profile {
                text-align: center;
                padding: 10px 0;
            }
            .sidebar .profile img {
                border-radius: 50%;
                width: 80px;
                height: 80px;
            }
            .sidebar .profile h3 {
                margin: 10px 0 5px;
            }
            .sidebar .profile p {
                color: #1abc9c;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar ul li {
                padding: 15px 20px;
                cursor: pointer;
            }
            .sidebar ul li:hover {
                background-color: #34495e;
            }
            .sidebar ul li i {
                margin-right: 10px;
            }
            .sidebar ul li.active {
                background-color: #e74c3c;
            }
            .user-management-container {
                margin-top: 20px;
                margin-bottom: 50px;
            }

            .form-control {
                width: 300px;
            }
            /* Sidebar styles */
            .sidebar ul li a {
                width: 100%;
                color: white;
                text-decoration: none;
                padding: 15px 20px;
            }
            .sidebar ul li a:hover {
                background-color: #34495e; /* Color change on hover */
                text-decoration: none;
            }
            .sidebar ul li.active a {
                background-color: #e74c3c;
                color: white;
            }
            /* Button styles */
            .btn-primary {
                background-color: #007bff;
                border: none;
                color: #fff;
                border-radius: 5px;
                padding: 10px 20px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(0, 123, 255, 0.3);
            }

            .btn-primary:hover {
                background-color: #0056b3;
                color: #fff;
                box-shadow: 0 4px 15px rgba(0, 123, 255, 0.5);
                transform: translateY(-2px);
            }

            .btn-logout {
                align-items: center;
                padding: 10px 20px;
                color: #fff;
                background-color: #e74c3c;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
            }

            .btn-logout {
                align-items: center;
                padding: 10px 20px;
                color: #fff;
                background-color: #e74c3c;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
            }
            .btn-logout:hover {
                background-color: #c0392b;
                box-shadow: 0 4px 15px rgba(231, 76, 60, 0.5);
                transform: translateY(-2px);
            }

            .profile-container {
                margin-top: 190px;
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
        </style>

    </style>
</head>
<body>

    <%@ include file="common/sidebar.jsp" %>
    <div class="sidebar">
        <div class="profile">
            <img alt="Profile Picture" height="80" src="${sessionScope.admin.img_url}" width="80"/>
            <h3>${sessionScope.admin.fullName}</h3>
            <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
        <ul>
            <li><a href="AdminDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
            <li><a href="employeelist"><i class="fas fa-th"></i> Employee List</a></li>
            <li><a href="SettingList"><i class="fas fa-th"></i> Setting List</a></li>
            <li><a href="ChangePasswordEmployee.jsp"><i class="fas fa-cog"></i> Change Password</a></li>
        </ul>
    </div>
    <div class="main-content">
        <div class="header">
            <div class="logo">
                <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                <h2>Badminton Online Shop</h2>
            </div>
            <div class="current-time">
                <span id="currentDateTime"></span>
            </div>
        </div>
        <div class="container">
            <div class="register-card">
                <h2>Create Employee's Account</h2>
                <form action="addNewEmployee" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="tieude" for="email">Email:</label>
                        <input id="email" class="form-control" type="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="fullName">Full Name:</label>
                        <input id="fullName" class="form-control" type="text" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label class="tieude" for="gender">Gender:</label>
                        <select id="gender" class="form-control" name="gender" required>
                            <option value="1">Male</option>
                            <option value="0">Female</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="role">Role: </label>
                        <select id="role" class="form-control" name="role" required>
                            <option value="1" selected>Admin</option>
                            <option value="2" >Marketer</option>
                            <option value="3" >Seller</option>
                            <option value="4" >Sales Manager</option>
                            <option value="5" >Customer Service</option>
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
            <script>
                function updateTime() {
                    var now = new Date();
                    var dateTimeString = now.toLocaleString('en-GB', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit'
                    });
                    document.getElementById('currentDateTime').innerText = dateTimeString;
                }
                setInterval(updateTime, 1000);
                updateTime();
            </script>
            <!-- Plugins JS File -->
            <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/assets/js/plugins.min.js"></script>

            <!-- Main JS File -->
            <script src="${pageContext.request.contextPath}/assets/js/main.min.js"></script>
            </body>
            </html>
