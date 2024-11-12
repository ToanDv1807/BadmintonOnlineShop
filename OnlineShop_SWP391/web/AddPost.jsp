<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Post</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 20px;
            }
            form {
                max-width: 600px;
                margin: auto;
                background-color: #f4f4f4;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
            }
            input[type="text"], input[type="file"], select, textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .button-group {
                display: flex;                  /* Use flexbox for layout */
                flex-direction: column;        /* Stack elements vertically */
                align-items: flex-start;       /* Align items to the start */
                margin-top: 20px;              /* Add space above the button group */
            }

            .action-buttons {
                display: flex;                  /* Use flexbox for action buttons */
                gap: 10px;                     /* Add space between buttons */
            }

            .btn-add-subtitle {
                background-color: #28a745; /* Green background for Add Subtitle */
                color: white;               /* White text color */
                border: none;               /* Remove default border */
                padding: 10px 15px;        /* Add padding */
                border-radius: 4px;        /* Rounded corners */
                cursor: pointer;            /* Pointer cursor on hover */
                font-size: 0.9rem;          /* Adjust font size */
            }

            .btn-add-subtitle:hover {
                background-color: #218838; /* Darker green on hover */
            }

            .btn-submit {
                background-color: #007bff; /* Blue background for Submit Post */
                color: white;               /* White text color */
                border: none;               /* Remove default border */
                padding: 10px 15px;        /* Add padding */
                border-radius: 4px;        /* Rounded corners */
                cursor: pointer;            /* Pointer cursor on hover */
                font-size: 0.9rem;          /* Adjust font size */
            }

            .btn-submit:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }

            .btn-back {
                display: inline-flex;        /* Use inline-flex for alignment */
                align-items: center;        /* Center vertically */
                background-color: #007bff; /* Blue background for Back button */
                color: white;               /* White text color */
                padding: 10px 15px;        /* Add padding */
                border-radius: 4px;        /* Rounded corners */
                text-decoration: none;      /* Remove underline */
                font-size: 0.9rem;          /* Adjust font size */
            }

            .btn-back:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }

            .btn-remove-subtitle {
                background-color: #dc3545;
            }
            input[type="submit"]:hover {
                background-color: #218838;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .subtitle-group {
                border: 1px solid #ccc;
                padding: 15px;
                margin-top: 15px;
                border-radius: 8px;
                background-color: #fff;
                position: relative;
            }
            .subtitle-group .btn-remove-subtitle {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            img.preview {
                display: block;
                max-width: 100px;
                margin-top: 10px;
            }
            h2 {
                text-align: center; /* Center the text */
                color: #28a745; /* Set the text color (green) */
                margin-top: 20px; /* Add some space above the heading */
                margin-bottom: 15px; /* Add some space below the heading */
                font-size: 24px; /* Set the font size */
                font-weight: normal; /* Make the font weight normal */
            }

            .radio-group {
                display: flex;
                align-items: center;
            }

            .radio-group input[type="radio"] {
                margin-right: 5px;
            }

            .radio-group label {
                margin-right: 20px;
            }
        </style>
    </head>
    <body>
        <h1>Add New Post</h1>
        <h2 style="color: green">${requestScope.message}</h2>
        <form action="AddPostServlet" method="POST" enctype="multipart/form-data" id="postForm">
            <div class="form-group">
                <label for="title">Post Title:</label>
                <input type="text" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="thumbnail">Thumbnail Image:</label>
                <input type="file" id="thumbnail" name="thumbnail" accept="image/*" required onchange="previewImage(this, 'thumbnail-preview')">
                <img id="thumbnail-preview" class="preview" style="display:none;" />
            </div>

            <div class="form-group">
                <label for="category">Select Category:</label>
                <select id="category" name="category" required>
                    <option value="">-- Select Category --</option>
                    <c:forEach items="${sessionScope.cateBlogs}" var="sc">
                        <option value="${sc.categoryID}" 
                                ${sessionScope.categoryTag == sc.categoryID ? 'selected' : ''}>
                            ${sc.categoryName}
                        </option>                
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="content">Post Content:</label>
                <textarea id="content" name="content" rows="8" required></textarea>
            </div>
            <div class="form-group">
                <label for="status">Post Status:</label>
                <div class="radio-group">
                    <input type="radio" id="status-on" name="status" value="1" checked>
                    <label for="status-on">Show</label>

                    <input type="radio" id="status-off" name="status" value="0">
                    <label for="status-off">Hide</label>
                </div>
            </div>
            <!-- Subtitle sections will be added here -->
            <div id="subtitleContainer"></div>

            <div class="button-group">
                <button type="button" class="btn-add-subtitle" id="addSubtitleBtn" style="margin-bottom: 10px">
                    <i class="fas fa-plus"></i> Add Subtitle
                </button>

                <div class="action-buttons">
                    <input type="submit" value="Submit Post" class="btn-submit" style="margin-right: 5px">
                    <a href="MarketerDashboard" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </form>

        <script>
            let subtitleCount = 0;

            document.getElementById('addSubtitleBtn').addEventListener('click', function () {
                subtitleCount++;

                const subtitleDiv = document.createElement('div');
                subtitleDiv.classList.add('subtitle-group');
                subtitleDiv.id = 'subtitle-group-' + subtitleCount;

                subtitleDiv.innerHTML = `
                    <div class="form-group">
                        <label for="subtitle-${subtitleCount}">Subtitle Title:</label>
                        <input type="text" id="subtitle-${subtitleCount}" name="subtitles[${subtitleCount}][title]" required>
                    </div>
                    <div class="form-group">
                        <label for="subtitle-thumbnail-${subtitleCount}">Subtitle Thumbnail:</label>
                        <input type="file" id="subtitle-thumbnail-${subtitleCount}" name="subtitles[${subtitleCount}][thumbnail]" accept="image/*">
                    </div>
                    <div class="form-group">
                        <label for="subtitle-content-${subtitleCount}">Subtitle Content:</label>
                        <textarea id="subtitle-content-${subtitleCount}" name="subtitles[${subtitleCount}][content]" rows="4" required></textarea>
                    </div>
                    <button type="button" class="btn-remove-subtitle">Delete Subtitle</button>
                `;

                document.getElementById('subtitleContainer').appendChild(subtitleDiv);

                subtitleDiv.querySelector('.btn-remove-subtitle').addEventListener('click', function () {
                    subtitleDiv.remove();
                });
            });
        </script>
    </body>
</html>
