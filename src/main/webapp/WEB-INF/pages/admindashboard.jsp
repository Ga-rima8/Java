<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="currentPage" value="dashboard" scope="request" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Hangaura</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
</head>

<body>

<div class="layout">

    <jsp:include page="sidebar.jsp" />

    <div class="main">

        <header class="topbar">

            <div class="topbar-left">
                <div class="breadcrumb">
                    <span class="breadcrumb-home">Admin</span>
                    <span class="breadcrumb-sep">›</span>
                    <span class="breadcrumb-current">Dashboard</span>
                </div>
            </div>

            <div class="topbar-right">
                <div class="admin-pill">
                    <div class="admin-avatar">A</div>
                    <span>Admin</span>
                </div>
            </div>

        </header>

        <div class="content">

            <div class="banner">

                <div class="banner-text">
                    <div class="banner-greeting">
                        Good Morning, Admin!
                    </div>

                    <p class="banner-sub">
                        Here's what's happening on the platform today.
                    </p>
                </div>

            </div>

            <!-- STAT CARDS -->
            <div class="stats-grid">

                <!-- TOTAL EVENTS -->
                <div class="stat-card c1">

                    <div class="stat-top">

                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none"
                                 stroke="currentColor" stroke-width="1.9"
                                 viewBox="0 0 24 24">

                                <rect x="3" y="4" width="18" height="18" rx="2"/>
                                <line x1="16" y1="2" x2="16" y2="6"/>
                                <line x1="8" y1="2" x2="8" y2="6"/>
                                <line x1="3" y1="10" x2="21" y2="10"/>

                            </svg>
                        </div>

                        <div class="stat-trend up">
                            <svg width="11" height="11" fill="none"
                                 stroke="currentColor" stroke-width="2.5"
                                 viewBox="0 0 24 24">

                                <polyline points="18 15 12 9 6 15"/>

                            </svg>
                        </div>

                    </div>

                    <div class="stat-num">${totalEvents}</div>
                    <div class="stat-label">Total Events</div>

                    <div class="stat-bar">
                        <div class="stat-fill" style="width:65%"></div>
                    </div>

                </div>

                <!-- TOTAL VISITORS -->
                <div class="stat-card c2">

                    <div class="stat-top">

                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none"
                                 stroke="currentColor" stroke-width="1.9"
                                 viewBox="0 0 24 24">

                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                <circle cx="9" cy="7" r="4"/>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>

                            </svg>
                        </div>

                        <div class="stat-trend up">
                            <svg width="11" height="11" fill="none"
                                 stroke="currentColor" stroke-width="2.5"
                                 viewBox="0 0 24 24">

                                <polyline points="18 15 12 9 6 15"/>

                            </svg>
                        </div>

                    </div>

                    <div class="stat-num">${totalVisitors}</div>
                    <div class="stat-label">Total Visitors</div>

                    <div class="stat-bar">
                        <div class="stat-fill" style="width:48%"></div>
                    </div>

                </div>

                <!-- TOTAL HOSTS -->
                <div class="stat-card c3">

                    <div class="stat-top">

                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none"
                                 stroke="currentColor" stroke-width="1.9"
                                 viewBox="0 0 24 24">

                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                                <polyline points="9 22 9 12 15 12 15 22"/>

                            </svg>
                        </div>

                        <div class="stat-trend neutral">
                            <svg width="11" height="11" fill="none"
                                 stroke="currentColor" stroke-width="2.5"
                                 viewBox="0 0 24 24">

                                <line x1="5" y1="12" x2="19" y2="12"/>

                            </svg>
                        </div>

                    </div>

                    <div class="stat-num">${totalHosts}</div>
                    <div class="stat-label">Total Hosts</div>

                    <div class="stat-bar">
                        <div class="stat-fill" style="width:30%"></div>
                    </div>

                </div>

                <!-- TOTAL REGISTRATIONS -->
                <div class="stat-card c4">

                    <div class="stat-top">

                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none"
                                 stroke="currentColor" stroke-width="1.9"
                                 viewBox="0 0 24 24">

                                <path d="M2 9a3 3 0 0 1 0 6v2a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2v-2a3 3 0 0 1 0-6V7a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>

                            </svg>
                        </div>

                        <div class="stat-trend up">
                            <svg width="11" height="11" fill="none"
                                 stroke="currentColor" stroke-width="2.5"
                                 viewBox="0 0 24 24">

                                <polyline points="18 15 12 9 6 15"/>

                            </svg>
                        </div>

                    </div>

                    <div class="stat-num">${totalRegistrations}</div>
                    <div class="stat-label">Registrations</div>

                    <div class="stat-bar">
                        <div class="stat-fill" style="width:80%"></div>
                    </div>

                </div>

            </div>

            <!-- RECENT EVENTS TABLE -->
            <div class="card">

                <div class="card-header">

                    <div class="card-header-left">
                        <div class="card-title">Recent Events</div>
                        <div class="card-sub">
                            Latest activity across the platform
                        </div>
                    </div>

                    <div class="card-header-right">
                        <span class="pill-badge">Last 5</span>
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
                            </tr>
                        </thead>

                        <tbody>

                            <c:choose>

                                <c:when test="${not empty recentEvents}">

                                    <c:forEach var="ev"
                                               items="${recentEvents}"
                                               varStatus="loop">

                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${ev.title}</td>
                                            <td>${ev.hostName}</td>
                                            <td>${ev.category}</td>
                                            <td>${ev.date}</td>
                                            <td>${ev.location}</td>
                                            <td>Rs. ${ev.price}</td>
                                        </tr>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>

                                    <tr class="empty-row">

                                        <td colspan="7">

                                            <div class="empty-state">

                                                <svg width="36" height="36"
                                                     fill="none"
                                                     stroke="currentColor"
                                                     stroke-width="1.5"
                                                     viewBox="0 0 24 24"
                                                     opacity="0.3">

                                                    <rect x="3" y="4"
                                                          width="18"
                                                          height="18"
                                                          rx="2"/>

                                                    <line x1="16" y1="2"
                                                          x2="16" y2="6"/>

                                                    <line x1="8" y1="2"
                                                          x2="8" y2="6"/>

                                                    <line x1="3" y1="10"
                                                          x2="21" y2="10"/>

                                                </svg>

                                                <span>No events found yet</span>

                                            </div>

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

</div>

</body>
</html>