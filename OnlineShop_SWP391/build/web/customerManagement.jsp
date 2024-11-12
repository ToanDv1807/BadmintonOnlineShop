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
    /* Button styles */
    .edit-btn {
        background-color: #28a745;
        color: white;
    }
    .status-btn {
        background-color: #ffc107;
        color: black;
    }
    /* Hover effect for buttons */
    .button:hover {
        opacity: 0.8;
    }
</style>

<div class="container">
    <header>
        <h1 style="margin-top: 10px">Customer Management</h1>
    </header>

    <form id="customerFilterForm" action="MarketerDashboard" method="GET">
        <div class="filters">
            <select id="statusFilterC" name="statusC">
                <option value="">All Statuses</option>
                <option value="1" ${sessionScope.statusTagC == "1" ? 'selected' : ''}>Contact</option>
                <option value="2" ${sessionScope.statusTagC == "2" ? 'selected' : ''}>Potential</option>
                <option value="3" ${sessionScope.statusTagC == "3" ? 'selected' : ''}>Customer</option>
            </select>
            <input type="text" placeholder="Search by Fullname, email or phone" id="searchTitleC" name="searchTitleC" 
                   value="${sessionScope.searchTagC != null ? sessionScope.searchTagC : ''}" style="width: 350px">
            <button type="submit" class="btn" id="customerSearchButton">Search</button>
        </div>
    </form>

    <table>
        <thead>
            <tr>
                <th>
                    <div class="sort-container">
                        <span>ID</span>
                        <span onclick="sortCustomerTable('id', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortCustomerTable('id', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Full Name</span>
                        <span onclick="sortCustomerTable('fullname', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortCustomerTable('fullname', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>Gender</th>
                <th>
                    <div class="sort-container">
                        <span>Email</span>
                        <span onclick="sortCustomerTable('email', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortCustomerTable('email', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Mobile</span>
                        <span onclick="sortCustomerTable('mobile', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortCustomerTable('mobile', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Status</span>
                        <span onclick="sortCustomerTable('status', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortCustomerTable('status', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>Note</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody id="customerList">
            <c:forEach items="${sessionScope.customersCL}" var="c">
                <tr class="customer-row" data-id="${c.customerID}" data-fullname="${c.fullName}" data-gender="${c.gender}" data-email="${c.email}" data-mobile="${c.phone}" data-status="${c.status}">
                    <td>${c.customerID}</td>
                    <td>${c.fullName}</td>
                    <td>
                        <c:if test="${c.gender == 1}">
                            Male
                        </c:if>
                        <c:if test="${c.gender == 0}">
                            Female
                        </c:if>
                    </td>
                    <td>${c.email}</td>
                    <td>${c.phone}</td>
                    <td>
                        <c:if test="${c.status == 1}">
                            Contact
                        </c:if>
                        <c:if test="${c.status == 2}">
                            Potential
                        </c:if>
                        <c:if test="${c.status == 3}">
                            Customer
                        </c:if>
                    </td>
                    <td>${c.note}</td>
                    <td style="height: 60px; width: 120px">
                        <div class="button-container">
                            <a href="edit-customer?cid=${c.customerID}" class="edit-btn button">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="view-customer?cid=${c.customerID}" class="view-btn button">
                                <i class="fas fa-eye"></i> View
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
                <c:forEach begin="1" end="${sessionScope.endPageCL}" var="i">
                    <li class="customer-page-item ${sessionScope.tagCL == i ? 'active' : ''}">
                        <a class="page-link" href="javascript:void(0);" onclick="changeCustomerPage(${i})">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<script>
    let currentCustomerPage = 1;
    const customersPerPage = 10;
    const customerRows = Array.from(document.querySelectorAll('.customer-row'));
    const totalCustomers = customerRows.length;

    function displayCustomers(page) {
        customerRows.forEach((row, index) => {
            row.style.display = 'none';
            if (index >= (page - 1) * customersPerPage && index < page * customersPerPage) {
                row.style.display = '';
            }
        });
    }

    function changeCustomerPage(page) {
        currentCustomerPage = page;
        displayCustomers(currentCustomerPage);
        updateCustomerPagination();
    }

    function updateCustomerPagination() {
        const paginationItems = document.querySelectorAll('.customer-page-item');
        paginationItems.forEach((item, index) => {
            item.classList.remove('active');
            if (index + 1 === currentCustomerPage) {
                item.classList.add('active');
            }
        });
    }

// Function to submit the form
    function submitCustomerForm() {
        document.getElementById("customerFilterForm").submit();
    }

// Event listener for select elements in customer filters
    document.querySelectorAll('.customer-filters select').forEach(function (select) {
        select.addEventListener('change', submitCustomerForm);
    });

// Event listener for customer search button
    document.getElementById('customerSearchButton').addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default form submission
        submitCustomerForm(); // Call the submitCustomerForm function
    });

    function sortCustomerTable(column, order) {
        customerRows.sort((a, b) => {
            let aText, bText;

            switch (column) {
                case 'id':
                    aText = parseInt(a.cells[0].textContent);
                    bText = parseInt(b.cells[0].textContent);
                    break;
                case 'fullname':
                    aText = a.cells[1].textContent.trim().toLowerCase();
                    bText = b.cells[1].textContent.trim().toLowerCase();
                    break;
                case 'email':
                    aText = a.cells[3].textContent.trim().toLowerCase();
                    bText = b.cells[3].textContent.trim().toLowerCase();
                    break;
                case 'mobile':
                    aText = parseFloat(a.cells[4].textContent.trim().replace(/\D/g, ''));
                    bText = parseFloat(b.cells[4].textContent.trim().replace(/\D/g, ''));
                    break;
                case 'status':
                    aText = getCustomerStatusValue(a.cells[5].textContent);
                    bText = getCustomerStatusValue(b.cells[5].textContent);
                    break;
                default:
                    return 0;
            }

            if (aText < bText)
                return order === 'asc' ? -1 : 1;
            if (aText > bText)
                return order === 'asc' ? 1 : -1;
            return 0;
        });

        const customerList = document.getElementById('customerList');
        customerList.innerHTML = '';
        customerRows.forEach(row => customerList.appendChild(row));
        displayCustomers(currentCustomerPage);
    }

    function getCustomerStatusValue(statusText) {
        switch (statusText.trim().toLowerCase()) {
            case 'contact':
                return 1;
            case 'potential':
                return 2;
            case 'customer':
                return 3;
            default:
                return 0;
        }
    }

// Initialize the first page display
    displayCustomers(currentCustomerPage);
</script>
