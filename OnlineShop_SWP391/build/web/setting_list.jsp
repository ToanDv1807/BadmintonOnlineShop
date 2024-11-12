
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap, java.util.Arrays" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- comment -->
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin Dashboard - Statistics</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
                color: #333;
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

            .header h2 {
                font-size: 24px;
                font-weight: 700;
                margin: 0;
            }

            .current-time {
                font-size: 14px;
                color: #ecf0f1;
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
            .sidebar ul li a {
                width: 100%;
                color: white;
                text-decoration: none;
                padding: 15px 20px;
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

            .main-content {
                margin-left: 250px;
                padding: 20px;
            }

            .btn-logout {
                padding: 10px 20px;
                color: #fff;
                background-color: #e74c3c;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
                font-size: 14px;
            }

            .btn-logout:hover {
                background-color: #c0392b;
                box-shadow: 0 4px 15px rgba(231, 76, 60, 0.5);
                transform: translateY(-2px);
            }

            .container-fluid {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            }

            .table {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .table th {
                background-color: #34495e;
                color: white;
                font-weight: 700;
                text-transform: uppercase;
                padding: 12px;
            }

            .table td {
                padding: 12px;
                vertical-align: middle;
                text-align: center; /* Căn giữa theo chiều ngang */
            }

            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }

            .pagination li {
                margin: 0 5px; /* Khoảng cách giữa các số trang */
            }

            .pagination li a {
                display: block;
                padding: 10px 15px;
                background-color: #fff;
                border: 1px solid #ddd;
                color: #34495e;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }

            .pagination li a:hover {
                background-color: #e74c3c;
                color: white;
            }

            .pagination li.active a {
                background-color: #e74c3c;
                color: white;
                border-color: #e74c3c;
            }

            .pagination li.active a:hover {
                background-color: #e74c3c; /* Đảm bảo khi hover vào trang hiện tại không thay đổi */
                color: white;
            }


            .filter-search__control {
                width: 98%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                transition: border-color 0.3s ease;
            }

            .filter-search__control:focus {
                border-color: #e74c3c;
                outline: none;
                box-shadow: 0 0 8px rgba(231, 76, 60, 0.3);
            }

            .dropdown-font-new {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 100%;
                transition: border-color 0.3s ease;
            }

            .dropdown-font-new:focus {
                border-color: #e74c3c;
                outline: none;
            }

            .btn-outline-danger {
                color: #e74c3c;
                border-color: #e74c3c;
                padding: 8px 16px;
                border-radius: 4px;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .btn-outline-danger:hover {
                background-color: #e74c3c;
                color: white;
            }
            .btn-danger {
                background-color: #e74c3c; /* Màu đỏ đẹp cho nút */
                color: white;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 500;
                transition: all 0.3s ease-in-out; /* Hiệu ứng chuyển động mượt mà */
                box-shadow: 0 4px 10px rgba(231, 76, 60, 0.3); /* Bóng đổ để nút nổi bật hơn */
            }

            .btn-danger:hover {
                background-color: #c0392b; /* Màu khi hover */
                box-shadow: 0 6px 15px rgba(231, 76, 60, 0.5); /* Bóng đổ sâu hơn khi hover */
                transform: translateY(-2px); /* Hiệu ứng nâng nút khi hover */
            }

            a {
                text-decoration: none; /* Loại bỏ gạch chân của thẻ a */
            }

            a .btn-danger {
                display: inline-block; /* Đảm bảo nút hiển thị đúng với thẻ <a> */
            }



        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            <!-- Main content starts here -->
            <main>
                <div class="container-fluid rounded row" style="margin-top: 1% !important; margin-bottom: 1% !important">
                    <div class="col-md-1">
                        <a href="AddSetting">
                            <button type="button" class="btn btn-danger">Add</button>
                        </a>
                    </div>
                    <div class="col-md-2">
                        <select class="dropdown-font-new" style="width: 100%" aria-label="Default select example" onchange="location = this.value;">
                            <!-- Option mặc định 'Phân loại' khi typeId là null -->
                            <option value="SettingList?${historyKey != null ? historyKey : ''}${historyValue != null ? historyValue : ''}${historyType != null ? historyType : ''}${historyStatus != null ? historyStatus : ''}" ${typeId == null ? "selected" : ""}>Phân loại</option>

                            <!-- Lặp qua danh sách listTypeSetting -->
                            <c:forEach items="${sessionScope.listTypeSetting}" var="c">
                                <option value="SettingList?typeId=${c.id}&historyKey=${historyKey}&historyValue=${historyValue}&historyType=${historyType}&historyStatus=${historyStatus}" 
                                        ${typeId eq c.id ? 'selected' : ''}>
                                    ${c.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <select class="dropdown-font-new float-left" style="width: 100%" aria-label="Default select example" onchange="location = this.value;">Sắp xếp
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}&type=desc&value=setting_id" ${type == "desc" && value == "setting_id" ? "Selected" : ""}>ID giảm dần</option>
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}&value=setting_id" ${type == null && value == "setting_id" ? "Selected" : ""}>ID tăng dần</option>
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}&type=desc&value=value" ${type == "desc" && value == "value" ? "Selected" : ""}>Giá trị giảm dần</option>
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}&value=value" ${type == null && value == "value" ? "Selected" : ""}>Giá trị tăng dần</option>
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}&type=desc" ${type == "desc" && value == null ? "Selected" : ""}>Loại giảm dần</option>
                            <option value="SettingList?${historyKey}${historyStatus}${historyTypeId}" ${type == null && value == null ? "Selected" : ""}>Loại tăng dần</option>
                        </select>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-2">
                        <select class="dropdown-font-new float-right" aria-label="Default select example" onchange="location = this.value;">Trạng thái
                            <option value="SettingList?${historyKey}${historyValue}${historyTypeId}" ${status == null ? "Selected" : ""}>Status</option>
                            <option value="SettingList?${historyKey}${historyValue}${historyTypeId}&status=1" ${status == 1 ? "Selected" : ""}>Show</option>
                            <option value="SettingList?${historyKey}${historyValue}${historyTypeId}&status=0" ${status == 0 ? "Selected" : ""}>Hide</option>
                        </select>
                    </div>
                    <div class="col-md-2 text-center">
                        <form action="SettingList">
                            <input type="text" name="key" value="${key}" placeholder="Search by value" class="filter-search__control">
                            <button type="submit" class="btn btn-outline-danger">
                                <i style='font-size:15px' class='fas'>&#xf002;</i>
                            </button>
                        </form>
                    </div>
                </div>

                <div class="container rounded bg-white mt-5 mb-5">
                    <table class="table" style="margin-top: 4%">
                        <thead class="text-center">
                        <th>ID</th>
                        <th>Type</th>
                        <th>Order</th>
                        <th>Value</th>
                        <th>Status</th>
                        <th style="width: 12%">View Detail</th>
                        </thead>
                        <tbody>
                            <c:forEach items="${listSetting}" var="s">
                                <tr class="text-center">
                                    <td scope="row">${s.setting_id}</td>
                                    <td>
                                        <c:forEach items="${sessionScope.listTypeSetting}" var="c">
                                            ${s.type == c.id ? c.name : ""}
                                        </c:forEach>
                                    </td>
                                    <td>${s.order}</td>
                                    <td>${s.value}</td>
                                    <td>
                                        <c:if test="${s.status}">
                                            <img class="circle" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8XYXr-Bx1_kKnmfdUqI0xKn078iqZX2uA3cTLuCQdyCWvNZHFEABAtJ-WrEtlZ1OLOn0&usqp=CAU " style="width: 5%">
                                        </c:if>
                                        <c:if test="${!s.status}">
                                            <img class="circle" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWiCBqT62K3aglbgjMWJmUmHW96tcsbZ0kpA&s" style="width: 4%">
                                        </c:if>

                                    </td>
                                    <td style="width: 125px">
                                        <a class="btn btn-danger" href="SettingDetail?setting_id=${s.setting_id}" role="button" style='font-size:10px'>
                                            <i style='font-size:10px' class='fas'>&#xf044;</i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation example" class="pagination justify-content-center">
                    <ul class="pagination">
                        <c:forEach begin="1" end="${totalPage}" var="i">
                            <li class="page-item ${i == page ? 'active' : ''}">
                                <a class="page-link" href="SettingList?page=${i}${historyKey}${historyValue}${historyType}${historyTypeId}${historyStatus}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>

            </main>
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
