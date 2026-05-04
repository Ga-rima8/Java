<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="logo">Hangaura</div>
    <div class="logo-sub">Admin Panel</div>
    <div class="sidebar-divider"></div>
    <div class="menu-label">Menu</div>
    <a href="${pageContext.request.contextPath}/dashboard"
       class="nav-link ${currentPage == 'dashboard' ? 'active' : ''}">Dashboard</a>
    <a href="${pageContext.request.contextPath}/events"
       class="nav-link ${currentPage == 'events' ? 'active' : ''}">Events</a>
    <a href="${pageContext.request.contextPath}/booking"
       class="nav-link ${currentPage == 'booking' ? 'active' : ''}">Bookings</a>
    <a href="${pageContext.request.contextPath}/report"
       class="nav-link ${currentPage == 'report' ? 'active' : ''}">Reports</a>
    <a href="${pageContext.request.contextPath}/payment"
       class="nav-link ${currentPage == 'payment' ? 'active' : ''}">Payments</a>
    <div class="sidebar-bottom">
        <a href="${pageContext.request.contextPath}/home"
           class="nav-link">Back to Site</a>
    </div>
</div>