<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Details</title>
        <style>
            body {
                font-family: 'Helvetica Neue', Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 0;
            }

            .feedback-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .feedback-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .feedback-header .h2 {
                font-size: 28px;
                color: #333;
                margin: 0;
            }

            .feedback-content {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .detail-item {
                display: flex;
                justify-content: space-between;
                padding: 10px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .detail-item:last-child {
                border-bottom: none;
            }

            .detail-item label {
                font-weight: bold;
                color: #555;
            }

            .detail-item span {
                color: #777;
            }

            .btn-back {
                text-align: center;
                margin-top: 30px;
            }

            .btn-back a {
                padding: 12px 25px;
                background-color: #3498db;
                color: white;
                text-decoration: none;
                font-weight: bold;
                border-radius: 25px;
                transition: background-color 0.3s ease;
            }

            .btn-back a:hover {
                background-color: #2980b9;
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
            @media (max-width: 600px) {
                .feedback-content {
                    gap: 10px;
                }

                h2 {
                    font-size: 24px;
                }

                .detail-item {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .btn-back a {
                    padding: 10px 20px;
                }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <img alt="Logo" height="40" src="${pageContext.request.contextPath}/assets/images/icons/bfae95351def7e27a2c8c239fdeeac2a.jpg" width="40"/>
                <h2>Badminton Online Shop</h2>
            </div>
            <div class="current-time">
                <span id="currentDateTime"></span>
            </div>
        </div>
        <div class="feedback-container">
            <div class="feedback-header">
                <h2>Feedback Details</h2>
            </div>

            <div class="feedback-content">
                <!-- Hiển thị chi tiết Feedback -->
                <div class="detail-item">
                    <label>Full Name:</label>
                    <span>${f.customerName}</span>
                </div>

                <div class="detail-item">
                    <label>Email:</label>
                    <span>${f.customerEmail}</span>
                </div>

                <div class="detail-item">
                    <label>Mobile:</label>
                    <span>${f.customerPhone}</span>
                </div>

                <div class="detail-item">
                    <label>Product:</label>
                    <span>${f.productName}</span>
                </div>

                <div class="detail-item">
                    <label>Rated Star:</label>
                    <span>${f.rated} / 5</span>
                </div>

                <div class="detail-item">
                    <label>Feedback:</label>
                    <span>${f.content}</span>
                </div>
                <div class="detail-item">
                    <label>Feedback Date:</label>
                    <span>${f.feedbackDate}</span>
                </div>
                <div class="detail-item">
                    <label>Status:</label>
                    <span>
                        <c:choose>
                            <c:when test="${f.status == 1}">Active</c:when>
                            <c:when test="${f.status == 2}">Inactive</c:when>
                            <c:otherwise>Unknown</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <!-- Nút quay lại trang chính -->
            <div class="btn-back">
                <a href="MarketerDashboard">Back to Dashboard</a>
            </div>
        </div>
    </body>
    <script>
        // Script để hiển thị thời gian hiện tại (nếu cần)
        function currentDateTime() {
            const now = new Date();
            const formattedTime = now.toLocaleTimeString();
            document.getElementById('currentDateTime').textContent = formattedTime;
        }
        setInterval(currentDateTime, 1000);
    </script>
</html>
