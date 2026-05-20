<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Registrations | HangAura</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
  --g50:#ecfdf5;--g100:#d1fae5;--g200:#a7f3d0;
  --g300:#6ee7b7;--g400:#34d399;--g500:#10b981;
  --g600:#059669;--g700:#047857;--g800:#065f46;--g900:#064e3b;
  --bg:#0a0f0d;--bg2:#0d1410;--bg3:#111a15;
  --surface:#162018;--surf2:#1a2820;--surf3:#1f3028;
  --t1:#f0fdf4;--t2:#bbf7d0;--t3:#6ee7b7;
  --muted:#4b6858;--muted2:#365445;
  --em:#34d399;
  --glow:rgba(52,211,153,.18);--glow2:rgba(52,211,153,.07);
  --sb:260px;--topbar-h:60px;
  --radius:14px;--radius-sm:10px;
  --border:rgba(52,211,153,.1);--shadow:0 4px 24px rgba(0,0,0,.45);
}

*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
html{scroll-behavior:smooth;font-size:15px;}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--t1);min-height:100vh;display:flex;overflow-x:hidden;}
a{text-decoration:none;color:inherit;}
body::after{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 70% 50% at 10% 10%,rgba(52,211,153,.04),transparent),radial-gradient(ellipse 50% 70% at 90% 90%,rgba(16,185,129,.03),transparent);pointer-events:none;z-index:0;}

/* SIDEBAR */
.sidebar{width:var(--sb);min-height:100vh;background:var(--bg2);border-right:1px solid var(--border);display:flex;flex-direction:column;position:fixed;top:0;left:0;z-index:300;transition:transform .3s cubic-bezier(.4,0,.2,1);overflow-y:auto;overflow-x:hidden;}
.sb-logo{display:flex;align-items:center;gap:10px;padding:22px 20px 18px;border-bottom:1px solid var(--border);flex-shrink:0;}
.sb-logo-icon{width:34px;height:34px;background:linear-gradient(135deg,var(--g600),var(--g400));border-radius:9px;display:grid;place-items:center;font-size:14px;color:#fff;box-shadow:0 0 14px rgba(52,211,153,.3);flex-shrink:0;}
.sb-logo h2{font-family:'Sora',sans-serif;font-weight:700;font-size:17px;color:var(--t1);letter-spacing:-.3px;}
.sb-logo h2 span{color:var(--g400);}
.sb-nav{flex:1;padding:14px 12px 8px;display:flex;flex-direction:column;gap:0;}
.sb-section-label{font-size:10px;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--muted2);padding:14px 8px 6px;display:flex;align-items:center;gap:8px;}
.sb-section-label::after{content:'';flex:1;height:1px;background:var(--border);opacity:.6;}
.nav-link{display:flex;align-items:center;gap:10px;padding:9px 10px;border-radius:9px;font-size:13.5px;font-weight:500;color:var(--muted);transition:all .18s;position:relative;white-space:nowrap;margin-bottom:2px;}
.nav-link:hover{color:var(--t2);background:var(--glow2);}
.nav-link.active{color:var(--g300);background:rgba(52,211,153,.1);font-weight:600;}
.nav-link.active::after{content:'';position:absolute;right:0;top:22%;bottom:22%;width:3px;background:var(--g400);border-radius:3px 0 0 3px;}
.nav-icon{width:26px;height:26px;display:grid;place-items:center;font-size:12.5px;flex-shrink:0;}
.sb-footer{padding:10px 12px 18px;border-top:1px solid var(--border);flex-shrink:0;}
.sb-user{display:flex;align-items:center;gap:10px;padding:10px 8px;border-radius:10px;background:var(--surf2);border:1px solid var(--border);margin-bottom:8px;}
.sb-user-avatar{width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:12px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600);}
.sb-user-avatar img{width:100%;height:100%;object-fit:cover;}
.sb-user-info{flex:1;overflow:hidden;}
.sb-user-name{font-size:12px;font-weight:600;color:var(--t1);display:block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
.sb-user-role{font-size:10.5px;color:var(--muted);}
.logout-link{color:#f87171!important;}
.logout-link:hover{background:rgba(248,113,113,.08)!important;color:#fca5a5!important;}
.sb-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:250;backdrop-filter:blur(2px);}
.sb-overlay.show{display:block;}

/* MAIN */
.main{flex:1;margin-left:var(--sb);min-height:100vh;display:flex;flex-direction:column;position:relative;z-index:1;}

/* TOPBAR */
.topbar{height:var(--topbar-h);display:flex;align-items:center;justify-content:space-between;padding:0 24px;background:rgba(13,20,16,.88);border-bottom:1px solid var(--border);backdrop-filter:blur(14px);position:sticky;top:0;z-index:200;flex-shrink:0;}
.topbar-left{display:flex;align-items:center;gap:12px;}
.topbar-right{display:flex;align-items:center;gap:10px;}
.hamburger{display:none;background:none;border:none;color:var(--t2);font-size:17px;cursor:pointer;padding:6px;border-radius:7px;transition:background .15s;}
.hamburger:hover{background:var(--surf2);}
.breadcrumb{font-family:'Sora',sans-serif;font-size:14px;font-weight:600;color:var(--t3);letter-spacing:.4px;}
.breadcrumb span{color:var(--muted);font-weight:400;font-size:12px;margin:0 5px;}
.notif-btn{width:34px;height:34px;border-radius:9px;background:var(--surf2);border:1px solid var(--border);display:grid;place-items:center;cursor:pointer;color:var(--t2);position:relative;font-size:13px;transition:all .2s;}
.notif-btn:hover{border-color:var(--g400);color:var(--g400);}
.notif-dot{width:6px;height:6px;background:var(--g400);border-radius:50%;position:absolute;top:8px;right:8px;box-shadow:0 0 5px var(--g400);}
.user-dropdown{position:relative;}
.user-trigger{display:flex;align-items:center;gap:7px;cursor:pointer;padding:5px 9px;border-radius:9px;transition:background .2s;}
.user-trigger:hover{background:var(--surf2);}
.avatar-sm{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:12px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600);}
.avatar-sm img,.avatar-md img{width:100%;height:100%;object-fit:cover;}
.avatar-md{width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:15px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600);}
.user-name{font-size:13px;font-weight:600;color:var(--t1);}
.chev{font-size:10px;color:var(--muted);transition:transform .2s;}
.user-trigger:hover .chev{transform:rotate(180deg);}
.dropdown-menu{display:none;position:absolute;top:calc(100% + 8px);right:0;width:210px;background:var(--surf2);border:1px solid var(--border);border-radius:13px;overflow:hidden;box-shadow:0 20px 48px rgba(0,0,0,.5);z-index:999;animation:dropIn .18s ease;}
.dropdown-menu.show{display:block;}
@keyframes dropIn{from{opacity:0;transform:translateY(-5px)}to{opacity:1;transform:translateY(0)}}
.dropdown-header{display:flex;align-items:center;gap:10px;padding:14px 14px 12px;background:var(--bg3);}
.dropdown-header strong{font-size:12.5px;color:var(--t1);display:block;}
.dropdown-header small{font-size:11px;color:var(--muted);}
.dd-divider{height:1px;background:var(--border);margin:3px 0;}
.dropdown-item{display:flex;align-items:center;gap:9px;padding:9px 14px;font-size:13px;color:var(--t2);transition:all .15s;}
.dropdown-item i{width:14px;color:var(--g400);font-size:11px;}
.dropdown-item:hover{background:var(--glow2);color:var(--g300);}
.dropdown-item.logout-item{color:#f87171;}
.dropdown-item.logout-item i{color:#f87171;}
.dropdown-item.logout-item:hover{background:rgba(248,113,113,.07);}

/* ALERTS */
.alert{display:flex;align-items:center;gap:9px;padding:12px 18px;margin:18px 24px 0;border-radius:var(--radius-sm);font-size:13.5px;font-weight:500;animation:slideDown .3s ease;}
@keyframes slideDown{from{opacity:0;transform:translateY(-8px)}to{opacity:1;transform:translateY(0)}}
.alert-success{background:rgba(52,211,153,.1);color:var(--g300);border:1px solid rgba(52,211,153,.2);}
.alert-error{background:rgba(248,113,113,.09);color:#fca5a5;border:1px solid rgba(248,113,113,.18);}
.alert-close{margin-left:auto;background:none;border:none;color:inherit;cursor:pointer;opacity:.6;font-size:11px;padding:2px 4px;}
.alert-close:hover{opacity:1;}

/* PAGE */
.page-body{padding:22px 24px 40px;flex:1;max-width:100%;overflow-x:hidden;}
.page-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:22px;flex-wrap:wrap;gap:12px;}
.page-header-left h1{font-family:'Sora',sans-serif;font-size:22px;font-weight:700;color:var(--t1);}
.page-header-left p{color:var(--muted);font-size:13px;margin-top:3px;}
.page-header-right{display:flex;gap:8px;align-items:center;}

/* STAT CHIPS */
.stat-chips{display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap;}
.stat-chip{display:flex;align-items:center;gap:7px;background:var(--bg3);border:1px solid rgba(52,211,153,.08);border-radius:10px;padding:10px 14px;animation:fadeUp .4s ease both;}
@keyframes fadeUp{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}
.stat-chip-icon{width:34px;height:34px;border-radius:9px;display:grid;place-items:center;font-size:14px;flex-shrink:0;}
.stat-chip-icon.green{background:rgba(52,211,153,.11);color:var(--g400);}
.stat-chip-icon.teal{background:rgba(20,184,166,.11);color:#2dd4bf;}
.stat-chip-icon.lime{background:rgba(163,230,53,.09);color:#a3e635;}
.stat-chip-body strong{display:block;font-family:'Sora',sans-serif;font-size:18px;font-weight:700;color:var(--t1);line-height:1;}
.stat-chip-body span{font-size:11px;color:var(--muted);}

/*
 * FILTER BAR
 * FIX: this is now a real HTML form that submits GET parameters to the servlet.
 * The servlet handles filtering/sorting; the JSP only renders results.
 */
.filter-form{display:flex;align-items:center;gap:10px;margin-bottom:20px;flex-wrap:wrap;}
.search-wrap{position:relative;flex:1;min-width:200px;max-width:360px;}
.search-wrap input{width:100%;background:var(--bg3);border:1px solid var(--border);border-radius:10px;padding:9px 12px 9px 36px;font-size:13px;color:var(--t1);font-family:'DM Sans',sans-serif;outline:none;transition:border-color .2s;}
.search-wrap input::placeholder{color:var(--muted);}
.search-wrap input:focus{border-color:rgba(52,211,153,.35);}
.search-wrap i{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:12px;pointer-events:none;}
.filter-select{background:var(--bg3);border:1px solid var(--border);border-radius:10px;padding:9px 32px 9px 12px;font-size:13px;color:var(--t2);font-family:'DM Sans',sans-serif;outline:none;cursor:pointer;appearance:none;-webkit-appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6' fill='none'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%234b6858' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 10px center;transition:border-color .2s;}
.filter-select:focus{border-color:rgba(52,211,153,.35);}
.btn-filter{display:inline-flex;align-items:center;gap:5px;font-size:12.5px;font-weight:600;padding:9px 14px;border-radius:9px;background:linear-gradient(135deg,var(--g600),var(--g500));color:#fff;border:none;cursor:pointer;transition:all .2s;}
.btn-filter:hover{box-shadow:0 4px 12px rgba(52,211,153,.3);}
.btn-reset{display:inline-flex;align-items:center;gap:5px;font-size:12.5px;font-weight:600;padding:9px 12px;border-radius:9px;background:var(--surf2);color:var(--muted);border:1px solid var(--border);cursor:pointer;transition:all .2s;text-decoration:none;}
.btn-reset:hover{color:var(--t2);border-color:rgba(52,211,153,.25);}

/* TABLE */
.reg-box{background:var(--bg3);border:1px solid rgba(52,211,153,.08);border-radius:var(--radius);overflow:hidden;animation:fadeUp .5s ease both;}
.box-header{display:flex;align-items:center;justify-content:space-between;padding:16px 18px 13px;border-bottom:1px solid rgba(52,211,153,.07);}
.box-header h2{font-family:'Sora',sans-serif;font-size:13.5px;font-weight:600;color:var(--t1);display:flex;align-items:center;gap:6px;}
.box-badge{font-size:10.5px;font-weight:600;background:rgba(52,211,153,.1);color:var(--g400);padding:2px 8px;border-radius:20px;border:1px solid rgba(52,211,153,.17);}
.table-wrap{overflow-x:auto;}
.reg-table{width:100%;border-collapse:collapse;font-size:13px;}
.reg-table thead tr{border-bottom:1px solid rgba(52,211,153,.1);}
.reg-table th{padding:11px 16px;text-align:left;font-size:10.5px;font-weight:700;text-transform:uppercase;letter-spacing:.7px;color:var(--muted);white-space:nowrap;}
.reg-table tbody tr{border-bottom:1px solid rgba(52,211,153,.04);transition:background .15s;animation:fadeUp .4s ease both;}
.reg-table tbody tr:last-child{border-bottom:none;}
.reg-table tbody tr:hover{background:var(--glow2);}
.reg-table td{padding:13px 16px;color:var(--t2);vertical-align:middle;}
.event-name-cell{display:flex;align-items:center;gap:10px;}
.event-color-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0;}
.event-name-text{font-weight:600;color:var(--t1);font-size:13px;}
.event-cat-pill{display:inline-block;font-size:10px;font-weight:600;text-transform:uppercase;letter-spacing:.5px;color:var(--g400);background:rgba(52,211,153,.08);border:1px solid rgba(52,211,153,.15);padding:1px 6px;border-radius:4px;margin-top:2px;}
.date-cell{display:flex;align-items:center;gap:5px;color:var(--t2);font-size:12.5px;}
.date-cell i{color:var(--g600);font-size:10.5px;}
.loc-cell{display:flex;align-items:center;gap:5px;font-size:12.5px;color:var(--t2);}
.loc-cell i{color:var(--g600);font-size:10px;}
.status-badge{display:inline-flex;align-items:center;gap:4px;padding:3px 9px;border-radius:20px;font-size:11px;font-weight:600;}
.status-badge.confirmed{background:rgba(52,211,153,.1);color:var(--g300);border:1px solid rgba(52,211,153,.2);}
.status-badge.pending{background:rgba(251,191,36,.09);color:#fbbf24;border:1px solid rgba(251,191,36,.2);}
.status-badge.cancelled{background:rgba(248,113,113,.09);color:#f87171;border:1px solid rgba(248,113,113,.2);}
.status-dot{width:5px;height:5px;border-radius:50%;background:currentColor;}
.cap-wrap{display:flex;align-items:center;gap:7px;}
.cap-text{font-size:11.5px;color:var(--t2);white-space:nowrap;}
.cap-bar{width:60px;height:4px;background:var(--surf3);border-radius:99px;overflow:hidden;flex-shrink:0;}
.cap-fill{height:100%;border-radius:99px;background:linear-gradient(90deg,var(--g600),var(--g400));box-shadow:0 0 4px rgba(52,211,153,.3);}
.btn-action{display:inline-flex;align-items:center;gap:5px;font-size:11.5px;font-weight:600;padding:5px 11px;border-radius:7px;border:1px solid rgba(248,113,113,.25);color:#f87171;background:rgba(248,113,113,.06);transition:all .2s;cursor:pointer;white-space:nowrap;}
.btn-action:hover{background:rgba(248,113,113,.14);border-color:rgba(248,113,113,.4);}
.btn-view{border-color:rgba(52,211,153,.2);color:var(--g400);background:rgba(52,211,153,.06);}
.btn-view:hover{background:rgba(52,211,153,.13);border-color:var(--g400);}
.empty-state{display:flex;flex-direction:column;align-items:center;gap:12px;padding:54px 18px;color:var(--muted);text-align:center;}
.empty-icon-wrap{width:70px;height:70px;border-radius:50%;background:rgba(52,211,153,.05);border:1px solid rgba(52,211,153,.1);display:grid;place-items:center;}
.empty-state i{font-size:28px;color:var(--muted2);}
.empty-state h3{font-family:'Sora',sans-serif;font-size:15px;font-weight:600;color:var(--t3);}
.empty-state p{font-size:12.5px;max-width:280px;line-height:1.6;}
.btn-primary{display:inline-flex;align-items:center;gap:6px;background:linear-gradient(135deg,var(--g600),var(--g500));color:#fff;font-size:13px;font-weight:600;padding:9px 18px;border-radius:9px;border:none;cursor:pointer;transition:all .2s;box-shadow:0 4px 14px rgba(52,211,153,.2);}
.btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 20px rgba(52,211,153,.3);}

/* RESPONSIVE */
@media(max-width:768px){.sidebar{transform:translateX(-100%)}.sidebar.open{transform:translateX(0)}.main{margin-left:0}.hamburger{display:flex;align-items:center;justify-content:center}.page-body{padding:14px 14px 36px}.topbar{padding:0 14px}.stat-chips{gap:8px}}
@media(max-width:480px){.filter-form{flex-direction:column;align-items:stretch}.search-wrap{max-width:100%}.alert{margin:12px 14px 0}}
</style>
</head>
<body>

<c:set var="hasImage" value="${not empty user.profileImage}"/>

<!-- SIDEBAR -->
<div class="sidebar" id="sidebar">
  <div class="sb-logo">
    <span class="sb-logo-icon"><i class="fas fa-leaf"></i></span>
    <h2>Hang<span>Aura</span></h2>
  </div>
  <nav class="sb-nav">
    <div class="sb-section-label">Main</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
      <span class="nav-icon"><i class="fas fa-th-large"></i></span><span>Dashboard</span>
    </a>
    <a href="${pageContext.request.contextPath}/Home" class="nav-link">
      <span class="nav-icon"><i class="fas fa-home"></i></span><span>Home</span>
    </a>
    <div class="sb-section-label">Events</div>
    <a href="${pageContext.request.contextPath}/Event" class="nav-link">
      <span class="nav-icon"><i class="fas fa-calendar-alt"></i></span><span>Browse Events</span>
    </a>
    <a href="${pageContext.request.contextPath}/myregistrations" class="nav-link active">
      <span class="nav-icon"><i class="fas fa-ticket-alt"></i></span><span>My Registrations</span>
    </a>
    <div class="sb-section-label">Account</div>
    <a href="${pageContext.request.contextPath}/profile" class="nav-link">
      <span class="nav-icon"><i class="fas fa-user-edit"></i></span><span>Edit Profile</span>
    </a>
  </nav>
  <div class="sb-footer">
    <div class="sb-user">
      <div class="sb-user-avatar">
        <c:choose>
          <c:when test="${hasImage}"><img src="${pageContext.request.contextPath}/profileImage" alt="avatar"></c:when>
          <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
        </c:choose>
      </div>
      <div class="sb-user-info">
        <span class="sb-user-name"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
        <span class="sb-user-role">Member</span>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
      <span class="nav-icon"><i class="fas fa-sign-out-alt"></i></span><span>Logout</span>
    </a>
  </div>
</div>
<div class="sb-overlay" id="sbOverlay" onclick="closeSidebar()"></div>

<!-- MAIN -->
<div class="main" id="mainContent">

  <!-- TOPBAR -->
  <div class="topbar">
    <div class="topbar-left">
      <button class="hamburger" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/dashboard" style="color:var(--muted);font-size:12px;">Dashboard</a>
        <span>/</span>My Registrations
      </div>
    </div>
    <div class="topbar-right">
      <div class="notif-btn"><i class="fas fa-bell"></i><span class="notif-dot"></span></div>
      <div class="user-dropdown" id="userDropdown">
        <div class="user-trigger" onclick="toggleDropdown()">
          <div class="avatar-sm">
            <c:choose>
              <c:when test="${hasImage}"><img src="${pageContext.request.contextPath}/profileImage" alt="avatar"></c:when>
              <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
            </c:choose>
          </div>
          <span class="user-name"><c:out value="${not empty user.firstName ? user.firstName : 'User'}"/></span>
          <i class="fas fa-chevron-down chev"></i>
        </div>
        <div class="dropdown-menu" id="dropdownMenu">
          <div class="dropdown-header">
            <div class="avatar-md">
              <c:choose>
                <c:when test="${hasImage}"><img src="${pageContext.request.contextPath}/profileImage" alt="avatar"></c:when>
                <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
              </c:choose>
            </div>
            <div>
              <strong><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></strong>
              <small><c:out value="${user.email}"/></small>
            </div>
          </div>
          <div class="dd-divider"></div>
          <a href="${pageContext.request.contextPath}/dashboard" class="dropdown-item"><i class="fas fa-th-large"></i> Dashboard</a>
          <a href="${pageContext.request.contextPath}/profile"   class="dropdown-item"><i class="fas fa-user-edit"></i> Edit Profile</a>
          <div class="dd-divider"></div>
          <a href="${pageContext.request.contextPath}/logout"    class="dropdown-item logout-item"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- ALERTS -->
  <c:if test="${not empty message}">
    <div class="alert alert-success" id="alertMsg">
      <i class="fas fa-check-circle"></i> <c:out value="${message}"/>
      <button class="alert-close" onclick="this.parentElement.remove()"><i class="fas fa-times"></i></button>
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-error" id="alertMsg">
      <i class="fas fa-exclamation-circle"></i> <c:out value="${error}"/>
      <button class="alert-close" onclick="this.parentElement.remove()"><i class="fas fa-times"></i></button>
    </div>
  </c:if>
  <c:remove var="message" scope="session"/>
  <c:remove var="error" scope="session"/>

  <!-- PAGE BODY -->
  <div class="page-body">

    <div class="page-header">
      <div class="page-header-left">
        <h1><i class="fas fa-ticket-alt" style="color:var(--g400);margin-right:8px;font-size:18px;"></i>My Registrations</h1>
        <p>All the events you've registered for, in one place.</p>
      </div>
      <div class="page-header-right">
        <a href="${pageContext.request.contextPath}/Event" class="btn-primary">
          <i class="fas fa-search"></i> Browse Events
        </a>
      </div>
    </div>

    <!-- STAT CHIPS (counts based on full list, set by servlet) -->
    <div class="stat-chips">
      <div class="stat-chip" style="--delay:.05s">
        <div class="stat-chip-icon green"><i class="fas fa-ticket-alt"></i></div>
        <div class="stat-chip-body">
          <strong><c:out value="${not empty registeredCount ? registeredCount : 0}"/></strong>
          <span>Total Registered</span>
        </div>
      </div>
      <div class="stat-chip" style="--delay:.1s">
        <div class="stat-chip-icon teal"><i class="fas fa-clock"></i></div>
        <div class="stat-chip-body">
          <strong><c:out value="${not empty upcomingCount ? upcomingCount : 0}"/></strong>
          <span>Upcoming</span>
        </div>
      </div>
      <div class="stat-chip" style="--delay:.15s">
        <div class="stat-chip-icon lime"><i class="fas fa-check-double"></i></div>
        <div class="stat-chip-body">
          <strong><c:out value="${not empty completedCount ? completedCount : 0}"/></strong>
          <span>Completed</span>
        </div>
      </div>
    </div>

    <%--
      FIX: Filter and sort controls are a real HTML GET form.
      Parameters q, status, sort are submitted to the servlet, which
      calls RegistrationService to filter/sort, and sets the result
      as "registeredEvents". The JSP only renders what the servlet gives it.
      The old JS filterTable() and sortTable() functions are gone.
    --%>
    <form method="get"
          action="${pageContext.request.contextPath}/myregistrations"
          class="filter-form">
      <div class="search-wrap">
        <i class="fas fa-search"></i>
        <input type="text" name="q" placeholder="Search events, locations&hellip;"
               value="<c:out value='${filterQuery}'/>">
      </div>
      <select name="status" class="filter-select">
        <option value="">All Status</option>
        <option value="confirmed" ${filterStatus == 'confirmed' ? 'selected' : ''}>Confirmed</option>
        <option value="pending"   ${filterStatus == 'pending'   ? 'selected' : ''}>Pending</option>
        <option value="cancelled" ${filterStatus == 'cancelled' ? 'selected' : ''}>Cancelled</option>
      </select>
      <select name="sort" class="filter-select">
        <option value="date-asc"  ${filterSort == 'date-asc'  ? 'selected' : ''}>Date: Soonest</option>
        <option value="date-desc" ${filterSort == 'date-desc' ? 'selected' : ''}>Date: Latest</option>
        <option value="name-asc"  ${filterSort == 'name-asc'  ? 'selected' : ''}>Name: A–Z</option>
      </select>
      <button type="submit" class="btn-filter">
        <i class="fas fa-filter"></i> Apply
      </button>
      <a href="${pageContext.request.contextPath}/myregistrations" class="btn-reset">
        <i class="fas fa-times"></i> Reset
      </a>
    </form>

    <!-- TABLE -->
    <div class="reg-box">
      <div class="box-header">
        <h2><i class="fas fa-list" style="color:var(--g400)"></i> Registered Events</h2>
        <%-- visibleCount = filtered count, set by servlet --%>
        <span class="box-badge">
          <c:out value="${not empty visibleCount ? visibleCount : 0}"/> event<c:if test="${visibleCount != 1}">s</c:if>
        </span>
      </div>

      <c:choose>
        <c:when test="${not empty registeredEvents}">
          <div class="table-wrap">
            <table class="reg-table" id="regTable">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Event</th>
                  <th>Date</th>
                  <th>Location</th>
                  <th>Capacity</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="ev" items="${registeredEvents}" varStatus="loop">
                  <tr style="animation-delay:${loop.index * 0.04}s">
                    <td style="color:var(--muted);font-size:12px;">${loop.index + 1}</td>
                    <td>
                      <div class="event-name-cell">
                        <div class="event-color-dot" style="background:var(--g400);"></div>
                        <div>
                          <div class="event-name-text"><c:out value="${ev.eventName}"/></div>
                          <c:if test="${not empty ev.category}">
                            <span class="event-cat-pill"><c:out value="${ev.category}"/></span>
                          </c:if>
                        </div>
                      </div>
                    </td>
                    <td>
                      <div class="date-cell">
                        <i class="fas fa-calendar"></i>
                        <fmt:formatDate value="${ev.eventDate}" pattern="dd MMM yyyy"/>
                      </div>
                    </td>
                    <td>
                      <div class="loc-cell">
                        <i class="fas fa-map-marker-alt"></i>
                        <c:out value="${ev.eventLocation}"/>
                      </div>
                    </td>
                    <td>
                      <div class="cap-wrap">
                        <span class="cap-text"><c:out value="${ev.capacity}"/> / <c:out value="${ev.maxCapacity}"/></span>
                        <div class="cap-bar">
                          <div class="cap-fill" style="width:${ev.maxCapacity > 0 ? (ev.capacity * 100 / ev.maxCapacity) : 0}%"></div>
                        </div>
                      </div>
                    </td>
                    <td>
                      <c:set var="st" value="${not empty ev.status ? ev.status : 'confirmed'}"/>
                      <span class="status-badge ${st}">
                        <span class="status-dot"></span>
                        <c:choose>
                          <c:when test="${st == 'confirmed'}">Confirmed</c:when>
                          <c:when test="${st == 'pending'}">Pending</c:when>
                          <c:when test="${st == 'cancelled'}">Cancelled</c:when>
                          <c:otherwise>Confirmed</c:otherwise>
                        </c:choose>
                      </span>
                    </td>
                    <td>
                      <div style="display:flex;gap:6px;flex-wrap:wrap;">
                        <a href="${pageContext.request.contextPath}/Event?id=${ev.eventId}" class="btn-action btn-view">
                          <i class="fas fa-eye"></i> View
                        </a>
                        <a href="${pageContext.request.contextPath}/cancelRegistration?eventId=${ev.eventId}"
                           class="btn-action"
                           onclick="return confirm('Cancel registration for \'<c:out value="${ev.eventName}"/>\'?')">
                          <i class="fas fa-times"></i> Cancel
                        </a>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <div class="empty-icon-wrap"><i class="fas fa-ticket-alt"></i></div>
            <c:choose>
              <c:when test="${not empty filterQuery or not empty filterStatus}">
                <h3>No matching registrations</h3>
                <p>Try adjusting your search or filter, or <a href="${pageContext.request.contextPath}/myregistrations" style="color:var(--g400)">reset all filters</a>.</p>
              </c:when>
              <c:otherwise>
                <h3>No registrations yet</h3>
                <p>You haven't registered for any events. Browse upcoming events and sign up!</p>
                <a href="${pageContext.request.contextPath}/Event" class="btn-primary" style="margin-top:4px;">
                  <i class="fas fa-search"></i> Browse Events
                </a>
              </c:otherwise>
            </c:choose>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div><!-- /page-body -->
</div><!-- /main -->

<script>
/* UI-only JavaScript — zero data logic */
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('sbOverlay').classList.toggle('show');}
function closeSidebar(){document.getElementById('sidebar').classList.remove('open');document.getElementById('sbOverlay').classList.remove('show');}
function toggleDropdown(){document.getElementById('dropdownMenu').classList.toggle('show');}
document.addEventListener('click',function(e){var dd=document.getElementById('userDropdown');if(dd&&!dd.contains(e.target))document.getElementById('dropdownMenu').classList.remove('show');});
setTimeout(function(){var al=document.getElementById('alertMsg');if(al){al.style.transition='opacity .5s';al.style.opacity='0';setTimeout(function(){if(al&&al.parentNode)al.remove();},500);}},4500);
</script>
</body>
</html>
