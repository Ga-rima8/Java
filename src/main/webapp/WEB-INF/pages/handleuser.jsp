<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Handle Users | Hangaura</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&family=Sora:wght@600;700&display=swap"
          rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/handleuser.css">
</head>
<body>
<c:set var="currentPage" value="handleUser" scope="request"/>

<div class="layout">
    <jsp:include page="sidebar.jsp"/>

    <div class="main">

        <!-- TOPBAR -->
        <div class="topbar">
            <div class="topbar-left">
                <div class="breadcrumb">
                    <span class="breadcrumb-home">Hangaura</span>
                    <span class="breadcrumb-sep">›</span>
                    <span class="breadcrumb-current">Handle Users</span>
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
                    <div class="banner-greeting">Handle Users, Admin</div>
                    <div class="banner-sub">Review, approve or reject user registrations for Hangaura.</div>
                </div>
                <div class="banner-icon-wrap">
                    <svg width="64" height="64" fill="none" viewBox="0 0 64 64">
                        <circle cx="32" cy="32" r="32" fill="rgba(255,255,255,0.08)"/>
                        <path d="M20 44v-2a8 8 0 0 1 8-8h8a8 8 0 0 1 8 8v2"
                              stroke="rgba(255,255,255,0.5)" stroke-width="2" stroke-linecap="round"/>
                        <circle cx="32" cy="26" r="6" stroke="rgba(255,255,255,0.5)" stroke-width="2"/>
                    </svg>
                </div>
            </div>

            <!-- TOAST -->
            <c:if test="${param.msg eq 'approved'}">
                <div class="msg success" id="toast">✓ User approved successfully!</div>
            </c:if>
            <c:if test="${param.msg eq 'rejected'}">
                <div class="msg error" id="toast">✕ User rejected.</div>
            </c:if>
            <c:if test="${param.msg eq 'deleted'}">
                <div class="msg error" id="toast">🗑 User deleted.</div>
            </c:if>

            <!-- STATS -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-label">TOTAL USERS</div>
                    <div class="stat-value">${totalUsers}</div>
                </div>
                <div class="stat-card pending">
                    <div class="stat-label">PENDING</div>
                    <div class="stat-value">${pendingUsers}</div>
                </div>
                <div class="stat-card approved">
                    <div class="stat-label">APPROVED</div>
                    <div class="stat-value">${approvedUsers}</div>
                </div>
                <div class="stat-card rejected">
                    <div class="stat-label">REJECTED</div>
                    <div class="stat-value">${rejectedUsers}</div>
                </div>
            </div>

            <!-- TABLE -->
            <div class="box">
                <div class="box-header">
                    <div>
                        <div class="box-title">All Users</div>
                        <div class="box-sub">Manage and review all registered users</div>
                    </div>
                    <div class="box-badge">${totalUsers} users</div>
                </div>

                <div class="table-wrapper">
                    <table>
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Full Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Joined</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty users}">
                                <tr>
                                    <td colspan="9" class="empty">
                                        <div class="empty-state">No users found.</div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="u" items="${users}" varStatus="loop">
                                    <tr>
                                        <td>${loop.count}</td>
                                        <td class="td-bold">${u.firstName} ${u.lastName}</td>
                                        <td>${u.userName}</td>
                                        <td>${u.email}</td>
                                        <td>${u.number}</td>
                                        <td>${u.gender}</td>
                                        <td>${u.createdAt}</td>
                                        <td>
                                            <span class="status-badge ${u.status}">
                                                ${fn:toUpperCase(fn:substring(u.status,0,1))}${fn:substring(u.status,1,fn:length(u.status))}
                                            </span>
                                        </td>
                                        <td class="actions-cell">
                                            <c:if test="${u.status ne 'approved'}">
                                                <form action="${pageContext.request.contextPath}/handleUser"
                                                      method="post" style="display:inline;">
                                                    <input type="hidden" name="action"  value="approve"/>
                                                    <input type="hidden" name="user_id" value="${u.userId}"/>
                                                    <button type="submit" class="btn-approve">✓ Approve</button>
                                                </form>
                                            </c:if>
                                            <c:if test="${u.status ne 'rejected'}">
                                                <form action="${pageContext.request.contextPath}/handleUser"
                                                      method="post" style="display:inline;">
                                                    <input type="hidden" name="action"  value="reject"/>
                                                    <input type="hidden" name="user_id" value="${u.userId}"/>
                                                    <button type="submit" class="btn-reject">✕ Reject</button>
                                                </form>
                                            </c:if>
                                            <form action="${pageContext.request.contextPath}/handleUser"
                                                  method="post" style="display:inline;"
                                                  onsubmit="return confirm('Delete this user permanently?')">
                                                <input type="hidden" name="action"  value="delete"/>
                                                <input type="hidden" name="user_id" value="${u.userId}"/>
                                                <button type="submit" class="btn-delete">🗑</button>
                                            </form>
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

<script>
    window.onload = function () {
        const t = document.getElementById('toast');
        if (t) {
            setTimeout(() => t.style.opacity = '0', 3000);
            setTimeout(() => t.remove(), 3500);
        }
    };
</script>
</body>
</html>