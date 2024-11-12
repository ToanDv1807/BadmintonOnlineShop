<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- postManagement.jsp -->
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
        display: flex;              /* Use flexbox for alignment */
        align-items: center;       /* Vertically center items */
    }

    .sort-icon {
        cursor: pointer;           /* Change cursor to pointer for sorting icons */
        margin-left: 5px;         /* Space between text and icon */
        font-size: 0.8em;         /* Adjust size as needed */
        color: white;           /* Change color as needed */
    }

    .button-container {
        display: flex;  /* Maintain flex display */
        justify-content: center; /* Center buttons horizontally */
        align-items: center;     /* Center buttons vertically */
        height: 100%;   /* Ensures it matches the height of the <td> */
    }

    .button {
        display: inline-flex; /* Display buttons in inline-flex */
        align-items: center;  /* Center vertically */
        justify-content: center; /* Center horizontally */
        padding: 8px 12px;    /* Padding inside buttons */
        margin-right: 4px;    /* Spacing between buttons */
        border: 1px solid transparent; /* Border settings */
        border-radius: 4px;    /* Rounded corners */
        cursor: pointer;        /* Pointer cursor on hover */
        font-size: 0.6rem;    /* Font size */
        text-decoration: none;  /* No underline */
    }

    /* Button styles remain the same */
    .view-btn {
        background-color: #007bff; /* Background color for view button */
        color: white;               /* Text color */
    }

    .edit-btn {
        background-color: #28a745; /* Background color for edit button */
        color: white;               /* Text color */
    }

    .status-btn {
        background-color: #ffc107; /* Background color for status button */
        color: black;               /* Text color */
    }

    /* Hover effect for buttons */
    .button:hover {
        opacity: 0.8; /* Slight transparency on hover */
    }
</style>

</style>
<div class="container">
    <header>
        <h1 style="margin-top: 10px">Post Management</h1>
        <a href="AddPost.jsp" class="btn add-post" style="margin-top: 10px">Add New Post</a>
    </header>
    <form id="filterForm" action="MarketerDashboard" method="GET">
        <div class="filters">
            <select id="categoryFilter" name="category">
                <option value="">All Categories</option>
                <c:forEach items="${sessionScope.cateBlogs}" var="sc">
                    <option value="${sc.categoryID}" 
                            ${sessionScope.categoryTag == sc.categoryID ? 'selected' : ''}>
                        ${sc.categoryName}
                    </option>                
                </c:forEach>
            </select>
            <select id="authorFilter" name="author">
                <option value="">All Authors</option>
                <c:forEach items="${sessionScope.marketers}" var="m">
                    <option value="${m.employeeID}" ${sessionScope.authorTag == m.employeeID ? 'selected' : ''}>${m.fullName}</option>
                </c:forEach>
            </select>
            <select id="statusFilter" name="status">
                <option value="">All Statuses</option>
                <option value="1" ${sessionScope.statusTag == "1" ? 'selected' : ''}>Showed</option>
                <option value="0" ${sessionScope.statusTag == "0" ? 'selected' : ''}>Hidden</option>
            </select>
            <input type="text" placeholder="Search by Title" id="searchTitle" name="searchTitle" 
                   value="${sessionScope.searchTag != null ? sessionScope.searchTag : ''}">
            <button type="submit" class="btn" id="searchButton">Search</button>
        </div>
    </form>

    <table>
        <thead>
            <tr>
                <th>
                    <div class="sort-container">
                        <span>ID</span>
                        <span onclick="sortTable('id', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('id', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>Thumbnail</th>
                <th>
                    <div class="sort-container">
                        <span>Title</span>
                        <span onclick="sortTable('title', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('title', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Category</span>
                        <span onclick="sortTable('category', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('category', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Author</span>
                        <span onclick="sortTable('author', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('author', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Featured</span>
                        <span onclick="sortTable('featured', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('featured', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>
                    <div class="sort-container">
                        <span>Status</span>
                        <span onclick="sortTable('status', 'asc')" class="sort-icon">↑</span>
                        <span onclick="sortTable('status', 'desc')" class="sort-icon">↓</span>
                    </div>
                </th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody id="postList">
            <c:forEach items="${sessionScope.blogs}" var="b">
                <tr class="post-row" data-id="${b.blogId}" data-title="${b.title}" data-category="${b.categoryID}" data-author="${b.employeeID}" data-featured="${b.featureStatus}" data-status="${b.status}">
                    <td>${b.blogId}</td>
                    <td><img src="assets/images/blog/BlogImg/${b.blogImgUrl}" alt="Thumbnail" class="thumbnail"></td>
                    <td style="font-size: 0.9rem;">${b.title}</td>
                    <td>
                        <c:forEach items="${sessionScope.cateBlogs}" var="c">
                            <c:if test="${c.categoryID == b.categoryID}">${c.categoryName}</c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach items="${sessionScope.employees}" var="e">
                            <c:if test="${e.employeeID == b.employeeID}">${e.fullName}</c:if>
                        </c:forEach>
                    </td>
                    <td>${b.featureStatus == 1 ? 'Yes' : 'No'}</td>
                    <td>${b.status == 1 ? 'Showed' : 'Hidden'}</td>
                    <td style="height: 60px; width: 120px">
                        <div class="button-container d-flex justify-content-center align-items-center" style="height: 100%;">
                            <a href="blog-detail?bid=${b.blogId}" class="view-btn button">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="post-detail?bid=${b.blogId}" class="edit-btn button">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="set-status?setStatus=${b.status == 1 ? 0 : 1}&bid=${b.blogId}" class="status-btn button">
                                <i class="fas fa-eye-slash"></i> ${b.status == 1 ? 'Hide' : 'Show'}
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
                <c:forEach begin="1" end="${sessionScope.endPage}" var="i">
                    <li class="page-item ${sessionScope.tag == i ? 'active' : ''}">
                        <a class="page-link" href="javascript:void(0);" onclick="changePage(${i})">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<script>
    let currentPage = 1; // Initialize current page
    const postsPerPage = 10; // Number of posts per page
    const postRows = Array.from(document.querySelectorAll('.post-row')); // Get all post rows
    const totalPosts = postRows.length; // Get total number of posts

    function displayPosts(page) {
        // Hide all posts
        postRows.forEach((row, index) => {
            row.style.display = 'none'; // Hide all rows initially
            if (index >= (page - 1) * postsPerPage && index < page * postsPerPage) {
                row.style.display = ''; // Show posts for the current page
            }
        });
    }

    function changePage(page) {
        currentPage = page; // Update current page
        displayPosts(currentPage); // Display posts for the current page
        updatePagination(); // Update pagination styles
    }

    function updatePagination() {
        const paginationItems = document.querySelectorAll('.page-item');
        paginationItems.forEach((item, index) => {
            item.classList.remove('active');
            if (index + 1 === currentPage) {
                item.classList.add('active'); // Highlight the current page
            }
        });
    }

    // Function to submit the form
    function submitForm() {
        document.getElementById("filterForm").submit();
    }

    // Event listener for select elements
    document.querySelectorAll('.filters select').forEach(function (select) {
        select.addEventListener('change', submitForm);
    });

    // Event listener for search button
    document.getElementById('searchButton').addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default form submission
        submitForm(); // Call the submitForm function
    });

    function sortTable(column, order) {
        // Sort rows based on the specified column and order
        postRows.sort((a, b) => {
            let aText, bText;

            switch (column) {
                case 'id':
                    aText = parseInt(a.cells[0].textContent);
                    bText = parseInt(b.cells[0].textContent);
                    break;
                case 'title':
                    aText = a.cells[2].textContent.toLowerCase();
                    bText = b.cells[2].textContent.toLowerCase();
                    break;
                case 'category':
                    aText = a.cells[3].textContent.toLowerCase();
                    bText = b.cells[3].textContent.toLowerCase();
                    break;
                case 'author':
                    aText = a.cells[4].textContent.toLowerCase();
                    bText = b.cells[4].textContent.toLowerCase();
                    break;
                case 'featured':
                    aText = a.cells[5].textContent === 'Yes' ? 1 : 0;
                    bText = b.cells[5].textContent === 'Yes' ? 1 : 0;
                    break;
                case 'status':
                    aText = a.cells[6].textContent === 'Showed' ? 1 : 0;
                    bText = b.cells[6].textContent === 'Showed' ? 1 : 0;
                    break;
            }

            return order === 'asc' ? (aText > bText ? 1 : -1) : (aText < bText ? 1 : -1);
        });

        // Clear the existing rows and append sorted rows
        const postList = document.getElementById("postList");
        postList.innerHTML = ''; // Clear the current post list
        postRows.forEach(row => postList.appendChild(row)); // Append sorted rows

        // Reset current page and display posts for the first page
        currentPage = 1;
        displayPosts(currentPage);
        updatePagination(); // Update pagination based on the total number of posts
    }

    // Initial display of posts
    displayPosts(currentPage);
</script>

