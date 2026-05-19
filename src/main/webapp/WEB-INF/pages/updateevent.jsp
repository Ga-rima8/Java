<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="currentPage" value="updateEvent" scope="request" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Update Event | Hangaura</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/updateevent.css">
</head>

<body>

<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Update Event</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- MESSAGE -->
            <c:set var="msg" value="${param.msg}" />

            <c:if test="${msg == 'updated'}">
                <div class="msg success">
                    Event updated successfully!
                </div>
            </c:if>

            <c:if test="${msg == 'statusUpdated'}">
                <div class="msg success">
                    Event status updated!
                </div>
            </c:if>

            <c:if test="${msg == 'error'}">
                <div class="msg error">
                    ✕ Something went wrong. Try again.
                </div>
            </c:if>

            <!-- EVENT COUNT -->
            <c:set var="count"
                   value="${not empty events ? fn:length(events) : 0}" />

            <!-- TABLE -->
            <div class="box">

                <div class="box-header">

                    <div class="box-title">
                        All Events
                    </div>

                    <div class="box-badge">
                        ${count} event${count != 1 ? 's' : ''}
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
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>

                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${empty events}">

                                <tr>

                                    <td colspan="10"
                                        class="empty">

                                        No events found.
                                        Create one from the Events page!

                                    </td>

                                </tr>

                            </c:when>

                            <c:otherwise>

                                <c:forEach var="ev"
                                           items="${events}"
                                           varStatus="loop">

                                    <tr>

                                        <td>${loop.index + 1}</td>

                                        <td>

                                            <c:choose>

                                                <c:when test="${not empty ev.imageUrl}">

                                                    <img src="${ev.imageUrl}"
                                                         alt="event"
                                                         class="event-thumb">

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

                                        <td>${ev.host}</td>

                                        <td>${ev.category}</td>

                                        <td>${ev.eventDate}</td>

                                        <td>${ev.location}</td>

                                        <td>
                                            Rs. ${ev.price}
                                        </td>

                                        <td>

                                            <span class="status-badge ${ev.active ? 'active' : 'inactive'}">

                                                ${ev.active ? 'Active' : 'Inactive'}

                                            </span>

                                        </td>

                                        <td class="td-actions">

                                            <!-- EDIT BUTTON -->
                                            <button class="btn-edit"

                                                onclick="openModal(
                                                    '${ev.eventId}',
                                                    '${fn:escapeXml(ev.title)}',
                                                    '${fn:escapeXml(ev.host)}',
                                                    '${fn:escapeXml(ev.category)}',
                                                    '${ev.eventDate}',
                                                    '${fn:escapeXml(ev.location)}',
                                                    '${ev.price}',
                                                    '${fn:escapeXml(ev.description)}',
                                                    '${ev.imageUrl}'
                                                )">

                                                Edit

                                            </button>

                                            <!-- STATUS FORM -->
                                            <form action="updateEvent"
                                                  method="post"
                                                  style="display:inline;">

                                                <input type="hidden"
                                                       name="action"
                                                       value="toggleStatus">

                                                <input type="hidden"
                                                       name="event_id"
                                                       value="${ev.eventId}">

                                                <input type="hidden"
                                                       name="new_status"
                                                       value="${ev.active ? 0 : 1}">

                                                <button type="submit"
                                                        class="${ev.active ? 'btn-deactivate' : 'btn-activate'}">

                                                    ${ev.active ? 'Deactivate' : 'Activate'}

                                                </button>

                                            </form>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:otherwise>

                        </c:choose>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- EDIT MODAL -->
<div class="modal-overlay"
     id="modalOverlay"
     onclick="closeModalOnBg(event)">

    <div class="modal">

        <div class="modal-header">

            <h3>Edit Event</h3>

            <button class="modal-close"
                    onclick="closeModal()">

                ✕

            </button>

        </div>

        <form action="updateEvent"
              method="post"
              enctype="multipart/form-data"
              class="modal-form">

            <input type="hidden"
                   name="action"
                   value="edit">

            <input type="hidden"
                   name="event_id"
                   id="f_event_id">

            <input type="hidden"
                   name="existing_image"
                   id="f_existing_image">

            <!-- ROW 1 -->
            <div class="form-row">

                <div class="form-group">

                    <label>Title</label>

                    <input type="text"
                           name="title"
                           id="f_title"
                           required>

                </div>

                <div class="form-group">

                    <label>Host</label>

                    <input type="text"
                           name="host"
                           id="f_host"
                           required>

                </div>

            </div>

            <!-- ROW 2 -->
            <div class="form-row">

                <div class="form-group">

                    <label>Category</label>

                    <input type="text"
                           name="category"
                           id="f_category"
                           required>

                </div>

                <div class="form-group">

                    <label>Date</label>

                    <input type="date"
                           name="event_date"
                           id="f_event_date"
                           required>

                </div>

            </div>

            <!-- ROW 3 -->
            <div class="form-row">

                <div class="form-group">

                    <label>Location</label>

                    <input type="text"
                           name="location"
                           id="f_location"
                           required>

                </div>

                <div class="form-group">

                    <label>Price (Rs.)</label>

                    <input type="number"
                           name="price"
                           id="f_price"
                           step="0.01"
                           min="0"
                           required>

                </div>

            </div>

            <!-- DESCRIPTION -->
            <div class="form-group">

                <label>Description</label>

                <textarea name="description"
                          id="f_description"
                          rows="3"></textarea>

            </div>

            <!-- IMAGE -->
            <div class="form-group">

                <label>
                    Event Image
                    (leave blank to keep current)
                </label>

                <div class="upload-area"
                     id="uploadArea">

                    <input type="file"
                           name="image"
                           accept="image/*"
                           onchange="previewImage(event)">

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

                        <p>Click to change image</p>

                        <span>
                            PNG, JPG, WEBP up to 5MB
                        </span>

                    </div>

                    <img id="imgPreview"
                         src=""
                         alt="preview"
                         style="display:none;
                                max-height:160px;
                                border-radius:8px;
                                object-fit:cover;
                                width:100%;"/>

                </div>

            </div>

            <!-- FOOTER -->
            <div class="modal-footer">

                <button type="button"
                        class="btn-cancel"
                        onclick="closeModal()">

                    Cancel

                </button>

                <button type="submit"
                        class="btn-primary">

                    Save Changes

                </button>

            </div>

        </form>

    </div>

</div>

<script>

function openModal(
    id,
    title,
    host,
    category,
    date,
    location,
    price,
    description,
    imageUrl
) {

    document.getElementById('f_event_id').value = id;
    document.getElementById('f_title').value = title;
    document.getElementById('f_host').value = host;
    document.getElementById('f_category').value = category;
    document.getElementById('f_event_date').value = date;
    document.getElementById('f_location').value = location;
    document.getElementById('f_price').value = price;
    document.getElementById('f_description').value = description;
    document.getElementById('f_existing_image').value = imageUrl;

    const preview =
        document.getElementById('imgPreview');

    const placeholder =
        document.getElementById('uploadPlaceholder');

    if (imageUrl && imageUrl.trim() !== '') {

        preview.src = imageUrl;

        preview.style.display = 'block';

        placeholder.style.display = 'none';

    } else {

        preview.src = '';

        preview.style.display = 'none';

        placeholder.style.display = 'flex';

    }

    document.getElementById('modalOverlay')
        .classList.add('show');

    document.body.style.overflow = 'hidden';
}

function closeModal() {

    document.getElementById('modalOverlay')
        .classList.remove('show');

    document.body.style.overflow = '';
}

function closeModalOnBg(e) {

    if (e.target.id === 'modalOverlay') {

        closeModal();

    }
}

function previewImage(event) {

    const file = event.target.files[0];

    if (!file) return;

    const reader = new FileReader();

    reader.onload = function(e) {

        const preview =
            document.getElementById('imgPreview');

        preview.src = e.target.result;

        preview.style.display = 'block';

        document.getElementById('uploadPlaceholder')
            .style.display = 'none';
    };

    reader.readAsDataURL(file);
}

window.onload = function() {

    const msg = document.querySelector('.msg');

    if (msg) {

        setTimeout(() => msg.style.opacity = '0', 3000);

        setTimeout(() => msg.remove(), 3500);
    }
};

</script>

</body>
</html>