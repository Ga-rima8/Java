<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Event | Hangaura</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Sora:wght@600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updateevent.css">
</head>
<body>
<div class="layout">

    <%@ include file="/WEB-INF/pages/sidebar.jsp" %>

    <div class="main">

        <!-- TOPBAR -->
        <div class="topbar">
            <div class="topbar-left">
                <div class="breadcrumb">
                    <span class="breadcrumb-home">Hangaura</span>
                    <span class="breadcrumb-sep">›</span>
                    <span class="breadcrumb-current">Update Event</span>
                </div>
            </div>
            <div class="topbar-right">
                <div class="admin-pill">
                    <div class="admin-avatar">A</div>
                    Admin
                </div>
            </div>
        </div>

        <!-- CONTENT -->
        <div class="content">

            <!-- BANNER -->
            <div class="banner">
                <div class="banner-left">
                    <div class="banner-greeting">Manage Events, Admin</div>
                    <div class="banner-sub">Edit event details, toggle active status, or update event images.</div>
                </div>
                <div class="banner-icon-wrap" aria-hidden="true">
                    <svg width="64" height="64" fill="none" viewBox="0 0 64 64">
                        <circle cx="32" cy="32" r="32" fill="rgba(255,255,255,0.08)"/>
                        <rect x="14" y="18" width="36" height="30" rx="5"
                              stroke="rgba(255,255,255,0.5)" stroke-width="2"/>
                        <line x1="14" y1="26" x2="50" y2="26"
                              stroke="rgba(255,255,255,0.5)" stroke-width="2"/>
                        <rect x="22" y="32" width="8" height="8" rx="2"
                              fill="rgba(255,255,255,0.35)"/>
                        <rect x="34" y="32" width="8" height="8" rx="2"
                              fill="rgba(255,255,255,0.35)"/>
                    </svg>
                </div>
            </div>

            <!-- TOAST MESSAGES — read from URL param, no JS needed -->
            <c:if test="${param.msg eq 'updated'}">
                <div class="msg success">&#10003; Event updated successfully!</div>
            </c:if>
            <c:if test="${param.msg eq 'statusUpdated'}">
                <div class="msg success">&#10003; Event status updated!</div>
            </c:if>
            <c:if test="${param.msg eq 'error' and not empty param.detail}">
                <div class="msg error">&#10005; <c:out value="${param.detail}"/></div>
            </c:if>
            <c:if test="${param.msg eq 'error' and empty param.detail}">
                <div class="msg error">&#10005; Something went wrong. Please try again.</div>
            </c:if>

            <!-- ═══ EDIT FORM — shown only when an event is selected ═══ -->
            <c:if test="${not empty editEvent}">
                <div class="box edit-panel">
                    <div class="box-header">
                        <div class="box-header-left">
                            <div class="box-title">Edit Event: <c:out value="${editEvent.title}"/></div>
                            <div class="box-sub">Update the fields below and click Save.</div>
                        </div>
                        <a href="${pageContext.request.contextPath}/updateEvent"
                           class="btn-cancel-link">&#10005; Cancel</a>
                    </div>

                    <form action="${pageContext.request.contextPath}/updateEvent"
                          method="post" enctype="multipart/form-data" class="edit-form">
                        <input type="hidden" name="action"         value="edit">
                        <input type="hidden" name="event_id"       value="${editEvent.eventId}">
                        <input type="hidden" name="existing_image" value="${editEvent.imageUrl}">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="f_title">Title</label>
                                <input type="text" id="f_title" name="title"
                                       value="<c:out value='${editEvent.title}'/>" required>
                            </div>
                            <div class="form-group">
                                <label for="f_host">Host</label>
                                <input type="text" id="f_host" name="host"
                                       value="<c:out value='${editEvent.host}'/>" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="f_category">Category</label>
                                <input type="text" id="f_category" name="category"
                                       value="<c:out value='${editEvent.category}'/>" required>
                            </div>
                            <div class="form-group">
                                <label for="f_date">Date</label>
                                <input type="date" id="f_date" name="event_date"
                                       value="${editEvent.eventDate}" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="f_location">Location</label>
                                <input type="text" id="f_location" name="location"
                                       value="<c:out value='${editEvent.location}'/>" required>
                            </div>
                            <div class="form-group">
                                <label for="f_price">Price (Rs.)</label>
                                <input type="number" id="f_price" name="price"
                                       value="${editEvent.price}" step="0.01" min="0" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="f_desc">Description</label>
                            <textarea id="f_desc" name="description" rows="3"><c:out value="${editEvent.description}"/></textarea>
                        </div>
                        <div class="form-group">
                            <label>Current Image</label>
                            <c:if test="${not empty editEvent.imageUrl}">
                                <div class="current-img-wrap">
                                    <img src="${pageContext.request.contextPath}/${editEvent.imageUrl}"
                                         alt="current" class="event-thumb-lg">
                                </div>
                            </c:if>
                            <c:if test="${empty editEvent.imageUrl}">
                                <p class="no-img-text">No image uploaded.</p>
                            </c:if>
                            <label for="f_image" style="margin-top:8px;">Replace Image (optional)</label>
                            <input type="file" id="f_image" name="image" accept="image/*">
                        </div>
                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/updateEvent"
                               class="btn-cancel-link">Cancel</a>
                            <button type="submit" class="btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </c:if>

            <!-- ═══ EVENTS TABLE ═══ -->
            <div class="box">
                <div class="box-header">
                    <div class="box-header-left">
                        <div class="box-title">All Events</div>
                        <div class="box-sub">Click Edit to modify event details</div>
                    </div>
                    <div class="box-badge">${eventsCount} event<c:if test="${eventsCount != 1}">s</c:if></div>
                </div>
                <div class="table-wrapper">
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
                                        <td colspan="10" class="empty">No events found.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="ev" items="${events}" varStatus="s">
                                        <tr>
                                            <td>${s.index + 1}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty ev.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}/${ev.imageUrl}"
                                                             alt="event" class="event-thumb">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="no-img">No image</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="td-bold"><c:out value="${ev.title}"/></td>
                                            <td><c:out value="${ev.host}"/></td>
                                            <td><c:out value="${ev.category}"/></td>
                                            <td>${ev.eventDate}</td>
                                            <td><c:out value="${ev.location}"/></td>
                                            <td>Rs. ${ev.price}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ev.active}">
                                                        <span class="status-badge active">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge inactive">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="td-actions">
                                                <!-- Edit: GET request with editId, no JS -->
                                                <a href="${pageContext.request.contextPath}/updateEvent?editId=${ev.eventId}"
                                                   class="btn-edit">Edit</a>

                                                <!-- Toggle status: plain form POST, no JS -->
                                                <form action="${pageContext.request.contextPath}/updateEvent"
                                                      method="post" style="display:inline;">
                                                    <input type="hidden" name="action"     value="toggleStatus">
                                                    <input type="hidden" name="event_id"   value="${ev.eventId}">
                                                    <input type="hidden" name="new_status" value="${ev.active ? 0 : 1}">
                                                    <c:choose>
                                                        <c:when test="${ev.active}">
                                                            <button type="submit" class="btn-deactivate">Deactivate</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="submit" class="btn-activate">Activate</button>
                                                        </c:otherwise>
                                                    </c:choose>
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

        </div><!-- /content -->
    </div><!-- /main -->
</div><!-- /layout -->
</body>
</html>