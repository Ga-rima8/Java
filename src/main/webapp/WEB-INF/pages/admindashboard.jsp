<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Hangaura – Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Sora:wght@600;700&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css"/>
</head>
<body>
<div class="layout">

    <%@ include file="/WEB-INF/pages/sidebar.jsp" %>

    <div class="main">

        <div class="topbar">
            <div class="topbar-left">
                <div class="breadcrumb">
                    <span class="breadcrumb-home">Hangaura</span>
                    <span class="breadcrumb-sep">›</span>
                    <span class="breadcrumb-current">Dashboard</span>
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

            <div class="banner">
                <div class="banner-left">
                    <div class="banner-greeting">Welcome back, Admin</div>
                    <div class="banner-sub">Here's what's happening with Hangaura today.</div>
                </div>
                <div class="banner-icon-wrap">
                    <svg width="60" height="60" fill="none" viewBox="0 0 64 64">
                        <circle cx="32" cy="32" r="32" fill="rgba(255,255,255,0.08)"/>
                        <rect x="14" y="18" width="36" height="30" rx="5" stroke="rgba(255,255,255,0.5)" stroke-width="2"/>
                        <line x1="14" y1="26" x2="50" y2="26" stroke="rgba(255,255,255,0.5)" stroke-width="2"/>
                        <line x1="22" y1="14" x2="22" y2="22" stroke="rgba(255,255,255,0.5)" stroke-width="2" stroke-linecap="round"/>
                        <line x1="42" y1="14" x2="42" y2="22" stroke="rgba(255,255,255,0.5)" stroke-width="2" stroke-linecap="round"/>
                        <rect x="22" y="32" width="8" height="8" rx="2" fill="rgba(255,255,255,0.35)"/>
                        <rect x="34" y="32" width="8" height="8" rx="2" fill="rgba(255,255,255,0.35)"/>
                    </svg>
                </div>
            </div>

            <div class="stats-grid">

                <div class="stat-card c1">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                                <rect x="3" y="4" width="18" height="18" rx="2"/>
                                <line x1="16" y1="2" x2="16" y2="6"/>
                                <line x1="8" y1="2" x2="8" y2="6"/>
                                <line x1="3" y1="10" x2="21" y2="10"/>
                            </svg>
                        </div>
                        <div class="stat-trend up">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <polyline points="18 15 12 9 6 15"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${totalEvents}</div>
                    <div class="stat-label">Total Events</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:70%"></div></div>
                </div>

                <div class="stat-card c2">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                <circle cx="9" cy="7" r="4"/>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                            </svg>
                        </div>
                        <div class="stat-trend up">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <polyline points="18 15 12 9 6 15"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${totalVisitors}</div>
                    <div class="stat-label">Total Visitors</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:55%"></div></div>
                </div>

                <div class="stat-card c3">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                                <polyline points="9 22 9 12 15 12 15 22"/>
                            </svg>
                        </div>
                        <div class="stat-trend neutral">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <line x1="5" y1="12" x2="19" y2="12"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${totalHosts}</div>
                    <div class="stat-label">Total Hosts</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:40%"></div></div>
                </div>

                <div class="stat-card c4">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="1.8" viewBox="0 0 24 24">
                                <path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"/>
                                <rect x="9" y="3" width="6" height="4" rx="1"/>
                                <line x1="9" y1="12" x2="15" y2="12"/>
                                <line x1="9" y1="16" x2="13" y2="16"/>
                            </svg>
                        </div>
                        <div class="stat-trend up">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <polyline points="18 15 12 9 6 15"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${totalRegistrations}</div>
                    <div class="stat-label">Registrations</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:60%"></div></div>
                </div>

            </div>

            <div class="card">
                <div class="card-header">
                    <div>
                        <div class="card-title">
                            <c:choose>
                                <c:when test="${isSearching}">
                                    Search Results for &quot;<c:out value="${searchQuery}"/>&quot;
                                </c:when>
                                <c:otherwise>Recent Events</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-sub">
                            <c:choose>
                                <c:when test="${isSearching}">
                                    ${empty recentEvents ? 'No events found' : 'Showing matching events'}
                                </c:when>
                                <c:otherwise>Last 5 events added to the system</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="card-header-right">
                        <form action="${pageContext.request.contextPath}/AdminDashboard" method="get" class="search-form">
                            <div class="search-wrap">
                                <svg class="search-icon" width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                    <circle cx="11" cy="11" r="8"/>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                                </svg>
                                <input type="text" name="search" class="search-input"
                                       placeholder="Search events..."
                                       value="<c:out value='${searchQuery}'/>"/>
                                <button type="submit" class="search-btn">Search</button>
                                <c:if test="${isSearching}">
                                    <a href="${pageContext.request.contextPath}/AdminDashboard" class="clear-btn">Clear</a>
                                </c:if>
                            </div>
                        </form>
                        <c:if test="${not isSearching}">
                            <a href="${pageContext.request.contextPath}/events" class="pill-badge">View all →</a>
                        </c:if>
                    </div>
                </div>

                <div class="table-wrapper">
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
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty recentEvents}">
                                    <tr>
                                        <td colspan="8">
                                            <div class="empty-state">
                                                <svg width="36" height="36" fill="none" stroke="#b7dfc8" stroke-width="1.5" viewBox="0 0 24 24">
                                                    <rect x="3" y="4" width="18" height="18" rx="2"/>
                                                    <line x1="3" y1="10" x2="21" y2="10"/>
                                                </svg>
                                                No events found
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="event" items="${recentEvents}" varStatus="s">
                                        <tr>
                                            <td>${s.index + 1}</td>
                                            <td><strong><c:out value="${event.title}"/></strong></td>
                                            <td><c:out value="${event.host}"/></td>
                                            <td><span class="pill-badge"><c:out value="${event.category}"/></span></td>
                                            <td>${event.event_date}</td>
                                            <td><c:out value="${event.location}"/></td>
                                            <td>Rs. ${event.price}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${event.status == 1}">
                                                        <span class="status-pill pill-green">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-pill pill-red">Inactive</span>
                                                    </c:otherwise>
                                                </c:choose>
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
</div>
</body>
</html>