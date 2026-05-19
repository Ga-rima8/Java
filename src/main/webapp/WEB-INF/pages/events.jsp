<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentPage" value="events" scope="request" />

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Events | Hangaura</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/events.css">
</head>

<body>

<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Events</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- MESSAGE DISPLAY -->
            <c:set var="successMsg"
                   value="${not empty success ? success : param.success}" />

            <c:set var="errorMsg"
                   value="${not empty error ? error : param.error}" />

            <c:if test="${not empty errorMsg}">
                <div class="msg error">${errorMsg}</div>
            </c:if>

            <c:if test="${not empty successMsg}">
                <div class="msg success">${successMsg}</div>
            </c:if>

            <!-- CREATE FORM -->
            <div class="box">

                <div class="box-header">
                    <div class="box-title">Create New Event</div>
                </div>

                <form action="${pageContext.request.contextPath}/events"
                      method="post"
                      class="create-form"
                      enctype="multipart/form-data">

                    <input type="hidden"
                           name="action"
                           value="create"/>

                    <!-- ROW 1 -->
                    <div class="form-row">

                        <div class="form-group">
                            <label>Title</label>

                            <input type="text"
                                   name="title"
                                   placeholder="Event title"
                                   required/>
                        </div>

                        <div class="form-group">
                            <label>Date</label>

                            <input type="date"
                                   name="date"
                                   required/>
                        </div>

                    </div>

                    <!-- ROW 2 -->
                    <div class="form-row">

                        <div class="form-group">
                            <label>Location</label>

                            <input type="text"
                                   name="location"
                                   placeholder="Event location"
                                   required/>
                        </div>

                        <div class="form-group">
                            <label>Price (Rs.)</label>

                            <input type="number"
                                   name="price"
                                   placeholder="0.00"
                                   step="0.01"
                                   required/>
                        </div>

                    </div>

                    <!-- ROW 3 -->
                    <div class="form-row">

                        <div class="form-group">

                            <label>Host</label>

                            <select name="hostId" required>

                                <option value="">
                                    -- Select Host --
                                </option>

                                <c:forEach var="h" items="${hosts}">
                                    <option value="${h.id}">
                                        ${h.name}
                                    </option>
                                </c:forEach>

                            </select>

                        </div>

                        <div class="form-group">

                            <label>Category</label>

                            <select name="categoryId" required>

                                <option value="">
                                    -- Select Category --
                                </option>

                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">
                                        ${cat.title}
                                    </option>
                                </c:forEach>

                            </select>

                        </div>

                    </div>

                    <!-- DESCRIPTION -->
                    <div class="form-group">

                        <label>Description</label>

                        <textarea name="desc"
                                  rows="3"
                                  placeholder="Event description"></textarea>

                    </div>

                    <!-- IMAGE UPLOAD -->
                    <div class="form-group">

                        <label>Event Image</label>

                        <div class="upload-area" id="uploadArea">

                            <input type="file"
                                   name="image"
                                   id="imageInput"
                                   accept="image/*"
                                   onchange="previewImage(event)"/>

                            <div class="upload-placeholder"
                                 id="uploadPlaceholder">

                                <svg width="32"
                                     height="32"
                                     fill="none"
                                     stroke="currentColor"
                                     stroke-width="1.5"
                                     viewBox="0 0 24 24">

                                    <rect x="3"
                                          y="3"
                                          width="18"
                                          height="18"
                                          rx="3"/>

                                    <circle cx="8.5"
                                            cy="8.5"
                                            r="1.5"/>

                                    <polyline points="21 15 16 10 5 21"/>

                                </svg>

                                <p>Click or drag an image here</p>

                                <span>
                                    PNG, JPG, WEBP up to 5MB
                                </span>

                            </div>

                            <img id="imagePreview"
                                 src="#"
                                 alt="Preview"
                                 style="display:none;
                                        max-height:180px;
                                        border-radius:8px;
                                        object-fit:cover;
                                        width:100%;"/>

                        </div>

                    </div>

                    <button type="submit"
                            class="btn-primary">

                        Create Event

                    </button>

                </form>

            </div>

            <!-- EVENTS TABLE -->
            <div class="box">

                <div class="box-header">

                    <div class="box-title">
                        All Events
                    </div>

                    <div class="box-badge">
                        ${eventList.size()} events
                    </div>

                </div>

                <table>

                    <thead>

                        <tr>
                            <th>#</th>
                            <th>Image</th>
                            <th>Title</th>
                            <th>Host</th>
                            <th>Category</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>

                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${not empty eventList}">

                                <c:forEach var="ev"
                                           items="${eventList}">

                                    <tr>

                                        <td>${ev.id}</td>

                                        <td>

                                            <c:choose>

                                                <c:when test="${not empty ev.image}">

                                                    <img src="${pageContext.request.contextPath}/images/events/${ev.image}"
                                                         alt="${ev.title}"
                                                         class="event-thumb"/>

                                                </c:when>

                                                <c:otherwise>

                                                    <div class="no-img">
                                                        No image
                                                    </div>

                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <td class="td-bold">
                                            ${ev.title}
                                        </td>

                                        <td>${ev.hostName}</td>

                                        <td>${ev.categoryName}</td>

                                        <td>${ev.date}</td>

                                        <td>${ev.location}</td>

                                        <td>Rs. ${ev.price}</td>

                                        <td>

                                            <form action="${pageContext.request.contextPath}/events"
                                                  method="post"
                                                  style="display:inline;">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete"/>

                                                <input type="hidden"
                                                       name="eventId"
                                                       value="${ev.id}"/>

                                                <button type="submit"
                                                        class="btn-delete"
                                                        onclick="return confirm('Delete this event?')">

                                                    Delete

                                                </button>

                                            </form>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>

                                    <td colspan="9"
                                        class="empty">

                                        No events found

                                    </td>

                                </tr>

                            </c:otherwise>

                        </c:choose>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<script>

function previewImage(event) {

    const file = event.target.files[0];

    if (!file) return;

    const preview =
        document.getElementById('imagePreview');

    const placeholder =
        document.getElementById('uploadPlaceholder');

    const reader = new FileReader();

    reader.onload = function(e) {

        preview.src = e.target.result;

        preview.style.display = 'block';

        placeholder.style.display = 'none';
    };

    reader.readAsDataURL(file);
}

// drag and drop

const uploadArea =
    document.getElementById('uploadArea');

uploadArea.addEventListener('dragover', e => {

    e.preventDefault();

    uploadArea.classList.add('drag-over');

});

uploadArea.addEventListener('dragleave', () =>
    uploadArea.classList.remove('drag-over')
);

uploadArea.addEventListener('drop', e => {

    e.preventDefault();

    uploadArea.classList.remove('drag-over');

    const file = e.dataTransfer.files[0];

    if (file) {

        document.getElementById('imageInput').files =
            e.dataTransfer.files;

        previewImage({
            target: {
                files: [file]
            }
        });
    }
});

</script>

</body>
</html>