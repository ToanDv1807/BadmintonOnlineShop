<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Promotion</title>
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
            .promotion-details input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                margin-bottom: 15px;
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
            .products-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr); /* 4 cards per row */
                gap: 10px;
                max-width: 100%; /* Ensure it fits within the container */
                overflow-x: auto; /* Allow horizontal scrolling if necessary */
            }
            .product-card {
                position: relative;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 8px;
                text-align: center;
                transition: background-color 0.3s, border-color 0.3s;
            }
            .product-card.selected {
                background-color: #d1e7dd;
                border-color: #0f5132;
            }

            .remove-icon {
                display: none;
                position: absolute;
                top: 4px;
                right: 4px;
                font-size: 1.2rem;
                color: #dc3545;
                cursor: pointer;
            }

            .product-card.selected .remove-icon {
                display: block; /* Show when selected */
            }

            .product-card img {
                width: 80px; /* Adjust width for smaller images */
                height: auto;
                border-radius: 4px;
            }

            .product-name {
                font-size: 0.75rem;
                margin: 4px 0;
                font-weight: bold;
            }

            .product-price {
                color: #28a745;
                font-size: 0.75rem;
                margin-bottom: 4px;
            }

            .product-card label {
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.7rem;
                gap: 5px;
            }

            .product-stock {
                font-size: 0.7rem; /* Smaller font size */
                color: #555; /* Subtle color, e.g., dark gray */
                margin-top: 4px;
                font-weight: 500; /* Slightly bold */
            }

            .filter-search-container {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
            }
            .filter-search-container label {
                font-weight: bold;
            }
            .filter-search-container input[type="text"] {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .filter-search-container select {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .size-selection-container {
                display: flex;
                flex-wrap: wrap; /* Allow wrapping to next line */
            }

            .size-selection-container label {
                font-size: 0.65rem;
                margin-bottom: 5px;
            }
            .size-selection-container.highlight {
                border: 1px solid red;
                padding: 4px;
                border-radius: 4px;
            }
            .coming-soon {
                opacity: 0.5; /* Makes the card semi-transparent */
                pointer-events: none; /* Prevents interaction */
                filter: grayscale(100%); /* Optionally, adds a grayscale effect for more fading */
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Edit Promotion</h1>
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

            <div style="display: flex; justify-content: flex-end">
                <button type="button" onclick="deletePromotion()" style="padding: 10px 20px; background-color: #dc3545; color: white; border: none; border-radius: 4px;">Delete Promotion</button>
            </div>
            <!-- Promotion Details Section as Form -->
            <form action="UpdatePromotion" method="POST">
                <input type="hidden" name="promotionId" value="${requestScope.PromotionForEdit.promotionID}">

                <div class="promotion-details">
                    <label for="promotionName">Name:</label>
                    <input type="text" id="promotionName" name="promotionName" value="${requestScope.PromotionForEdit.name}" required>

                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate" value="${requestScope.PromotionForEdit.startDate.substring(0, 10)}" required>

                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate" value="${requestScope.PromotionForEdit.endDate.substring(0, 10)}" required>

                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description" value="${requestScope.PromotionForEdit.description}" required>

                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option value="1" ${requestScope.PromotionForEdit.status == 1 ? 'selected' : ''}>Active</option>
                        <option value="0" ${requestScope.PromotionForEdit.status == 0 ? 'selected' : ''}>Inactive</option>
                    </select>

                    <label for="note">Note:</label>
                    <textarea id="note" name="note" style="width: 100%; height: 100px; border: 1px solid #ccc; border-radius: 4px; padding: 8px;">${requestScope.PromotionForEdit.note}</textarea>
                </div>

                <!-- Discounted Products Table -->
                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px;">
                    <h2>Discounted Products</h2>
                    <button type="button" onclick="openAddProductModal()" style="padding: 10px 20px; background-color: #28a745; color: white; border: none; border-radius: 4px;">
                        Add Product
                    </button>
                </div>
                <table class="products-table">
                    <thead>
                        <tr>
                            <th>ID</th>
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
                                        style="background-color: #28a745" 
                                        onclick="window.location.href = 'SetSaleSize?productID=${discountP.productID}&promotionID=${requestScope.PromotionForEdit.promotionID}'">
                                        Edit Size
                                    </button>
                                    <button type="button" class="edit-btn" onclick="openEditModal(${discountP.productID}, ${discountP.discountRate})">Edit All</button>
                                    <button type="button" class="remove-btn" onclick="removeProduct(${discountP.productID})">Remove</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <!-- Action Buttons -->
                <div style="text-align: center; margin-top: 20px;">
                    <button type="submit" style="padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 4px; margin-right: 30px">Save Changes</button>
                    <button type="button" onclick="backToDashboard()" style="padding: 10px 20px; background-color: #6c757d; color: white; border: none; border-radius: 4px;">Back to Dashboard</button>
                </div>
            </form>
            <!-- Add Product Modal -->
            <div id="addProductModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5);">
                <form id="addProductForm" method="post" action="AddProductForPromotion?proid=${requestScope.PromotionForEdit.promotionID}" style="background: white; max-width: 600px; margin: 20px auto; padding: 20px; border-radius: 8px; overflow-y: auto; max-height: calc(100% - 40px);">
                    <h2 style="text-align: center;">Add Product to Promotion</h2>

                    <!-- Filter and Search Section -->
                    <div class="filter-search-container">
                        <!-- Category Filter -->
                        <label for="modalCategoryFilter">Category:</label>
                        <select id="modalCategoryFilter" name="category" style="width: 150px; margin-bottom: 10px;" onchange="filterModalProducts()">
                            <option value="all">All Categories</option>
                            <c:forEach var="category" items="${sessionScope.categories}">
                                <option value="${category.catID}">${category.catName}</option>
                            </c:forEach>
                        </select>

                        <!-- Search by Name -->
                        <label for="modalProductSearch">Search:</label>
                        <input type="text" id="modalProductSearch" placeholder="Search by product name" onkeyup="filterModalProducts()">
                    </div>

                    <!-- Hidden Input to Hold Selected Product IDs -->
                    <input type="hidden" id="selectedProducts" name="selectedProducts" value="">

                    <!-- Products Section in Modal -->
                    <div class="products-container" style="max-height: 300px; overflow-y: auto;">
                        <c:forEach var="product" items="${requestScope.productsForAdd}">
                            <c:set var="isComingSoon" value="false" />
                            <c:forEach items="${requestScope.ComingSoon}" var="coming">
                                <c:if test="${product.productID == coming.productID}">
                                    <c:set var="isComingSoon" value="true" />
                                </c:if>
                            </c:forEach>

                            <div class="product-card ${isComingSoon ? 'coming-soon' : ''}" data-id="${product.productID}" data-category="${product.catID}" data-name="${product.productName.toLowerCase()}" 
                                 onclick="${isComingSoon ? 'event.stopPropagation()' : 'toggleSelection(this)'}">
                                <c:forEach items="${sessionScope.images}" var="i">
                                    <c:if test="${i.productID == product.productID}">
                                        <img src="${i.productImgUrl}" alt="${product.productName}">
                                    </c:if>
                                </c:forEach>
                                <div class="product-name">${product.productName}</div>
                                <div class="product-price">
                                    <c:if test="${isComingSoon}">
                                        Coming Soon
                                    </c:if>
                                    <c:if test="${!isComingSoon}">
                                        <fmt:formatNumber value="${product.price}" pattern="#,##0" currencySymbol="" />đ
                                    </c:if>
                                </div>
                                <div class="product-stock">
                                    <c:if test="${isComingSoon}">
                                        Coming Soon
                                    </c:if>
                                    <c:if test="${!isComingSoon}">
                                        Stock: ${product.quantity}
                                    </c:if>
                                </div>
                                <div class="remove-icon" onclick="removeSelection(event, this)">×</div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Modal Buttons -->
                    <div style="text-align: right; margin-top: 20px;">
                        <label for="discountPrice" style="margin-top: 20px">Discount Price (%)</label>
                        <input type="number" id="discountPrice" style="width: 150px; margin-bottom: 30px; font-size: 15px; margin-right: 50px" name="discountPrice" placeholder="Enter discount price" min="1" max="100" required>
                        <button type="submit" class="save-btn">Add Selected Products</button>
                        <button type="button" class="cancel-btn" onclick="closeAddProductModal()">Cancel</button>
                    </div>
                </form>
            </div>

            <script>
                function openAddProductModal() {
                    document.getElementById("addProductModal").style.display = "block";
                }

                function closeAddProductModal() {
                    document.getElementById("addProductModal").style.display = "none";
                }

                function toggleSelection(card) {
                    card.classList.toggle("selected"); // Toggle selected class to change color
                    updateSelectedProducts();
                }

                function removeSelection(event, icon) {
                    event.stopPropagation(); // Prevent the card's click event from firing
                    icon.closest(".product-card").classList.remove("selected");
                    updateSelectedProducts();
                }

                function updateSelectedProducts() {
                    const selectedProducts = [];
                    const selectedCards = document.querySelectorAll(".product-card.selected");
                    selectedCards.forEach(card => {
                        const productId = card.getAttribute("data-id");
                        selectedProducts.push(productId); // Add the product ID to the array
                    });
                    document.getElementById("selectedProducts").value = selectedProducts.join(","); // Join IDs with commas
                }

                function filterModalProducts() {
                    const categoryFilter = document.getElementById("modalCategoryFilter").value;
                    const searchQuery = document.getElementById("modalProductSearch").value.toLowerCase();
                    const modalProducts = document.querySelectorAll("#addProductModal .product-card");

                    modalProducts.forEach(product => {
                        const productCategory = product.getAttribute("data-category");
                        const productName = product.getAttribute("data-name");
                        const matchesCategory = categoryFilter === "all" || productCategory === categoryFilter;
                        const matchesSearch = productName.includes(searchQuery);

                        if (matchesCategory && matchesSearch) {
                            product.style.display = "block";
                        } else {
                            product.style.display = "none";
                        }
                    });
                }
            </script>
            <%-- Modal for Editing Discount Rate --%>
            <div id="editModal" class="modal" style="display: none;">
                <div class="modal-content">
                    <span class="close-btn" onclick="closeEditModal()">&times;</span>
                    <h3>Edit Discount Rate</h3>
                    <form id="discountRateForm" action="UpdateDiscountRate" method="POST">
                        <label for="discountRateInput">Discount Rate (%):</label>
                        <input type="number" id="discountRateInput" name="discountRateInput" min="1" max="100" required>
                        <input type="hidden" id="productIdInput" name="productIdInput">
                        <input type="hidden" id="promotionIdInput" name="promotionIdInput" value="${requestScope.PromotionForEdit.promotionID}">
                        <div class="modal-actions">
                            <button type="submit" class="save-btn">Save</button>
                            <button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
            <script>
                function openEditModal(productId, currentRate) {
                    document.getElementById("productIdInput").value = productId;
                    document.getElementById("discountRateInput").value = currentRate;
                    document.getElementById("editModal").style.display = "flex";
                }

                function closeEditModal() {
                    document.getElementById("editModal").style.display = "none";
                }

                function removeProduct(productId) {
                    if (confirm("Are you sure you want to remove this product from the promotion?")) {
                        // Redirect to the delete URL with the product ID
                        window.location.href = "RemoveProduct?productId=" + productId + "&proid=${requestScope.PromotionForEdit.promotionID}";
                    }
                }

                function deletePromotion() {
                    if (confirm("Are you sure you want to delete this promotion? This action cannot be undone.")) {
                        // Logic to delete the promotion
                        document.forms[0].action = "DeletePromotion?proid=${requestScope.PromotionForEdit.promotionID}";
                        document.forms[0].submit();
                    }
                }

                function backToDashboard() {
                    window.location.href = "MarketerDashboard"; // Redirect to your dashboard page
                }
            </script>
        </div>
    </body>
</html>
