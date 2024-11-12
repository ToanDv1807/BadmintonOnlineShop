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

            .dashboard-cards {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .dashboard-card {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                width: 18%;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .dashboard-card i {
                font-size: 30px;
                margin-bottom: 10px;
            }
            .dashboard-card h3 {
                margin: 10px 0;
            }
            .social-cards {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }
            .social-card {
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                width: 18%;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .social-card i {
                font-size: 30px;
                margin-bottom: 10px;
            }
            .social-card h3 {
                margin: 10px 0;
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

            .user-management-card {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .user-list-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .user-list-table th, .user-list-table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .user-list-table th {
                background-color: #333;
                color: #fff;
            }

            .user-list-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .action-btns {
                display: flex;
                gap: 10px;
            }

            .action-btns a {
                color: #fff;
                padding: 5px 10px;
                border-radius: 5px;
                text-decoration: none;
            }

            .btn-edit {
                background-color: #007bff;
            }

            .btn-delete {
                background-color: #dc3545;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: #333;
                padding: 8px 16px;
                text-decoration: none;
                margin: 0 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
            }

            .pagination a:hover {
                background-color: #ddd;
            }

            .search-and-add {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .search-and-add .form-group {
                flex-grow: 1;
                margin-right: 15px;
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

            .btn-edit {
                background-color: #28a745;
                border: none;
                color: #fff;
                border-radius: 5px;
                padding: 5px 15px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(40, 167, 69, 0.3);
            }

            .btn-edit:hover {
                background-color: #218838;
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.5);
            }

            .btn-delete {
                background-color: #dc3545;
                border: none;
                color: #fff;
                border-radius: 5px;
                padding: 5px 15px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(220, 53, 69, 0.3);
            }

            .btn-delete:hover {
                background-color: #c82333;
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.5);
            }

            /* Search bar styles */
            .form-control {
                width: 400px;
                padding: 10px;
                border-radius: 20px;
                border: 1px solid #ddd;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
            }

            .form-control:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
            }

            /* Adjust form and button spacing */
            .search-and-add {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-and-add .form-group {
                flex-grow: 1;
                margin-right: 15px;
            }

            .btn-add {
                background-color: #17a2b8;
                color: #fff;
                border-radius: 5px;
                padding: 10px 20px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(23, 162, 184, 0.3);
                text-decoration: none;
            }

            .btn-add:hover {
                background-color: #138496;
                box-shadow: 0 4px 15px rgba(23, 162, 184, 0.5);
                transform: translateY(-2px);
            }
            .sort-dropdown {
                margin-left: 15px;
                width: 150px;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease-in-out;
            }

            .sort-dropdown:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
            }

            .form-group {
                margin-right: 10px;
            }
            .form-group .searchEmployee{
                width: 100%;
            }
            .btn-add {
                background-color: #17a2b8;
                color: #fff;
                border-radius: 5px;
                padding: 10px 20px;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(23, 162, 184, 0.3);
                text-decoration: none;
            }

            .btn-add:hover {
                background-color: #138496;
                box-shadow: 0 4px 15px rgba(23, 162, 184, 0.5);
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
            .form-search{
                display: flex;
            }
            .user-management-container {
                width: 100%;
                max-width: 90%; /* Adjust the width to 90% to center it and give some margins */
                margin: 0 auto; /* Center the container */
                margin-top: 20px;
                margin-bottom: 50px;
            }

            .user-list-table {
                width: 100%; /* Make the table take up full width */
                border-collapse: collapse;
                margin-top: 20px;
            }

            .form-control {
                width: 100%; /* Ensure the input field adapts to parent container */
                max-width: 500px;
                padding: 10px;
                border-radius: 20px;
                border: 1px solid #ddd;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            /* Extend the width of the search input field */
            #searchEmployee {
                width: 300px; /* Adjust to the desired width */
                max-width: 100%; /* Ensures responsiveness */
            }

            /* Optional: Adjusts spacing between form elements */
            .form-search .form-group {
                margin-right: 10px;
            }

            /* Optional: Set dropdown width to keep the layout consistent */
            .form-control.sort-dropdown {
                width: auto;
                max-width: 150px; /* Adjust based on design needs */
            }
        </style>

    </style>
</head>
<body>

    <div class="sidebar">

        <div class="profile" style="display: flex; align-items: center;">
            <img alt="Profile Picture" height="80" src="${sessionScope.admin.img_url}" width="80"/>
            <div style="display: flex; flex-direction: column; margin-left: 15px;">
                <h3 style="margin: 0;">${sessionScope.admin.fullName}</h3>
                <br>
                <a href="logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
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

        <div class="container user-management-container">
            <h2 class="text-center mb-4">User Management</h2>
            <c:if test="${employees !=null}">
                <!-- Employee List -->
                <h4 class="mt-5">Employee List</h4>
                <div class="user-management-card">
                    <div class="search-and-add">
                        <form action="employeelist" method="post" class="form-inline mb-4">
                            <div class="form-search">
                                <input type="hidden" name="pageC" value="${currentPageC}">
                                <input type="hidden" name="type" value="employee"> 
                                <div class="form-group">
                                    <input type="text" id="searchEmployee" name="searchEmployee" class="form-control"  value="${param.searchEmployee}" placeholder="Search by name or email or phone">
                                </div>
                                <div class="form-group">
                                    <!-- Dropdown select box for sorting fields -->
                                    <select name="sortE" class="form-control sort-dropdown">
                                        <option value="employeeID" ${param.sortEField == 'customerID' ? 'selected' : ''}>Sort by ID</option>
                                        <option value="fullName" ${param.sortEField == 'fullName' ? 'selected' : ''}>Sort by Name</option>
                                        <option value="email" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Email</option>
                                        <option value="phone" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Phone</option>
                                        <option value="email" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Email</option>
                                        <option value="roleID" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Role</option>
                                        <option value="gender" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Gender</option>
                                        <option value="status" ${param.sortEField == 'email' ? 'selected' : ''}>Sort by Status</option>

                                    </select>
                                </div>
                                <!-- Dropdown for Gender -->
                                <div class="form-group">
                                    <select name="filterGender" class="form-control sort-dropdown">
                                        <option value="">Filter by Gender</option>
                                        <option value="1" ${param.filterGender == '1' ? 'selected' : ''}>Male</option>
                                        <option value="0" ${param.filterGender == '0' ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>

                                <!-- Dropdown for Role -->
                                <div class="form-group">
                                    <select name="filterRole" class="form-control sort-dropdown">
                                        <option value="">Filter by Role</option>
                                        <c:forEach items="${listRole}" var="r">
                                            <option value="${r.roleID}" ${param.filterRole == r.roleID ? 'selected' : ''}>${r.roleName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Dropdown for Status -->
                                <div class="form-group">
                                    <select name="filterStatus" class="form-control sort-dropdown">
                                        <option value="">Filter by Status</option>
                                        <option value="1" ${param.filterStatus == '1' ? 'selected' : ''}>On Working</option>
                                        <option value="0" ${param.filterStatus == '0' ? 'selected' : ''}>Suspended</option>
                                    </select>
                                </div>

                                <div class="form-group" >
                                    <button type="submit" class="btn btn-primary ml-2">Search Employee</button>
                                </div>
                                <div>
                                    <a href="addEmployee.jsp" class="btn btn-primary btn-edit">Add New</a>
                                </div>

                            </div>

                        </form>

                    </div>
                    <a style="color: red">${messReset}</a>

                    <table class="user-list-table">
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Gender</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="employee" items="${employees}">
                                <c:forEach items="${listRole}" var="role">
                                    <c:if test="${employee.roleID==role.roleID}">
                                        <tr>
                                            <td>${employee.employeeID}</td>
                                            <td>${employee.fullName}</td>
                                            <td>${employee.email}</td>
                                            <td>${employee.phone}</td>
                                            <td>
                                                ${role.roleName}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${employee.gender == 1}">Male</c:when>
                                                    <c:when test="${employee.gender == 0}">Female</c:when>
                                                    <c:otherwise>Unknown</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${employee.status == 1}">On Working</c:when>
                                                    <c:when test="${employee.status == 0}">Suspended</c:when>
                                                </c:choose>
                                            </td>
                                            <td class="action-btns">
                                                <a href="userDetail?employeeID=${employee.employeeID}" class="btn-edit">View</a>
                                                <a href="updateEmployee?employeeID=${employee.employeeID}" class="btn-edit">Edit</a>
                                                <a href="resetPasswordForEmp?employeeID=${employee.employeeID}" class="btn-delete"
                                                   onclick="return confirm('Are you sure you want to reset password the Employee with ID ${employee.employeeID}?');">Reset PassWord</a>
                                                <a href="deleteUser?employeeID=${employee.employeeID}" class="btn-delete"
                                                   onclick="return confirm('Are you sure you want to delete the Employee with ID ${employee.employeeID}?');">Delete</a>

                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="pagination">
                        <c:forEach begin="1" end="${endPE}" var="i">
                            <a href="employeelist?pageE=${i}&searchEmployee=${searchEmployee}&sortE=${sortE}&filterGender=${filterGender}&filterRole=${filterRole}&filterStatus=${filterStatus}"
                               class="${i == sessionScope.currentPageE ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

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
