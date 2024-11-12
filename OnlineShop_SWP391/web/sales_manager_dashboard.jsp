<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@ page import="model.Account" %>
<html>
    <head>
        <title>Seller Dashboard - Menu</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">   
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                background-color: #f4f7f6;
            }
            /* Fix header and search form positioning */
            .header {
                background-color: #34495e;
                color: white;
                padding: 10px 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-left: 250px; /* Fixed margin to avoid sidebar overlap */
            }

            .header .logo {
                display: flex;
                align-items: center;
            }

            .header .logo img {
                width: 40px;
                margin-right: 10px;
            }

            .header form {
                margin: 0;
            }

            .header input[type="text"] {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ddd;
                width: 200px;
            }

            .header button {
                padding: 8px 15px;
                background-color: #1abc9c;
                border: none;
                border-radius: 5px;
                color: white;
                font-weight: bold;
                cursor: pointer;
            }

            .header button:hover {
                background-color: #16a085;
            }




            /* Responsive adjustments */
            @media (max-width: 768px) {
                .order-table th, .order-table td {
                    padding: 8px;
                }

                .custom-select-wrapper {
                    width: 100px;
                }

                .change-btn {
                    font-size: 14px;
                    padding: 4px 8px;
                }
            }
            .status-buttons {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .status-button {
                padding: 8px 16px;
                background-color: #1abc9c;
                color: white;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin-bottom: 2%;
            }

            .status-button:hover {
                background-color: #16a085;
            }

            .status-button.active {
                background-color: #333;
                color: white;
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
                margin-left: 200px;
            }

            .content {
                margin-left: 250px;
                padding: 20px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                gap: 40px; /* Ensure uniform spacing between charts */
            }

            .chart-container {
                width: 100%;
                max-width: 900px; /* Set a consistent max-width */
                height: 400px; /* Ensure consistent height for both charts */
                margin-top: 20px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            }

            @media (max-width: 768px) {
                .chart-container {
                    width: 100%;
                    max-width: 100%;
                    height: auto; /* Adjust height on smaller screens */
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
<%@ include file="common/sidebar.jsp" %>
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
            <form action="SaleManagerDashboard" method="GET" class="date-form">
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
            <div class="content">
                <h2>Total Revenue: 
                    <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" />
                    VND
                </h2>
                <h2>Daily Revenue Trend</h2>
                <div class="chart-container">
                    <canvas id="dailyRevenueChart"></canvas>
                </div>
            </div>
            <div class="content">
                <h2>Order Trend for Last 7 Days</h2>
                <div class="chart-container">
                    <canvas id="orderTrendChart"></canvas>
                </div>
            </div>

        </div>


        <!-- Time Update Script -->
        <script>
            <%
     Map<String, Double> listDailyRevenue = (Map<String, Double>) request.getAttribute("listDailyRevenue");
            %>
            // Initialize arrays to store labels (dates) and revenue data
            const dailyRevenueLabels = [];
            const dailyRevenueData = [];

            // Populate the labels and data from the backend
            <% if (listDailyRevenue != null) { %>
            <% for (Map.Entry<String, Double> entry : listDailyRevenue.entrySet()) { %>
            dailyRevenueLabels.push('<%= entry.getKey() %>'); // Date
            dailyRevenueData.push(<%= entry.getValue() %>); // Revenue amount
            <% } %>
            <% } %>

            // Prepare the data for Chart.js
            const dailyRevenueDataConfig = {
                labels: dailyRevenueLabels,
                datasets: [
                    {
                        label: 'Daily Revenue',
                        data: dailyRevenueData,
                        borderColor: 'rgba(54, 162, 235, 1)', // Line color
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Fill color
                        borderWidth: 2,
                        fill: true, // Fill the area under the line
                        tension: 0.4, // Smooth curve line
                    }
                ]
            };
            // Initialize the dailyRevenueChart using Chart.js
            new Chart(document.getElementById('dailyRevenueChart'), {
                type: 'line',
                data: dailyRevenueDataConfig,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            title: {
                                display: true,
                                text: 'Revenue ($)', // Y-axis title
                            },
                            beginAtZero: true // Start Y-axis from 0
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Date' // X-axis title
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top', // Legend position at the top
                        }
                    }
                }
            });


            <%
Map<String, Integer[]> getOrderTrend = (Map<String, Integer[]>) request.getAttribute("getOrderTrend");
            %>
            const orderTrendLabels = [];
            const totalOrdersData = [];
            const successOrdersData = [];

            <% if (getOrderTrend != null) { %>
            <% for (Map.Entry<String, Integer[]> entry : getOrderTrend.entrySet()) { %>
            orderTrendLabels.push('<%= entry.getKey() %>'); // Date
            totalOrdersData.push(<%= entry.getValue()[0] %>); // Total Orders
            successOrdersData.push(<%= entry.getValue()[1] %>); // Success Orders
            <% } %>
            <% } %>

            // Prepare data for the order trend chart
            const orderTrendDataConfig = {
                labels: orderTrendLabels,
                datasets: [
                    {
                        label: 'All Orders',
                        data: totalOrdersData,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    },
                    {
                        label: 'Success Orders',
                        data: successOrdersData,
                        borderColor: 'rgba(255, 99, 132, 1)',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }
                ]
            };
            new Chart(document.getElementById('orderTrendChart'), {
                type: 'line',
                data: orderTrendDataConfig,
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            title: {
                                display: true,
                                text: 'Orders'
                            },
                            beginAtZero: true
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Date'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
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
                document.querySelector('.current-time').innerText = dateTimeString;
            }

            setInterval(updateTime, 1000);
            updateTime();
        </script>
    </body>
</html>
