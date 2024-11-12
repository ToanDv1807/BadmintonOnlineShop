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
    .sort-icon {
        cursor: pointer;
        margin-left: 5px;
        font-size: 0.8em;
        color: white;
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
    .show-hide-btn {
        background-color: #ffc107;
        color: black;
    }
    .button:hover {
        opacity: 0.8;
    }
    .actions-column {
        text-align: center; /* Center the action buttons within the column */
    }
    td img {
        display: block; /* Đảm bảo hình ảnh không tạo ra khoảng trống bên dưới */
        width: 100%; /* Chiếm toàn bộ chiều ngang */
        height: auto; /* Giữ tỷ lệ khung hình */
    }
</style>

<div class="container">
    <header>
        <h1 style="margin-top: 10px">Slider Management</h1>
    </header>
    <form id="sliderFilterForm" action="MarketerDashboard" method="GET">
        <div class="filters">
            <select id="statusFilterS" name="statusS">
                <option value="">All Statuses</option>
                <option value="1" ${sessionScope.statusTagS == "1" ? 'selected' : ''}>Showed</option>
                <option value="0" ${sessionScope.statusTagS == "0" ? 'selected' : ''}>Hidden</option>
            </select>
            <input type="text" placeholder="Search by Title or Backlink" id="searchTitleS" name="searchTitleS" 
                   value="${sessionScope.searchTagS != null ? sessionScope.searchTagS : ''}" style="width: 350px">
            <button type="submit" class="btn" id="sliderSearchButton">Search</button>
        </div>
    </form>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Image</th>
                <th>Backlink</th>
                <th>Status</th>
                <th>Note</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody id="sliderList">
            <c:forEach items="${sessionScope.slidersSL}" var="s">
                <tr class="slider-row" data-id="${s.sliderID}" data-title="${s.title}" data-backlink="${s.backlink}" data-status="${s.status}">
                    <td>${s.sliderID}</td>
                    <td style="width: 150px">${s.title}</td>
                    <td style="width: 140px">
                        <img src="assets/images/product-section-slider/${s.sliderImgUrl}" alt="${s.title}" style="width: 100%; height: 60px; display: block; margin: 0;">
                    </td>
                    <td style="width: 200px">${s.backlink}</td>
                    <td style="width: 100px">
                        <c:if test="${s.status == 1}">
                            Showed
                        </c:if>
                        <c:if test="${s.status == 0}">
                            Hidden
                        </c:if>
                    </td>
                    <td style="width: 200px">
                        ${s.notes}
                    </td>
                    <td class="actions-column">
                        <div class="button-container">
                            <a href="slider-detail?sid=${s.sliderID}" class="edit-btn button">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="set-status-slider?sid=${s.sliderID}&status=${s.status}" class="show-hide-btn button">
                                <i class="fas ${s.status == 1 ? 'fa-eye-slash' : 'fa-eye'}"></i> ${s.status == 1 ? 'Hide' : 'Show'}
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>

    </table>

    <div style="height: 80px; color: black; display: flex; align-items: center; justify-content: center;">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination">
                <c:forEach begin="1" end="${sessionScope.endPageSL}" var="i">
                    <li class="slider-page-item ${sessionScope.tagSL == i ? 'active' : ''}">
                        <a class="page-link" href="javascript:void(0);" onclick="changeSliderPage(${i})">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<script>
    let currentSliderPage = 1;
    const slidersPerPage = 10;
    const sliderRows = Array.from(document.querySelectorAll('.slider-row'));
    const totalSliders = sliderRows.length;

    function displaySliders(page) {
        sliderRows.forEach((row, index) => {
            row.style.display = 'none';
            if (index >= (page - 1) * slidersPerPage && index < page * slidersPerPage) {
                row.style.display = '';
            }
        });
    }

    function changeSliderPage(page) {
        currentSliderPage = page;
        displaySliders(currentSliderPage);
        updateSliderPagination();
    }

    function updateSliderPagination() {
        const paginationItems = document.querySelectorAll('.slider-page-item');
        paginationItems.forEach((item, index) => {
            item.classList.remove('active');
            if (index + 1 === currentSliderPage) {
                item.classList.add('active');
            }
        });
    }

// Function to submit the form
    function submitSliderForm() {
        document.getElementById("sliderFilterForm").submit();
    }

// Event listener for select elements in slider filters
    document.querySelectorAll('.slider-filters select').forEach(function (select) {
        select.addEventListener('change', submitSliderForm);
    });

// Event listener for slider search button
    document.getElementById('sliderSearchButton').addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default form submission
        submitSliderForm(); // Call the submitSliderForm function
    });

// Initialize the first page display
    displaySliders(currentSliderPage);
</script>
