<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin Dashboard - Setting Detail</title>
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
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }
            .main-content {
                margin-left: 250px;
                padding: 30px;
                background-color: #f4f7f6;
                min-height: 100vh;
            }

            .container {
                background-color: #fff;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                margin-top: 40px;
                max-width: 900px;
                margin-left: auto;
                margin-right: auto;
            }

            .container h4 {
                font-size: 24px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
                text-align: center;
            }

            .form-control {
                width: 100%; /* Làm cho các form input chiếm 100% chiều rộng của cột */
                max-width: 100%; /* Giới hạn chiều rộng tối đa */
                border-radius: 5px;
                border: 1px solid #ced4da;
                padding: 10px;
                font-size: 14px;
                box-sizing: border-box; /* Đảm bảo padding không ảnh hưởng đến chiều rộng tổng */
                margin-bottom: 20px;
            }

            .container .col-md-7 .form-control,
            .container .col-md-5 .form-control {
                width: 100%; /* Đảm bảo các trường input trong cột chiếm hết chiều rộng */
                margin-bottom: 20px;
            }

            .container {
                max-width: 900px; /* Giữ kích thước của container cân đối với form lớn hơn */
                margin-left: auto;
                margin-right: auto;
            }

            .btn {
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                transition: all 0.3s ease-in-out;
                width: auto; /* Giữ nút nhỏ gọn theo nội dung */
            }

            .btn-dark {
                background-color: #2c3e50;
                color: #fff;
                border: none;
            }

            .btn-dark:hover {
                background-color: #1a252f;
            }

            .btn-outline-dark {
                border: 1px solid #2c3e50;
                color: #2c3e50;
            }

            .btn-outline-dark:hover {
                background-color: #2c3e50;
                color: #fff;
            }


            .mt-5 {
                margin-top: 3rem;
            }
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
                <li><a href=""><i class="fas fa-cog"></i> Change Password</a></li>
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
            <main>
                <div class="container rounded bg-white mt-5 mb-5">
                    <form action="AddSetting" method="POST">
                        <div class="row"  style="margin-top: 8%;">
                            <div class="p-4">

                                <h4 class="text-center">Add Setting</h4>
                            </div>
                            <div class="col-md-5">
                                <div class="p-3 py-5">
                                    <div class="col-md-12">Type
                                        <select class="form-control" name="type" id="typeSelect" aria-label="Default select example">
                                            <option value="">All</option>
                                            <c:forEach items="${sessionScope.listTypeSetting}" var="c">
                                                <option value="${c.id}">
                                                    ${c.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div id="additionalFields" style="display: none;">
                                        <div class="col-md-12">Pre Status
                                            <select class="form-control" id="preStatusSelect" name="pre">
                                                <option value="">-- Select Pre Status --</option>
                                                <c:forEach items="${statusList}" var="status">
                                                    <option value="${status.statusID}">
                                                        ${status.statusName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-12">Post Status
                                            <select class="form-control" id="postStatusSelect" name="post">
                                                <option value="">-- Select Post Status --</option>
                                                <c:forEach items="${statusList}" var="status">
                                                    <option value="${status.statusID}" >
                                                        ${status.statusName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div id="additionalFields2" style="display: none;">
                                        <div class="col-md-12">Cat id
                                            <select class="form-control" id="postStatusSelect" name="categories">
                                                <option value="">-- Select Categories --</option>
                                                <c:forEach items="${cateList}" var="cateList">
                                                    <option value="${cateList.catID}" >
                                                        ${cateList.catName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>


                                    <div class="col-md-7">
                                        <div class="p-3 py-5">
                                            <div class="row mt-16">
                                                <div class="col-md-12">Value<input type="text" name="value" class="form-control"  value="${setting.value}"></div>
                                                <div class="col-md-12">Description<input type="text" name="description" class="form-control" value="${setting.description}"/></div>                                        

                                                <div class="col-md-12">Status
                                                    <br/>
                                                    <input name="status" type="radio" value="1" checked="" />&nbsp;Show
                                                    <input name="status" type="radio" value="0" />&nbsp;Hide
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    <div class="mt-5 p-4 text-center">
                                        <a href="${historyUrl}"><button class="btn btn-outline-dark" type="button">Back</button></a>
                                        <input class="btn btn-dark" type="submit" value="Add">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form> 
            </main>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        <script>
            document.getElementById('typeSelect').addEventListener('change', function () {
                var selectedValue = this.value;
                var additionalFields = document.getElementById('additionalFields');
                var additionalFields2 = document.getElementById('additionalFields2');
                // Hiển thị các ô Pre/Post Status nếu type là 2, ngược lại thì ẩn đi
                if (selectedValue == '2') {
                    additionalFields.style.display = 'block';
                } else if (selectedValue == '3') {
                    additionalFields.style.display = 'none';
                    additionalFields2.style.display = 'block';
                } else {
                    additionalFields.style.display = 'none';
                    additionalFields2.style.display = 'none';
                }
            });
        </script>



    </body>
</html>
