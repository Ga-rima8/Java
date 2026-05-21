<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports | Hangaura</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sidebar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/report.css">
</head>

<body>

<div class="layout">

    <jsp:include page="sidebar.jsp"/>

    <div class="main">

        <!-- TOPBAR -->

        <div class="topbar">

            <div class="page-title">
                Reports
            </div>

            <div class="admin-pill">
                Admin
            </div>

        </div>

        <!-- CONTENT -->

        <div class="content">

            <!-- BANNER -->

            <div class="banner">

                <h1>Reports Dashboard</h1>

                <p>
                    View booking details and event performance.
                </p>

            </div>

            <!-- CARDS -->

            <div class="cards">

                <div class="card">
                    <h3>Total Bookings</h3>
                    <p>${totalBookings}</p>
                </div>

                <div class="card">
                    <h3>Confirmed</h3>
                    <p>${confirmedBookings}</p>
                </div>

                <div class="card">
                    <h3>Pending</h3>
                    <p>${pendingBookings}</p>
                </div>

                <div class="card">
                    <h3>Cancelled</h3>
                    <p>${cancelledBookings}</p>
                </div>

            </div>

            <!-- TABLE -->

            <div class="table-box">

                <div class="table-header">

                    <h2>Event Analysis</h2>

                </div>

                <table>

                    <thead>

                    <tr>
                        <th>Event</th>
                        <th>Booked</th>
                        <th>Capacity</th>
                        <th>Fill Rate</th>
                    </tr>

                    </thead>

                    <tbody>

                    <c:choose>

                        <c:when test="${not empty eventAnalysis}">

                            <c:forEach var="ea" items="${eventAnalysis}">

                                <tr>

                                    <td>${ea.eventName}</td>

                                    <td>${ea.booked}</td>

                                    <td>${ea.capacity}</td>

                                    <td>${ea.fillRate}%</td>

                                </tr>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <tr>

                                <td colspan="4" class="empty">
                                    No data available
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

</body>
</html>