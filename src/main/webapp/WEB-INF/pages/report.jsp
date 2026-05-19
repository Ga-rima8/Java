<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentPage" value="report" scope="request" />

<!DOCTYPE html>
<html>

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

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Reports & Analysis</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- STAT CARDS -->
            <div class="cards">

                <div class="card">
                    <div class="card-top">Total Bookings</div>
                    <div class="card-num">${totalBookings}</div>
                </div>

                <div class="card">
                    <div class="card-top">Confirmed</div>

                    <div class="card-num"
                         style="color:#2d6a4f;">

                        ${confirmedBookings}

                    </div>
                </div>

                <div class="card">
                    <div class="card-top">Cancellation Rate</div>

                    <div class="card-num"
                         style="color:#a16207;">

                        ${cancelRate}%

                    </div>
                </div>

                <div class="card">
                    <div class="card-top">Total Revenue</div>
                    <div class="card-num">Rs. ${totalRevenue}</div>
                </div>

            </div>

            <!-- CHARTS -->
            <div class="two-col">

                <!-- BOOKINGS PER EVENT -->
                <div class="box">

                    <div class="box-title">
                        Bookings per Event
                    </div>

                    <div class="chart-area">

                        <div class="y-axis">
                            <span>40</span>
                            <span>30</span>
                            <span>20</span>
                            <span>10</span>
                            <span>0</span>
                        </div>

                        <div class="bars">

                            <c:choose>

                                <c:when test="${not empty eventStats}">

                                    <c:forEach var="es"
                                               items="${eventStats}">

                                        <div class="bar-col">

                                            <div class="bar-fill"
                                                 style="height:${es.fillPercent}%">

                                                <span class="bv">
                                                    ${es.bookingCount}
                                                </span>

                                            </div>

                                            <div class="bar-x">
                                                ${es.eventName}
                                            </div>

                                        </div>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <div style="flex:1;
                                                display:flex;
                                                align-items:center;
                                                justify-content:center;
                                                color:#5a7a65;
                                                font-size:0.85rem;">

                                        No data yet

                                    </div>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </div>

                </div>

                <!-- BOOKING STATUS -->
                <div class="box">

                    <div class="box-title">
                        Booking Status
                    </div>

                    <div class="chart-area">

                        <div class="y-axis">
                            <span>100</span>
                            <span>75</span>
                            <span>50</span>
                            <span>25</span>
                            <span>0</span>
                        </div>

                        <div class="bars">

                            <!-- CONFIRMED -->
                            <div class="bar-col">

                                <div class="bar-fill"
                                     style="height:${confirmedPct != null ? confirmedPct : 0}%">

                                    <span class="bv">
                                        ${confirmedBookings}
                                    </span>

                                </div>

                                <div class="bar-x">
                                    Confirmed
                                </div>

                            </div>

                            <!-- PENDING -->
                            <div class="bar-col">

                                <div class="bar-fill bar-yellow"
                                     style="height:${pendingPct != null ? pendingPct : 0}%">

                                    <span class="bv">
                                        ${pendingBookings}
                                    </span>

                                </div>

                                <div class="bar-x">
                                    Pending
                                </div>

                            </div>

                            <!-- CANCELLED -->
                            <div class="bar-col">

                                <div class="bar-fill bar-red"
                                     style="height:${cancelledPct != null ? cancelledPct : 0}%">

                                    <span class="bv">
                                        ${cancelledBookings}
                                    </span>

                                </div>

                                <div class="bar-x">
                                    Cancelled
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

            <!-- EVENT ANALYSIS TABLE -->
            <div class="box" style="margin-top:16px;">

                <div class="box-title">
                    Event Analysis
                </div>

                <table>

                    <thead>

                        <tr>
                            <th>Event</th>
                            <th>Booked</th>
                            <th>Capacity</th>
                            <th>Fill Rate</th>
                            <th>Revenue</th>
                            <th>Status</th>
                        </tr>

                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${not empty eventAnalysis}">

                                <c:forEach var="ea"
                                           items="${eventAnalysis}">

                                    <tr>

                                        <td>${ea.eventName}</td>

                                        <td>${ea.booked}</td>

                                        <td>${ea.capacity}</td>

                                        <td>${ea.fillRate}%</td>

                                        <td>Rs. ${ea.revenue}</td>

                                        <td>

                                            <span class="tag ${ea.fillRate >= 80 ? 'red' : ea.fillRate >= 50 ? 'yellow' : 'green'}">

                                                ${ea.fillRate >= 80 ? 'High Demand' : ea.fillRate >= 50 ? 'Moderate' : 'Low Demand'}

                                            </span>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>

                                    <td colspan="6"
                                        style="text-align:center;
                                               color:#5a7a65;
                                               padding:20px;">

                                        No data yet.

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