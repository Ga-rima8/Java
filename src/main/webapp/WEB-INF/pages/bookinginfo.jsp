<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bookings | Hangaura</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Sora:wght@600;700&display=swap"
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css">
</head>
<body>
<c:set var="currentPage" value="booking" scope="request"/>

<div class="layout">
    <jsp:include page="sidebar.jsp"/>

    <div class="main">

        <!-- TOPBAR -->
        <div class="topbar">
            <div class="topbar-left">
                <div class="breadcrumb">
                    <span class="breadcrumb-home">Hangaura</span>
                    <span class="breadcrumb-sep">›</span>
                    <span class="breadcrumb-current">Event Registrations</span>
                </div>
            </div>
            <div class="topbar-right">
                <div class="admin-pill">
                    <div class="admin-avatar">A</div>
                    Admin
                </div>
            </div>
        </div>

        <div class="content">

            <!-- BANNER -->
            <div class="banner">
                <div class="banner-left">
                    <div class="banner-greeting">Event Registrations, Admin</div>
                    <div class="banner-sub">View and manage all user event registrations across Hangaura.</div>
                </div>
                <div class="banner-icon-wrap">
                    <svg width="64" height="64" fill="none" viewBox="0 0 64 64">
                        <circle cx="32" cy="32" r="32" fill="rgba(255,255,255,0.08)"/>
                        <rect x="20" y="18" width="24" height="28" rx="3"
                              stroke="rgba(255,255,255,0.5)" stroke-width="2" fill="none"/>
                        <line x1="25" y1="28" x2="39" y2="28" stroke="rgba(255,255,255,0.4)" stroke-width="1.5"/>
                        <line x1="25" y1="33" x2="36" y2="33" stroke="rgba(255,255,255,0.4)" stroke-width="1.5"/>
                        <line x1="25" y1="38" x2="33" y2="38" stroke="rgba(255,255,255,0.4)" stroke-width="1.5"/>
                    </svg>
                </div>
            </div>

            <!-- STATS -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-label">Total Registrations</div>
                    <div class="stat-value">${totalBookings}</div>
                </div>
                <div class="stat-card c2">
                    <div class="stat-label">This Month</div>
                    <div class="stat-value">${monthlyBookings}</div>
                </div>
                <div class="stat-card c3">
                    <div class="stat-label">Total Events</div>
                    <div class="stat-value">${totalEvents}</div>
                </div>
                <div class="stat-card c4">
                    <div class="stat-label">Removed</div>
                    <div class="stat-value">${deletedBookings}</div>
                </div>
            </div>

            <!-- TABLE -->
            <div class="box">
                <div class="box-header">
                    <div class="box-header-left">
                        <div class="box-title">All Event Registrations</div>
                        <div class="box-sub">Users registered for events on Hangaura</div>
                    </div>
                    <div class="box-badge">${totalBookings} total</div>
                </div>

                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Visitor</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Event</th>
                            <th>Location</th>
                            <th>Event Date</th>
                            <th>Registered On</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty bookingList}">
                                <c:forEach var="b" items="${bookingList}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td class="td-bold">${b.visitorName}</td>
                                        <td>${b.visitorEmail}</td>
                                        <td>${b.visitorPhone}</td>
                                        <td>${b.eventName}</td>
                                        <td>${b.eventLocation}</td>
                                        <td>${b.eventDate}</td>
                                        <td>${b.registeredAt}</td>
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/booking"
                                                  style="display:inline;"
                                                  onsubmit="return confirm('Remove this registration?')">
                                                <input type="hidden" name="action"    value="delete"/>
                                                <input type="hidden" name="bookingId" value="${b.id}"/>
                                                <button type="submit" class="btn-delete">✕ Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="empty">No registrations yet.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>