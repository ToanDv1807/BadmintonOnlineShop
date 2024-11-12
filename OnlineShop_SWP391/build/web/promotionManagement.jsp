<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .pagination {
        display: flex;
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .page-item.active .page-link {
        font-weight: bold;
    }
    .sort-container {
        display: flex;
        align-items: center;
    }

    .button-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }
    .button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 8px 12px;
        margin-right: 4px;
        border: 1px solid transparent;
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.6rem;
        text-decoration: none;
    }
    .edit-btn {
        background-color: #28a745;
        color: white;
    }
    .button:hover {
        opacity: 0.8;
    }
    .actions-column {
        text-align: center;
    }
</style>

<div class="container">
    <header>
        <h1 style="margin-top: 10px">Promotion Management</h1>
        <a href="AddPromotion.jsp" class="btn add-post" style="margin-top: 10px">Add New Promotion</a>
    </header>
    <form id="promotionFilterForm" action="MarketerDashboard" method="GET">
        <div class="filters">
            <select id="statusFilterPromotion" name="statusPromotion">
                <option value="">All Statuses</option>
                <option value="1" ${sessionScope.statusTagPromotion == "1" ? 'selected' : ''}>Active</option>
                <option value="0" ${sessionScope.statusTagPromotion == "0" ? 'selected' : ''}>Inactive</option>
            </select>
            <input type="text" placeholder="Search by Name or Description" id="searchTitlePromotion" name="searchTitlePromotion" 
                   value="${sessionScope.searchTagPromotion != null ? sessionScope.searchTagPromotion : ''}" style="width: 350px">
            <button type="submit" class="btn" id="promotionSearchButton">Search</button>
        </div>
    </form>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Description</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody id="promotionList">
            <c:forEach items="${sessionScope.promotions}" var="p">
                <tr>
                    <td>${p.promotionID}</td>
                    <td style="width: 180px">${p.name}</td>
                    <td style="width: 120px">${p.startDate.substring(0, 10)}</td>
                    <td style="width: 120px">${p.endDate.substring(0, 10)}</td>
                    <td style="width: 250px">${p.description}</td>
                    <td style="width: 100px">
                        <c:choose>
                            <c:when test="${p.status == 1}">Active</c:when>
                            <c:otherwise>Inactive</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="actions-column">
                        <div class="button-container">
                            <a href="promotion-view?proid=${p.promotionID}" class="view-btn button">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="promotion-edit?proid=${p.promotionID}" class="edit-btn button">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div style="height: 80px; display: flex; align-items: center; justify-content: center;">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination">
                <c:forEach begin="1" end="${sessionScope.endPagePromotion}" var="i">
                    <li class="page-item ${sessionScope.tagPromotion == i ? 'active' : ''}">
                        <a class="page-link" href="javascript:void(0);" onclick="changePromotionPage(${i})">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<script>
    let currentPromotionPage = 1;
    const promotionsPerPage = 10;
    const promotionRows = Array.from(document.querySelectorAll('.promotion-row'));
    const totalPromotions = promotionRows.length;

    function displayPromotions(page) {
        promotionRows.forEach((row, index) => {
            row.style.display = 'none';
            if (index >= (page - 1) * promotionsPerPage && index < page * promotionsPerPage) {
                row.style.display = '';
            }
        });
    }

    function changePromotionPage(page) {
        currentPromotionPage = page;
        displayPromotions(currentPromotionPage);
        updatePromotionPagination();
    }

    function updatePromotionPagination() {
        const paginationItems = document.querySelectorAll('.page-item');
        paginationItems.forEach((item, index) => {
            item.classList.remove('active');
            if (index + 1 === currentPromotionPage) {
                item.classList.add('active');
            }
        });
    }

    function submitPromotionForm() {
        document.getElementById("promotionFilterForm").submit();
    }

    document.getElementById('promotionSearchButton').addEventListener('click', function (event) {
        event.preventDefault();
        submitPromotionForm();
    });

    displayPromotions(currentPromotionPage);
</script>
