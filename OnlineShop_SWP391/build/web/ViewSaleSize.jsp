<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Set Sale Size</title>
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
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }
            .action-buttons button {
                padding: 5px 10px;
                color: #fff;
                background-color: #007bff;
                border: none;
                cursor: pointer;
                border-radius: 4px;
            }
            .action-buttons button:hover {
                background-color: #0056b3;
            }
            .buttons-container {
                text-align: center;
                margin-top: 20px;
            }
            .edit-btn, .back-btn {
                padding: 10px 20px;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
            }
            .edit-btn {
                background-color: #007bff;
                margin-right: 20px;
            }
            .back-btn {
                background-color: #6c757d;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Set Sale Size</h2>

            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Size</th>
                        <th>Original Price</th>
                        <th>Discounted Price</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through DiscountedProducts list -->
                    <c:forEach var="discountP" items="${requestScope.DiscountedProducts}">
                        <c:forEach items="${requestScope.sizeOfProduct}" var="AttributeStock">
                            <c:if test="${AttributeStock.productID == discountP.productID && AttributeStock.sizeID == discountP.sizeID}">
                                <tr>
                                    <td>${discountP.productID}</td>
                                    <td>
                                        <c:forEach items="${requestScope.products}" var="p">
                                            <c:if test="${p.productID == discountP.productID}">
                                                ${p.productName}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:forEach items="${sessionScope.sizeForPromotion}" var="allSize">
                                            <c:if test="${allSize.sizeID == AttributeStock.sizeID}">
                                                ${allSize.sizeName}
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td style="color: #dc3545; font-weight: bold;">
                                        <fmt:formatNumber value="${AttributeStock.price}" pattern="#,##0"/>đ
                                    </td>
                                    <td style="color: #28a745; font-weight: bold;">
                                        <fmt:formatNumber value="${AttributeStock.price * (1 - discountP.discountRate / 100.0)}" pattern="#,##0"/>đ (-${discountP.discountRate}%)
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Edit and Back Buttons -->
            <div class="buttons-container">
                    <button class="edit-btn" onclick="editPromotion()">Edit</button>
                    <button class="back-btn" onclick="backToDashboard()">Back</button>
            </div>

        </div>

        <script>
            function editPromotion() {
                // Replace 'promotion-edit' with the actual path or action to edit the promotion
                window.location.href = 'SetSaleSize?productID=${requestScope.productID}&promotionID=${requestScope.PromotionForView.promotionID}';
            }

            function backToDashboard() {
                // Replace 'MarketerDashboard' with the actual path of your dashboard
                window.location.href = 'promotion-view?proid=${requestScope.PromotionForView.promotionID}';
            }
        </script>
    </body>
</html>
