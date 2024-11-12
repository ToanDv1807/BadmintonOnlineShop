<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add New Promotion</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            label {
                font-weight: bold;
                display: block;
                margin: 10px 0 5px;
            }
            input[type="text"], input[type="date"], textarea, select {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .button-container {
                display: flex;
                justify-content: space-between;
            }
            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
                color: white;
                background-color: #28a745;
            }
            .btn.cancel {
                background-color: #dc3545;
            }
            .container {
                max-width: 600px; /* Maintain the same max width as the form */
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            @media (max-width: 768px) {
                .products-container {
                    grid-template-columns: repeat(3, 1fr); /* 3 cards per row on smaller screens */
                }
            }

            @media (max-width: 480px) {
                .products-container {
                    grid-template-columns: repeat(2, 1fr); /* 2 cards per row on very small screens */
                }
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Add New Promotion</h1>

            <form action="AddPromotionServlet" method="POST">
                <!-- Promotion Name -->
                <label for="promotionName">Promotion Name</label>
                <input type="text" id="promotionName" name="promotionName" required>

                <!-- Start Date -->
                <label for="startDate">Start Date</label>
                <input type="date" id="startDate" name="startDate" required>

                <!-- End Date -->
                <label for="endDate">End Date</label>
                <input type="date" id="endDate" name="endDate" required>

                <!-- Description -->
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4"></textarea>

                <!-- Status -->
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="1">Active</option>
                    <option value="0">Inactive</option>
                </select>

                <!-- Note -->
                <label for="note">Note</label>
                <textarea id="note" name="note" rows="4"></textarea>

                <input type="hidden" id="selectedProducts" name="selectedProducts">
                <h3>Select Products for Promotion</h3>
                <!-- Filter and Search Section -->
                <div class="filter-search-container">
                    <!-- Category Filter -->
                    <label for="categoryFilter">Category:</label>
                    <select id="categoryFilter" style="margin-bottom: 0px; width: 150px" onchange="filterProducts()">
                        <option value="all">All Categories</option>
                        <c:forEach var="category" items="${sessionScope.categories}">
                            <option value="${category.catID}">${category.catName}</option>
                        </c:forEach>
                    </select>

                    <!-- Search by Name -->
                    <label for="productSearch">Search:</label>
                    <input type="text" id="productSearch" style="margin-bottom: 0px" placeholder="Search by product name" onkeyup="filterProducts()">
                </div>

                <!-- Products Section -->
                <div class="products-container">
                    <c:forEach var="product" items="${sessionScope.products}">
                        <div class="product-card" data-id="${product.productID}" data-category="${product.catID}" data-name="${product.productName.toLowerCase()}" onclick="toggleSelection(this)">
                            <c:forEach items="${sessionScope.images}" var="i">
                                <c:if test="${i.productID == product.productID}">
                                    <img src="${i.productImgUrl}" alt="${product.productName}">
                                </c:if>
                            </c:forEach>
                            <div class="product-name">${product.productName}</div>
                            <div class="product-price">
                                <fmt:formatNumber value="${product.price}" pattern="#,##0" currencySymbol="" />đ
                            </div>
                            <div class="product-stock">Stock: ${product.quantity}</div>
                            <div class="remove-icon" onclick="removeSelection(event, this)">×</div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Discount Price -->
                <label for="discountPrice" style="margin-top: 20px">Discount Price (%)</label>
                <input type="number" id="discountPrice" style="width: 150px; margin-bottom: 30px; font-size: 15px" name="discountPrice" placeholder="Enter discount price" min="1" max="100" required>

                <!-- Buttons -->
                <div class="button-container">
                    <button type="submit" class="btn">Save Promotion</button>
                    <a href="MarketerDashboard" style="text-decoration: none" class="btn cancel">Cancel</a>
                </div>
            </form>
        </div>
        <script>
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

            function filterProducts() {
                const categoryFilter = document.getElementById("categoryFilter").value;
                const searchQuery = document.getElementById("productSearch").value.toLowerCase();
                const products = document.querySelectorAll(".product-card");
                products.forEach(product => {
                    const productCategory = product.getAttribute("data-category");
                    const productName = product.getAttribute("data-name");
                    const matchesCategory = categoryFilter === "all" || productCategory === categoryFilter;
                    const matchesSearch = productName.includes(searchQuery);
                    // Show or hide product based on filter criteria
                    if (matchesCategory && matchesSearch) {
                        product.style.display = "block";
                    } else {
                        product.style.display = "none";
                    }
                });
            }
        </script>
    </body>
</html>
