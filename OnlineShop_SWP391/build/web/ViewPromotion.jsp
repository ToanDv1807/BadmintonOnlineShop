<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>View Promotion</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 20px;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            .promotion-details {
                margin-bottom: 30px;
            }
            .promotion-details label {
                font-weight: bold;
                display: block;
                margin: 10px 0 5px;
            }
            .promotion-details p {
                margin: 0;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #f9f9f9;
            }
            .products-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .products-table th, .products-table td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }
            .products-table th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            .action-buttons button {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
            }
            .edit-btn {
                background-color: #007bff;
            }
            .remove-btn {
                background-color: #dc3545;
            }
            .modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center; /* Center horizontally */
                align-items: center;    /* Center vertically */
                z-index: 1000;         /* Ensure modal appears above other elements */
            }

            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                width: 300px; /* Set a fixed width */
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Optional: Add some shadow for depth */
            }

            .modal-actions {
                margin-top: 20px;
                display: flex;
                justify-content: space-around; /* Space buttons evenly */
            }

            .close-btn {
                float: right;
                cursor: pointer;
                font-size: 18px;
            }
            .save-btn {
                background-color: #28a745; /* Green for Save */
                color: white;
                border: none;
                border-radius: 4px;
                padding: 6px 12px;
                cursor: pointer;
                margin-right: 20px;
            }

            .cancel-btn {
                background-color: #dc3545; /* Red for Cancel */
                color: white;
                border: none;
                border-radius: 4px;
                padding: 6px 12px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>View Promotion</h1>

            <!-- Promotion Details Section -->
            <div class="promotion-details">
                <label for="promotionName">Name:</label>
                <p>${requestScope.PromotionForView.name}</p>

                <label for="startDate">Start Date:</label>
                <p>${requestScope.PromotionForView.startDate.substring(0, 10)}</p>

                <label for="endDate">End Date:</label>
                <p>${requestScope.PromotionForView.endDate.substring(0, 10)}</p>

                <label for="description">Description:</label>
                <p>${requestScope.PromotionForView.description}</p>

                <label for="status">Status:</label>
                <p>${requestScope.PromotionForView.status == 1 ? "Active" : "Inactive"}</p>

                <label for="note">Note:</label>
                <p>
                    ${requestScope.PromotionForView.note}
                </p>
            </div>
            <!-- Discounted Products Table -->
            <h2>Discounted Products</h2>
            <table class="products-table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Name</th>
                        <th>Old Price</th>
                        <th>New Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="discountP" items="${requestScope.DiscountedProducts}">
                        <tr>
                            <td>${discountP.productID}</td>
                            <td>
                                <c:forEach items="${requestScope.products}" var="p">
                                    <c:if test="${discountP.productID == p.productID}">
                                        ${p.productName}
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td style="color: #dc3545; font-weight: bold;">
                                <c:forEach items="${requestScope.products}" var="p"> 
                                    <c:if test="${discountP.productID == p.productID}">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td style="color: #28a745; font-weight: bold;">
                                <c:forEach items="${requestScope.products}" var="p"> 
                                    <c:if test="${discountP.productID == p.productID}">
                                        <fmt:formatNumber value="${p.price * (1 - discountP.discountRate / 100.0)}" pattern="#,##0"/>đ (-${discountP.discountRate}%)
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td class="action-buttons">
                                <button 
                                    type="button" 
                                    class="edit-btn" 
                                    onclick="window.location.href = 'ViewSaleSize?productID=${discountP.productID}&promotionID=${requestScope.PromotionForView.promotionID}'">
                                    View Size
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div style="text-align: center; margin-top: 20px;">
                <button onclick="editPromotion()" style="padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-right: 30px">Edit Promotion</button>
                <button onclick="backToDashboard()" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">Back to Dashboard</button>
            </div>
        </div>

        <script>
            function removeProduct(productId) {
                if (confirm("Are you sure you want to remove this product from the promotion?")) {
                    window.location.href = 'RemoveProductServlet?productId=' + productId;
                }
            }

            function editPromotion() {
                window.location.href = 'promotion-edit?proid=${requestScope.PromotionForView.promotionID}';
            }

            function backToDashboard() {
                window.location.href = 'MarketerDashboard';
            }
            function saveDiscountRate() {
                const discountRate = document.getElementById("discountRateInput").value;
                const productId = document.getElementById("productIdInput").value;

                if (discountRate >= 1 && discountRate <= 100) {
                    // Add logic to save the discount rate (e.g., AJAX call to the server)
                    closeEditModal();
                } else {
                    alert("Please enter a discount rate between 1 and 100.");
                }
            }
        </script>
    </body>
</html>
