<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Hangaura</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Dashboard</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- STAT CARDS -->
            <div class="cards">
                <div class="card c-green">
                    <div class="card-top">Total Events</div>
                    <div class="card-num green">${counts.events}</div>
                </div>
                <div class="card c-blue">
                    <div class="card-top">Total Visitors</div>
                    <div class="card-num blue">${counts.visitors}</div>
                </div>
                <div class="card c-amber">
                    <div class="card-top">Total Hosts</div>
                    <div class="card-num amber">${counts.hosts}</div>
                </div>
                <div class="card c-coral">
                    <div class="card-top">Registrations</div>
                    <div class="card-num coral">${counts.registrations}</div>
                </div>
                <div class="card c-purple">
                    <div class="card-top">Reviews</div>
                    <div class="card-num purple">${counts.reviews}</div>
                </div>
            </div>

            <!-- RECENT EVENTS TABLE -->
            <div class="box">
                <div class="box-header">
                    <div class="box-title">Recent Events</div>
                    <div class="box-badge">Last 5</div>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Host</th>
                            <th>Category</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="event" items="${recentEvents}">
                            <tr>
                                <td class="td-bold">${event.title}</td>
                                <td>${event.hostName}</td>
                                <td>${event.category}</td>
                                <td>${event.date}</td>
                                <td>${event.location}</td>
                                <td>Rs. ${event.price}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentEvents}">
                            <tr>
                                <td colspan="6" class="empty">No events found</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>
</body>
</html>