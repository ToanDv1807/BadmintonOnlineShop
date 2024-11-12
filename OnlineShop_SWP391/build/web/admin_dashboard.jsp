<%@ page import="model.Account" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap, java.util.Arrays" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Admin Dashboard - Statistics</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script> <!-- Data Labels Plugin -->

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
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
            .chart-container {
                width: 75%;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .chart-container h3 {
                text-align: center;
                margin-bottom: 20px;
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
            .date{
                margin-top: 20px
            }
            .date-form {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin: 20px 0;
                padding: 10px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            }
            .chart-pie {
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                background: white;
                width: 75%;
                margin: 50px auto;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);

            }
            .chart-pie h3 {
                text-align: center;
                margin-bottom: 20px;
            }
            #orderStatusChart ,#revenueByCategoryChart{
                width: 500px !important; /* Giảm kích thước của canvas */
                height: 500px !important; /* Giảm chiều cao của canvas */
                margin: auto;
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
            <form action="AdminDashboard" method="GET" class="date-form">
                <div class="form-group">
                    <label for="startdate">Start Date:</label>
                    <input type="date" id="startdate" name="startdate" value="${param.startdate}">
                </div>

                <div class="form-group">
                    <label for="enddate">End Date:</label>
                    <input type="date" id="enddate" name="enddate" value="${param.enddate}">
                </div>

                <div>
                    <button type="submit">Submit</button>
                </div>
            </form>

            <!-- Dashboard Cards for Quick Stats -->
            <div class="dashboard-cards">
                <div class="dashboard-card">
                    <i class="fas fa-dollar-sign"></i>
                    <h3><fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/> vnd</h3>
                    <p>Total Revenue</p>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-user-plus"></i>
                    <h3>${totalCustomer}</h3>
                    <p>New Customers</p>
                </div>
                <div class="dashboard-card">
                    <i class="fas fa-user-check"></i>
                    <h3>${totalBought}</h3>
                    <p>New bought</p>
                </div>
            </div>

            <div class="chart-pie">
                <h3>Orders</h3>
                <canvas id="orderStatusChart" ></canvas>
            </div>

            <!-- Revenue by Category Chart -->
            <div class="chart-container">
                <h3>Revenue by Product Categories</h3>
                <canvas id="revenueByCategoryChart"></canvas>
            </div>

            <!-- Customer Feedback Chart -->
            <div class="chart-container">
                <h3>Average Star Rating (${avgRate})</h3>
                <canvas id="customerFeedbackChart"></canvas>
            </div>
            <!-- Order Trend Chart -->
            <div class="chart-container">
                <h3>Order Trend</h3>
                <canvas id="orderTrendChart"></canvas>
            </div>
        </div>

        <!-- Script to Initialize Chart.js and Create Charts -->
        <script>

// Declare arrays to store the labels and data for the chart
            const listOrderLabel = [];
            const listOrderData = [];

// Retrieve data from JSP logic and populate the JavaScript arrays
            <% Map<String, Integer> listOrder = (Map<String, Integer>) request.getAttribute("orderList"); %>
            <% if (listOrder != null) { %>
            <% for (Map.Entry<String, Integer> entry : listOrder.entrySet()) { %>
            listOrderLabel.push('<%= entry.getKey() %>');  // Push status name
            listOrderData.push(<%= entry.getValue() %>);   // Push order count
            <% } %>
            <% } %>

// Debugging: Log arrays to console to ensure data is populated
            console.log('Labels:', listOrderLabel);
            console.log('Data:', listOrderData);

// Chart.js data configuration for the Pie Chart
            const orderStatusData = {
                labels: listOrderLabel,
                datasets: [{
                        label: 'Order Count by Status',
                        data: listOrderData,
                        backgroundColor: [
                            'rgba(75, 192, 192, 0.5)',
                            'rgba(255, 159, 64, 0.5)',
                            'rgba(54, 162, 235, 0.5)',
                            'rgba(153, 102, 255, 0.5)',
                            'rgba(255, 99, 132, 0.5)',
                            'rgba(255, 206, 86, 0.5)',
                            'rgba(201, 203, 207, 0.5)'
                        ],
                        borderColor: [
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(201, 203, 207, 1)'
                        ],
                        borderWidth: 1
                    }]
            };

// Initialize the Pie Chart with percentage display using Data Labels Plugin
            new Chart(document.getElementById('orderStatusChart'), {
                type: 'pie',
                data: orderStatusData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        datalabels: {
                            formatter: (value, ctx) => {
                                const sum = ctx.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / sum) * 100).toFixed(2) + '%';
                                return percentage;
                            },
                            color: 'black', // Optional: Set text color
                            font: {
                                weight: 'bold',
                                size: 14 // Adjust font size if needed
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels] // Activate Data Labels Plugin
            });

            const orderTrendLabels = [];
            const totalOrdersData = [];
            const successOrdersData = [];
            <% Map<String, Integer[]> orderTrendLast7Days = (Map<String, Integer[]>) request.getAttribute("orderTrend"); %>

            <% if (orderTrendLast7Days != null) { %>
            <% for (Map.Entry<String, Integer[]> entry : orderTrendLast7Days.entrySet()) { %>
            orderTrendLabels.push('<%= entry.getKey() %>');
            totalOrdersData.push(<%= entry.getValue()[0] %>);
            successOrdersData.push(<%= entry.getValue()[1] %>);
            <% } %>
            <% } %>


            const avgRatingLabel = [];
            const avgRatingData = [];
            <% Map<String, Float> rate = (Map<String, Float>) request.getAttribute("listRate"); %>
            <% if (rate != null) { %>
            <% for (Map.Entry<String, Float> entry : rate.entrySet()) { %>
            avgRatingLabel.push('<%= entry.getKey() %>');
            avgRatingData.push(<%= entry.getValue() %>);
            <% } %>
            <% } %>
            // Khởi tạo dữ liệu cho Chart.js
            const orderTrendData = {
                labels: orderTrendLabels,
                datasets: [
                    {
                        label: 'All Orders',
                        data: totalOrdersData,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderWidth: 2,
                        fill: true,
                    },
                    {
                        label: 'Success Orders',
                        data: successOrdersData,
                        borderColor: 'rgba(255, 99, 132, 1)',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderWidth: 2,
                        fill: true,
                    },
                ]
            };



            const totalAmountLabel = [];
            const totalAmountData = [];
            <% Map<String, Float> total = (Map<String, Float>) request.getAttribute("listAmount"); %>
            <% if (total != null) { %>
            <% for (Map.Entry<String, Float> entry : total.entrySet()) { %>
            totalAmountLabel.push('<%= entry.getKey() %>');
            totalAmountData.push(<%= entry.getValue() %>);
            <% } %>
            <% } %>

// Revenue by Category Data
            const revenueByCategoryData = {
                labels: totalAmountLabel,
                datasets: [{
                        label: 'Total Revenue',
                        data: totalAmountData,
                        backgroundColor: [
                            'rgba(75, 192, 192, 0.5)',
                            'rgba(255, 159, 64, 0.5)',
                            'rgba(54, 162, 235, 0.5)',
                            'rgba(153, 102, 255, 0.5)',
                            'rgba(255, 99, 132, 0.5)',
                            'rgba(255, 206, 86, 0.5)',
                            'rgba(201, 203, 207, 0.5)'
                        ],
                        borderColor: [
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 159, 64, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(201, 203, 207, 1)'
                        ],
                        borderWidth: 1
                    }]
            };

// Initialize Revenue by Category Pie Chart with Data Labels Plugin
            new Chart(document.getElementById('revenueByCategoryChart'), {
                type: 'pie',
                data: revenueByCategoryData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        datalabels: {// Configure Data Labels Plugin
                            formatter: (value, ctx) => {
                                const sum = ctx.chart.data.datasets[0].data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / sum) * 100).toFixed(2) + '%';
                                return percentage;
                            },
                            color: 'black', // Optional: Set text color
                            font: {
                                weight: 'bold',
                                size: 14 // Adjust font size if needed
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels] // Activate Data Labels Plugin
            });

            // Customer Feedback Data
            const customerFeedbackData = {
                labels: avgRatingLabel,
                datasets: [{
                        label: 'Average Star Rating',
                        data: avgRatingData,
                        backgroundColor: 'rgba(153, 102, 255, 0.5)',
                        borderColor: 'rgba(153, 102, 255, 1)',
                        borderWidth: 2
                    }]
            };
            // Initialize Order Trend Chart
            new Chart(document.getElementById('orderTrendChart'), {
                type: 'line',
                data: orderTrendData,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            title: {
                                display: true,
                                text: 'Orders'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Day'
                            }
                        }
                    }
                }
            });

            // Initialize Customer Feedback Chart
            new Chart(document.getElementById('customerFeedbackChart'), {
                type: 'bar',
                data: customerFeedbackData,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            min: 0,
                            max: 5,
                            ticks: {
                                stepSize: 0.5,
                                callback: function (value) {
                                    return value.toFixed(1);
                                }
                            },
                            title: {
                                display: true,
                                text: 'Average Rating (Stars)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Product Categories'
                            }
                        }
                    }
                }
            });
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
