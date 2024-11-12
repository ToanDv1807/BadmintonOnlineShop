<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>Add New Post</title>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                margin: 20px;
                background-color: #f7f7f7;
            }

            form {
                max-width: 600px;
                margin: auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            h1, h2 {
                text-align: center;
                color: #333;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 20px;
            }

            h2 {
                color: #28a745;
                font-size: 20px;
                margin-top: 15px;
                margin-bottom: 20px;
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
                font-size: 14px;
            }

            .delete-post-btn {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
                transition: background-color 0.3s;
            }


            .btn-remove-subtitle {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 12px;
                transition: background-color 0.3s;
            }

            .btn-remove-subtitle:hover {
                background-color: #c82333;
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

            .delete-post-container {
                text-align: right;
            }

            .post-title-container {
                display: flex;
                flex-direction: column;
            }

            .label-delete-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 8px;
            }

            .label-delete-container label {
                margin-right: 10px;
                flex-grow: 1;
            }

            .post-title-container label {
                margin-right: 10px;
                flex-grow: 1;
                font-size: 16px;
            }

            .post-title-container input[type="text"] {
                flex-grow: 2;
                margin-right: 10px;
            }

            .delete-post-btn {
                background-color: #dc3545;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 12px;
                transition: background-color 0.3s;
            }

            .delete-post-btn:hover {
                background-color: #c82333;
            }

            .button-group {
                text-align: center;
            }

            @media (max-width: 768px) {
                .post-title-container {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .post-title-container input[type="text"] {
                    margin-right: 0;
                    margin-bottom: 10px;
                }

                .delete-post-btn {
                    align-self: flex-end;
                }
            }

            @media (max-width: 480px) {
                input[type="submit"], .btn-back, .btn-add-subtitle, .delete-post-btn {
                    width: 100%;
                    padding: 10px;
                    font-size: 14px;
                }

                .post-title-container {
                    text-align: center;
                }

                .delete-post-btn {
                    margin-top: 10px;
                }
            }
            .label-delete-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
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
            .switch {
                position: relative;
                display: inline-block;
                width: 60px;
                height: 34px;
            }

            .switch input {
                display: none;
            }

            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
            }

            .slider:before {
                position: absolute;
                content: "";
                height: 26px;
                width: 26px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
            }

            input:checked + .slider {
                background-color: #4CAF50;
            }

            input:checked + .slider:before {
                transform: translateX(26px);
            }

            .slider.round {
                border-radius: 34px;
            }

            .slider.round:before {
                border-radius: 50%;
            }
        </style>
    </head>
    <body>
        <h1>Edit Post</h1>
        <h2 style="color: green">${requestScope.message}</h2>
        <form action="edit-post?postId=${sessionScope.blogForEdit.blogId}" method="POST" enctype="multipart/form-data" id="postForm">
            <div class="form-group post-title-container">
                <div class="label-delete-container">
                    <label for="title">Post Title:</label>
                    <button type="button" class="delete-post-btn" id="deletePostBtn">
                        <i class="fas fa-trash"></i> Delete Post
                    </button>
                </div>
                <input type="text" id="title" name="title" value="${sessionScope.blogForEdit.title}" required>
            </div>
            <div class="form-group">
                <label for="thumbnail">Thumbnail Image:</label>
                <img src="assets/images/blog/BlogImg/${sessionScope.blogForEdit.blogImgUrl}" width="100%" height="100%" alt="alt"/>
                <input type="file" id="thumbnail" name="thumbnail" accept="image/*" onchange="previewImage(this, 'thumbnail-preview')">
                <img id="thumbnail-preview" class="preview" style="display:none;"/>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <c:forEach items="${sessionScope.cateBlogs}" var="sc">
                        <option value="${sc.categoryID}" 
                                ${sessionScope.blogForEdit.categoryID == sc.categoryID ? 'selected' : ''}>
                            ${sc.categoryName}
                        </option>                
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="brief-info">Post Brief-Info:</label>
                <textarea id="brief-info" name="brief-info" rows="4" required>${sessionScope.blogForEdit.briefInfo}</textarea>
            </div>
            <div class="form-group">
                <label for="content">Post Content:</label>
                <textarea id="content" name="content" rows="8" required>${sessionScope.blogForEdit.content}</textarea>
            </div>
            <div class="form-group">
                <label for="featured">Featured:</label>
                <div>
                    <select id="featured" name="featured">
                        <option value="0" <c:if test="${sessionScope.blogForEdit.featureStatus == 0}">selected</c:if>>No</option>
                        <option value="1" <c:if test="${sessionScope.blogForEdit.featureStatus == 1}">selected</c:if>>Yes</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="Status">Status:</label>
                    <div>
                        <select id="statusSelect" name="Status">
                            <option value="0" <c:if test="${sessionScope.blogForEdit.status == 0}">selected</c:if>>Hide</option>
                        <option value="1" <c:if test="${sessionScope.blogForEdit.status == 1}">selected</c:if>>Show</option>
                        </select>
                    </div>
                </div>
                <!-- Existing Subtitles -->
            <c:forEach items="${sessionScope.subtitleForEdit}" var="s" varStatus="status">
                <div class="subtitle-group" id="subtitle-group-${status.index}">
                    <input type="hidden" name="existingSubtitles[${status.index}][id]" value="${s.subtitleID}">
                    <div class="form-group">
                        <label for="existing-subtitle-${status.index}">Subtitle Title:</label>
                        <input type="text" id="existing-subtitle-${status.index}" name="existingSubtitles[${status.index}][title]" value="${s.subtitle}" required>
                    </div>
                    <div class="form-group">
                        <label for="existing-subtitle-thumbnail-${status.index}">Subtitle Thumbnail:</label>
                        <c:if test="${not empty s.imgUrl}">
                            <img src="assets/images/blog/BlogImg/${s.imgUrl}" width="100%" height="100%" alt="Subtitle Image"/>
                        </c:if>
                        <input type="file" id="existing-subtitle-thumbnail-${status.index}" name="existingSubtitles[${status.index}][thumbnail]" accept="image/*">
                    </div>
                    <div class="form-group">
                        <label for="existing-subtitle-content-${status.index}">Subtitle Content:</label>
                        <textarea id="existing-subtitle-content-${status.index}" name="existingSubtitles[${status.index}][content]" rows="4" required>${s.content}</textarea>
                    </div>
                    <button type="button" class="btn-remove-subtitle" data-subtitle-id="${s.subtitleID}">Delete Subtitle</button>
                </div>
            </c:forEach>

            <!-- Add a hidden field to store IDs of subtitles to be deleted -->
            <input type="hidden" id="subtitlesToDelete" name="subtitlesToDelete">

            <!-- New Subtitles -->
            <div id="subtitleContainer"></div>

            <div class="button-group">
                <button type="button" class="btn-add-subtitle" id="addSubtitleBtn" style="margin-bottom: 10px">
                    <i class="fas fa-plus"></i> Add New Subtitle
                </button>

                <div class="action-buttons">
                    <input type="submit" value="Submit Post" class="btn-submit" style="margin-right: 5px">
                    <a href="MarketerDashboard" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>
        </form>
        <form action="delete-post" method="POST" id="deletePostForm">
            <input type="hidden" id="deleteBlogId" name="blogId" value="${sessionScope.blogForEdit.blogId}">
        </form>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let subtitlesToDelete = []; // Array to store the IDs of subtitles to be deleted

                // Handle adding a new subtitle
                document.getElementById('addSubtitleBtn').addEventListener('click', function () {
                    // Get the container for new subtitles
                    const subtitleContainer = document.getElementById('subtitleContainer');

                    // Calculate the new subtitle index
                    const newIndex = subtitleContainer.children.length;

                    // Create a new subtitle div
                    const newSubtitle = document.createElement('div');
                    newSubtitle.classList.add('subtitle-group');
                    newSubtitle.id = `new-subtitle-${newIndex}`;

                    // Populate the new subtitle HTML
                    newSubtitle.innerHTML = `
    <div class="form-group">
        <label for="new-subtitle-${newIndex}-title">Subtitle Title:</label>
        <input type="text" id="new-subtitle-${newIndex}-title" name="newSubtitles[${newIndex}][title]" required>
    </div>
    <div class="form-group">
        <label for="new-subtitle-${newIndex}-thumbnail">Subtitle Thumbnail:</label>
        <input type="file" id="new-subtitle-${newIndex}-thumbnail" name="newSubtitles[${newIndex}][thumbnail]" accept="image/*">
    </div>
    <div class="form-group">
        <label for="new-subtitle-${newIndex}-content">Subtitle Content:</label>
        <textarea id="new-subtitle-${newIndex}-content" name="newSubtitles[${newIndex}][content]" rows="4" required></textarea>
    </div>
    <button type="button" class="btn-remove-subtitle" onclick="removeSubtitle('new-subtitle-${newIndex}')">Delete Subtitle</button>
`;

                    // Append the new subtitle to the container
                    subtitleContainer.appendChild(newSubtitle);

                    // Add event listener for image preview
                    document.getElementById(`new-subtitle-${newIndex}-thumbnail`).addEventListener('change', function () {
                        previewImage(this, `thumbnail-preview-${newIndex}`);
                    });
                });

                // Function to remove a subtitle
                window.removeSubtitle = function (subtitleId) {
                    const subtitle = document.getElementById(subtitleId);
                    if (subtitle) {
                        subtitle.remove(); // Remove the subtitle from DOM
                    }
                };

                // Handle existing subtitle deletion
                document.querySelectorAll('.btn-remove-subtitle').forEach(function (button) {
                    button.addEventListener('click', function () {
                        const subtitleId = button.getAttribute('data-subtitle-id');
                        const confirmation = confirm('Are you sure you want to delete this subtitle?');
                        if (confirmation && subtitleId) {
                            // Add subtitle ID to the list of subtitles to delete
                            subtitlesToDelete.push(subtitleId);

                            // Update the hidden input with the IDs of subtitles to delete
                            document.getElementById('subtitlesToDelete').value = subtitlesToDelete.join(',');

                            // Hide the subtitle section
                            button.closest('.subtitle-group').style.display = 'none';
                        }
                    });
                });

                // Handle image preview when a file is selected
                window.previewImage = function (input, previewId) {
                    const preview = document.getElementById(previewId);
                    const file = input.files[0];

                    if (file && preview) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.src = e.target.result;  // Update preview source
                            preview.style.display = 'block'; // Display the preview
                        };
                        reader.readAsDataURL(file); // Read the file as Data URL
                    } else if (preview) {
                        preview.style.display = 'none';  // Hide the preview
                        preview.src = '';  // Clear the preview source
                    }
                };

                // Handle post deletion
                document.getElementById('deletePostBtn').addEventListener('click', function () {
                    const confirmation = confirm('Are you sure you want to delete this post?');
                    if (confirmation) {
                        document.getElementById('deletePostForm').submit(); // Submit the delete form
                    }
                });
            });
        </script>
    </body>
</html>
