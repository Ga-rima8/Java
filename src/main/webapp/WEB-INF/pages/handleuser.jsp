<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users | Hangaura</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=Sora:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/handleuser.css">
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
                    <span class="breadcrumb-current">Manage Users</span>
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

            <!-- ── BANNER ── -->
            <div class="banner">
                <div class="banner-text">
                    <div class="banner-greeting">Manage Users</div>
                    <p class="banner-sub">Review and approve or decline registered visitors.</p>
                </div>
            </div>

            <!-- ── STAT CARDS ── -->
            <div class="stats-grid">

                <div class="stat-card c2">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none" stroke="currentColor" stroke-width="1.9" viewBox="0 0 24 24">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                <circle cx="9" cy="7" r="4"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${totalUsers}</div>
                    <div class="stat-label">Total Users</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:100%"></div></div>
                </div>

                <div class="stat-card c1">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none" stroke="currentColor" stroke-width="1.9" viewBox="0 0 24 24">
                                <circle cx="12" cy="12" r="10"/>
                                <line x1="12" y1="8" x2="12" y2="12"/>
                                <line x1="12" y1="16" x2="12.01" y2="16"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${pendingCount}</div>
                    <div class="stat-label">Pending</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:50%"></div></div>
                </div>

                <div class="stat-card c3">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none" stroke="currentColor" stroke-width="1.9" viewBox="0 0 24 24">
                                <polyline points="20 6 9 17 4 12"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${acceptedCount}</div>
                    <div class="stat-label">Accepted</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:70%"></div></div>
                </div>

                <div class="stat-card c4">
                    <div class="stat-top">
                        <div class="stat-icon">
                            <svg width="19" height="19" fill="none" stroke="currentColor" stroke-width="1.9" viewBox="0 0 24 24">
                                <line x1="18" y1="6" x2="6" y2="18"/>
                                <line x1="6" y1="6" x2="18" y2="18"/>
                            </svg>
                        </div>
                    </div>
                    <div class="stat-num">${declinedCount}</div>
                    <div class="stat-label">Declined</div>
                    <div class="stat-bar"><div class="stat-fill" style="width:30%"></div></div>
                </div>

            </div>

            <!-- ── ERROR ── -->
            <c:if test="${not empty error}">
                <div class="alert-error">${error}</div>
            </c:if>

            <!-- ── USERS TABLE ── -->
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <div class="card-title">All Users</div>
                        <div class="card-sub">Accept or decline visitor registrations</div>
                    </div>
                    <div class="card-header-right">
                        <span class="pill-badge">${totalUsers} Total</span>
                    </div>
                </div>

                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty userList}">
                                    <c:forEach var="user" items="${userList}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${user.name}</td>
                                            <td>${user.email}</td>
                                            <td>${user.address}</td>
                                            <td>
                                                <span class="status-badge status-${user.status}">
                                                    ${user.status}
                                                </span>
                                            </td>
                                            <td class="action-cell">

                                                <!-- Accept -->
                                                <c:if test="${user.status != 'Accepted'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/handleUser">
                                                        <input type="hidden" name="action" value="accept"/>
                                                        <input type="hidden" name="userId" value="${user.id}"/>
                                                        <button type="submit" class="btn-accept">
                                                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                                                                <polyline points="20 6 9 17 4 12"/>
                                                            </svg>
                                                            Accept
                                                        </button>
                                                    </form>
                                                </c:if>

                                                <!-- Decline -->
                                                <c:if test="${user.status != 'Declined'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/handleUser">
                                                        <input type="hidden" name="action" value="decline"/>
                                                        <input type="hidden" name="userId" value="${user.id}"/>
                                                        <button type="submit" class="btn-decline">
                                                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                                                                <line x1="18" y1="6" x2="6" y2="18"/>
                                                                <line x1="6" y1="6" x2="18" y2="18"/>
                                                            </svg>
                                                            Decline
                                                        </button>
                                                    </form>
                                                </c:if>

                                                <!-- Delete -->
                                                <form method="post" action="${pageContext.request.contextPath}/handleUser"
                                                      onsubmit="return confirm('Permanently delete ${user.name}?')">
                                                    <input type="hidden" name="action" value="delete"/>
                                                    <input type="hidden" name="userId" value="${user.id}"/>
                                                    <button type="submit" class="btn-delete">
                                                        <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                                                            <polyline points="3 6 5 6 21 6"/>
                                                            <path d="M19 6l-1 14H6L5 6"/>
                                                            <path d="M9 6V4h6v2"/>
                                                        </svg>
                                                        Delete
                                                    </button>
                                                </form>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="6">
                                            <div class="empty-state">
                                                <svg width="36" height="36" fill="none" stroke="currentColor"
                                                     stroke-width="1.5" viewBox="0 0 24 24" opacity="0.3">
                                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                                                    <circle cx="9" cy="7" r="4"/>
                                                </svg>
                                                <span>No users registered yet</span>
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