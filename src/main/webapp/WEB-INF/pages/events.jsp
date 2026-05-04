<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Events | Hangaura</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/events.css">
</head>
<body>
<div class="layout">

    <% request.setAttribute("currentPage", "events"); %>
    <jsp:include page="sidebar.jsp" />

    <div class="main">
        <div class="topbar">
    <div class="page-title">Events</div>
    <div class="admin-tag">Admin</div>
</div>

        <div class="content">

            <c:if test="${not empty error}">
                <div class="msg error">${error}</div>
            </c:if>

            <!-- CREATE FORM -->
            <div class="box">
                <div class="box-header">
                    <div class="box-title">Create New Event</div>
                </div>
                <form action="${pageContext.request.contextPath}/events" method="post" class="create-form">
                    <input type="hidden" name="action" value="create"/>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Title</label>
                            <input type="text" name="title" placeholder="Event title" required/>
                        </div>
                        <div class="form-group">
                            <label>Date</label>
                            <input type="date" name="date" required/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label>Location</label>
                            <input type="text" name="location" placeholder="Event location" required/>
                        </div>
                        <div class="form-group">
                            <label>Price (Rs.)</label>
                            <input type="number" name="price" placeholder="0.00" step="0.01" required/>
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
                        <textarea name="desc" rows="3" placeholder="Event description"></textarea>
                    </div>
                    <button type="submit" class="btn-primary">Create Event</button>
                </form>
            </div>

            <!-- EVENTS TABLE -->
            <div class="box">
                <div class="box-header">
                    <div class="box-title">All Events</div>
                    <div class="box-badge">${eventList.size()} events</div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
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
                                        <td class="td-bold">${ev.title}</td>
                                        <td>${ev.hostName}</td>
                                        <td>${ev.categoryName}</td>
                                        <td>${ev.date}</td>
                                        <td>${ev.location}</td>
                                        <td>Rs. ${ev.price}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/events"
                                                  method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete"/>
                                                <input type="hidden" name="eventId" value="${ev.id}"/>
                                                <button type="submit" class="btn-delete"
                                                    onclick="return confirm('Delete this event?')">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="8" class="empty">No events found</td></tr>
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