<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Events | Hangaura</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/events.css">
</head>

<body>

<c:set var="currentPage" value="events" scope="request"/>

<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Events</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- MESSAGES -->
            <c:set var="successMsg" value="${not empty success ? success : param.success}" />
            <c:set var="errorMsg" value="${not empty error ? error : param.error}" />

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

                    <input type="hidden" name="action" value="create"/>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" name="title" required/>
                        </div>

                        <div class="form-group">
                            <label>Date</label>
                            <input type="date" name="date" required/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Location</label>
                            <input type="text" name="location" required/>
                        </div>

                        <div class="form-group">
                            <label>Price (Rs.)</label>
                            <input type="number" name="price" step="0.01" required/>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Host</label>
                            <select name="hostId" required>
                                <option value="">-- Select Host --</option>
                                <c:forEach var="h" items="${hosts}">
                                    <option value="${h.id}">${h.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Category</label>
                            <select name="categoryId" required>
                                <option value="">-- Select Category --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="desc" rows="3"></textarea>
                    </div>

                    <!-- IMAGE INPUT ONLY (NO JS PREVIEW) -->
                    <div class="form-group">
                        <label>Event Image</label>
                        <input type="file" name="image" accept="image/*"/>
                    </div>

                    <button type="submit" class="btn-primary">Create Event</button>

                </form>
            </div>

            <!-- EVENTS TABLE -->
            <div class="box">
                <div class="box-header">
                    <div class="box-title">All Events</div>
                    <div class="box-badge">
                        ${not empty eventList ? eventList.size() : 0} events
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
                                <c:forEach var="ev" items="${eventList}">
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
                                                    No image
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="td-bold">${ev.title}</td>
                                        <td>${ev.hostName}</td>
                                        <td>${ev.categoryName}</td>
                                        <td>${ev.date}</td>
                                        <td>${ev.location}</td>
                                        <td>Rs. ${ev.price}</td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/events"
                                                  method="post"
                                                  style="display:inline;">
                                                <input type="hidden" name="action" value="delete"/>
                                                <input type="hidden" name="eventId" value="${ev.id}"/>
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
                                    <td colspan="9" class="empty">No events found</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>

                </table>
            </div>

        </div>
    </div>
</div>

</body>
</html>