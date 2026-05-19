<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentPage" value="booking" scope="request" />

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Bookings | Hangaura</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css">
</head>

<body>

<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <div class="topbar">
            <div class="page-title">Bookings</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <c:if test="${not empty error}">
                <div class="msg error">${error}</div>
            </c:if>

            <div class="cards">
                <div class="card">
                    <div class="card-top">Total Bookings</div>
                    <div class="card-num">${totalBookings}</div>
                </div>
            </div>

            <div class="box">

                <div class="box-title">All Bookings</div>

                <div class="search-row">
                    <input type="text"
                           id="bSearch"
                           placeholder="Search bookings..."
                           onkeyup="ft('bSearch','bTable')" />
                </div>

                <table id="bTable">

                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Visitor</th>
                            <th>Email</th>
                            <th>Event</th>
                            <th>Location</th>
                            <th>Price</th>
                            <th>Registered On</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${not empty bookingList}">

                                <c:forEach var="b"
                                           items="${bookingList}"
                                           varStatus="loop">

                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${b.visitorName}</td>
                                        <td>${b.visitorEmail}</td>
                                        <td>${b.eventTitle}</td>
                                        <td>${b.eventLocation}</td>
                                        <td>Rs. ${b.eventPrice}</td>
                                        <td>${b.regDate}</td>

                                        <td>

                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/booking"
                                                  style="display:inline;"
                                                  onsubmit="return confirm('Delete this booking?');">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete" />

                                                <input type="hidden"
                                                       name="bookingId"
                                                       value="${b.id}" />

                                                <button type="submit"
                                                        class="btn-sm red">
                                                    Delete
                                                </button>

                                            </form>

                                        </td>
                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>
                                    <td colspan="8" class="empty">
                                        No bookings yet.
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

    function ft(i, t) {

        const v = document.getElementById(i).value.toLowerCase();

        document.querySelectorAll('#' + t + ' tbody tr').forEach(r => {

            r.style.display =
                r.textContent.toLowerCase().includes(v)
                ? ''
                : 'none';

        });
    }

</script>

</body>
</html>