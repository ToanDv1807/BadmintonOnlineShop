<%@ page import="model.Account" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Account account = (Account) session.getAttribute("account");

    if (session == null || account == null || !"Employee".equals(account.getUserType()) || account.getRoleID() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard - Update Employee</title>
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


            @media (max-width: 768px) {
                .login-card {
                    padding: 20px;
                }
            }
            /* Profile Container Styling */
            .profile-container {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                max-width: 1000px;
                margin: 50px auto;
                padding: 30px;
                background-color: rgba(255, 255, 255, 0.9);
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            }

            /* Left Side Styling */
            .left-side {
                flex: 1;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }

            .profile-image img {
                width: 200px;
                height: 200px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .upload-btn-wrapper {
                position: relative;
                overflow: hidden;
                display: inline-block;
            }

            .upload-btn-wrapper .btn {
                background-color: #007bff;
                border: none;
                color: white;
                padding: 10px 20px;
                border-radius: 25px;
                font-size: 16px;
                cursor: pointer;
                margin-bottom: 10px;
                transition: all 0.3s ease-in-out;
            }

            .upload-btn-wrapper .btn:hover {
                background-color: #0056b3;
                box-shadow: 0 4px 12px rgba(0, 123, 255, 0.4);
            }

            .upload-btn-wrapper input[type="file"] {
                font-size: 100px;
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
            }

            /* Right Side Styling */
            .right-side {
                flex: 2;
                margin-left: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                padding: 20px 30px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            /* Profile Card Styling */
            .profile-card {
                width: 100%;
            }

            .profile-card .heading {
                margin-bottom: 30px;
            }

            .profile-card h2.title {
                text-align: center;
                font-size: 24px;
                font-weight: 700;
                color: #333;
                border-bottom: 2px solid #f4f4f4;
                padding-bottom: 10px;
            }

            /* Form Group Styling */
            .form-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: 600;
                margin-bottom: 5px;
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                border: 1px solid #ddd;
                padding: 10px 15px;
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease-in-out;
            }

            .form-group input:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
            }

            .form-group select {
                cursor: pointer;
            }

            textarea.form-input {
                resize: vertical;
                min-height: 100px;
            }

            .required {
                color: #e74c3c;
            }

            .btn-dark {
                background-color: #333;
                border-color: #333;
                color: #fff;
                border-radius: 30px;
                padding: 10px 25px;
                text-transform: uppercase;
                transition: all 0.3s ease-in-out;
            }

            .btn-dark:hover {
                background-color: #555;
                border-color: #555;
                transform: translateY(-3px);
            }
            .back{
                margin-top: 20px;
            }
            /* Responsive Design */
            @media (max-width: 768px) {
                .profile-container {
                    flex-direction: column;
                    padding: 20px;
                }

                .left-side, .right-side {
                    margin: 0;
                    width: 100%;
                }

                .right-side {
                    margin-top: 20px;
                    padding: 15px;
                }
            }
        </style>
    </head>
    <body>

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
            <c:set var="c" value="${c}"/>
            <a>${sessionScope.messProfile}</a>

            <div class="profile-container">

                <form action="updateEmployee" method="post" enctype="multipart/form-data">
                    <div class="left-side">
                        <div class="profile-image">
                            <img  src="${c.img_url}" alt="User Profile Picture">
                            <div class="">
                                <input id="profileImage" type="file" name="profileImage" accept="image/*">
                            </div>
                        </div>
                    </div>

                    <div class="right-side">
                        <h2 class="title">Edit User Profile</h2>
                        <div class="form-group">
                            <label for="name">Full Name: <span class="required">*</span></label>
                            <input type="text" class="form-control" name="name" id="name" value="${c.fullName}" required />
                        </div>

                        <div class="form-group">
                            <label for="email">Email: <span class="required">*</span></label>
                            <input type="email" class="form-control" name="email" id="email" value="${c.email}" readonly />
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone:</label>
                            <input type="tel" class="form-control" name="phone" id="phone" value="${c.phone}" />
                        </div>

                        <div class="form-group">
                            <label for="gender">Gender: </label>
                            <select id="gender" class="form-control" name="gender">
                                <option value="1" ${c.gender == 1 ? 'selected' : ''}>Male</option>
                                <option value="0" ${c.gender == 0 ? 'selected' : ''}>Female</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="role">Role: </label>
                            <select id="role" class="form-control" name="role" required>
                                <c:forEach items="${r}" var="roleOption">
                                    <option value="${roleOption.roleID}" ${c.roleID == roleOption.roleID ? 'selected' : ''}>${roleOption.roleName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="status">Status: </label>
                            <select id="status" class="form-control" name="status" required>
                                <option value="1" ${c.status == 1 ? 'selected' : ''}>On Working</option>
                                <option value="0" ${c.status == 0 ? 'selected' : ''}>Suspended</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="address">Address:</label>
                            <textarea class="form-control" name="address" id="address">${c.address}</textarea>
                        </div>

                        <button type="submit" class="btn btn-dark btn-block mt-4">Update</button>
                    </div>
                </form>
            </div>
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
    </body>
</html>
