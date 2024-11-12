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
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                color: white;
            }

            .action-buttons button:hover {
                background-color: #0056b3;
            }
            .buttons-container {
                text-align: center;
                margin-top: 20px;
            }
            .edit-btn {
                background-color: #007bff;
            }
            .remove-btn {
                background-color: #dc3545;
            }
            .back-btn {
                padding: 10px 20px;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1em;
                background-color: #6c757d;
            }
            .message {
                position: absolute; /* Use absolute positioning */
                top: 50px; /* Adjust based on where you want the message to appear */
                left: 90%; /* Center horizontally */
                transform: translateX(-50%); /* Adjust the centering */
                margin: 0 auto; /* Center the message */
                padding: 10px;
                border: 1px solid transparent;
                border-radius: 4px;
                z-index: 1000; /* Ensure the message appears on top of other content */
                display: none; /* Initially hide the message */
                color: green;
                border-color: green;
                background-color: rgba(144, 238, 144, 0.2); /* Optional: light background for success */
            }
            .modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
            }
            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                width: 300px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .modal-actions {
                margin-top: 20px;
                display: flex;
                justify-content: space-around;
            }
            .close-btn {
                float: right;
                cursor: pointer;
                font-size: 18px;
            }
            .save-btn {
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 6px 12px;
                cursor: pointer;
                margin-right: 20px;
            }
            .cancel-btn {
                background-color: #dc3545;
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
            <h2>Set Sale Size</h2>
            <c:if test="${not empty sessionScope.messageEditPro}">
                <div id="messageEditPro" class="message">
                    ${sessionScope.messageEditPro}
                </div>
                <script>
                    // Show the message immediately when it is present
                    document.getElementById("messageEditPro").style.display = "block";

                    // Hide after 5 seconds
                    setTimeout(function () {
                        document.getElementById("messageEditPro").style.display = "none";
                    }, 5000);

                    // Optionally, remove the session variable after displaying the message
                    <c:remove var="messageEditPro" scope="session"/>
                </script>
            </c:if>
            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Size</th>
                        <th>Original Price</th>
                        <th>Discounted Price</th>
                        <th>Actions</th>
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
                                    <td class="action-buttons">
                                        <button type="button" class="edit-btn" onclick="openEditModal(${discountP.productID}, ${discountP.discountRate}, ${discountP.sizeID})">Edit</button>
                                        <button type="button" class="remove-btn" onclick="removeProduct(${discountP.productID}, ${discountP.sizeID})">Remove</button>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </tbody>
            </table>
            <%-- Modal for Editing Discount Rate --%>
            <div id="editModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <span class="close-btn" onclick="closeEditModal()">&times;</span>
                    <h3>Edit Discount Rate</h3>
                    <form id="discountRateForm" action="UpdateDiscountRateSize" method="POST">
                        <label for="discountRateInput">Discount Rate (%):</label>
                        <input type="number" id="discountRateInput" name="discountRateInput" min="1" max="100" required>
                        <input type="hidden" id="productIdInput" name="productIdInput">
                        <input type="hidden" id="sizeInput" name="sizeInput">
                        <input type="hidden" id="promotionID" name="promotionID" value="${requestScope.PromotionForEdit.promotionID}">
                        <div class="modal-actions">
                            <button type="submit" class="save-btn">Save</button>
                            <button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- Edit and Back Buttons -->
            <div class="buttons-container">
                <button class="back-btn" onclick="backToDashboard()">Back</button>
            </div>
        </div>

        <script>
            function backToDashboard() {
                // Replace 'MarketerDashboard' with the actual path of your dashboard
                window.location.href = 'promotion-edit?proid=${requestScope.PromotionForEdit.promotionID}';
            }
            function openEditModal(productId, currentRate, sizeID) {
                document.getElementById("productIdInput").value = productId;
                document.getElementById("discountRateInput").value = currentRate;
                document.getElementById("sizeInput").value = sizeID;
                document.getElementById("editModal").style.display = "flex";
            }

            function closeEditModal() {
                document.getElementById("editModal").style.display = "none";
            }
            function removeProduct(productId, sizeID) {
                if (confirm("Are you sure you want to remove this product from the promotion?")) {
                    // Redirect to the delete URL with the product ID
                    window.location.href = "RemoveDiscountedProductWithSize?productId=" + productId + "&proid=${requestScope.PromotionForEdit.promotionID}&sizeID=" + sizeID;
                }
            }
        </script>

    </body>
</html>
