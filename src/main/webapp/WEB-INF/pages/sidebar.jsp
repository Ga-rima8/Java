<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="sidebar">

    <div class="sidebar-glow-top"></div>

    <div class="sidebar-brand">
        <div class="brand-card">
            <div class="brand-initials">H</div>
            <div class="brand-text">
                <div class="logo">Hangaura</div>
                <div class="logo-sub">Admin Panel</div>
            </div>
        </div>
    </div>

    <div class="brand-divider"></div>

    <div class="sidebar-nav">
        <div class="menu-label">Menu</div>

        <a href="${pageContext.request.contextPath}/AdminDashboard"
           class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <rect x="3" y="3" width="7" height="7" rx="1.5"/>
                <rect x="14" y="3" width="7" height="7" rx="1.5"/>
                <rect x="3" y="14" width="7" height="7" rx="1.5"/>
                <rect x="14" y="14" width="7" height="7" rx="1.5"/>
            </svg>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/handleUser"
           class="nav-link ${currentPage == 'handleUser' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor"
                 stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                <circle cx="9" cy="7" r="4"/>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
            Handle Users
        </a>

        <a href="${pageContext.request.contextPath}/events"
           class="nav-link ${currentPage == 'events' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <rect x="3" y="4" width="18" height="18" rx="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
            </svg>
            Events
        </a>

        <a href="${pageContext.request.contextPath}/updateEvent"
           class="nav-link ${currentPage == 'updateEvent' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
            </svg>
            Update Event
        </a>

        <a href="${pageContext.request.contextPath}/booking"
           class="nav-link ${currentPage == 'booking' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <path d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2"/>
                <rect x="9" y="3" width="6" height="4" rx="1"/>
                <line x1="9" y1="12" x2="15" y2="12"/>
                <line x1="9" y1="16" x2="13" y2="16"/>
            </svg>
            Bookings
        </a>

        <a href="${pageContext.request.contextPath}/report"
           class="nav-link ${currentPage == 'report' ? 'active' : ''}">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <line x1="18" y1="20" x2="18" y2="10"/>
                <line x1="12" y1="20" x2="12" y2="4"/>
                <line x1="6" y1="20" x2="6" y2="14"/>
                <line x1="2" y1="20" x2="22" y2="20"/>
            </svg>
            Reports
        </a>

    </div>

    <div class="sidebar-footer">
        <div class="sidebar-divider"></div>
        <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
            <svg class="nav-icon" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" viewBox="0 0 24 24">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                <polyline points="16 17 21 12 16 7"/>
                <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            Logout
        </a>
    </div>

</div>