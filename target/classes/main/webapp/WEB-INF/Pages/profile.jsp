<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile | HangAura</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* ═══════════════════════════════════ TOKENS ══════ */
:root {
  --g300:#6ee7b7;--g400:#34d399;--g500:#10b981;
  --g600:#059669;--g700:#047857;
  --bg:#0a0f0d;--bg2:#0d1410;--bg3:#111a15;
  --surf2:#1a2820;--surf3:#1f3028;
  --t1:#f0fdf4;--t2:#bbf7d0;--t3:#6ee7b7;
  --muted:#4b6858;--muted2:#365445;
  --glow2:rgba(52,211,153,.07);
  --sb:260px;--topbar-h:60px;
  --radius:14px;--radius-sm:10px;
  --border:rgba(52,211,153,.1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:'DM Sans',sans-serif;background:var(--bg);color:var(--t1);min-height:100vh;display:flex;overflow-x:hidden}
a{text-decoration:none;color:inherit}
body::after{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 70% 50% at 10% 10%,rgba(52,211,153,.04),transparent),radial-gradient(ellipse 50% 70% at 90% 90%,rgba(16,185,129,.03),transparent);pointer-events:none;z-index:0}

/* ═══════════════════════════════════ SIDEBAR ═════ */
.sidebar{width:var(--sb);min-height:100vh;background:var(--bg2);border-right:1px solid var(--border);display:flex;flex-direction:column;position:fixed;top:0;left:0;z-index:300;transition:transform .3s cubic-bezier(.4,0,.2,1);overflow-y:auto;overflow-x:hidden}
.sb-logo{display:flex;align-items:center;gap:10px;padding:22px 20px 18px;border-bottom:1px solid var(--border);flex-shrink:0}
.sb-logo-icon{width:34px;height:34px;background:linear-gradient(135deg,var(--g600),var(--g400));border-radius:9px;display:grid;place-items:center;font-size:14px;color:#fff;box-shadow:0 0 14px rgba(52,211,153,.3);flex-shrink:0}
.sb-logo h2{font-family:'Sora',sans-serif;font-weight:700;font-size:17px;color:var(--t1);letter-spacing:-.3px}
.sb-logo h2 span{color:var(--g400)}
.sb-nav{flex:1;padding:14px 12px 8px;display:flex;flex-direction:column;gap:0}
.sb-section-label{font-size:10px;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--muted2);padding:14px 8px 6px;display:flex;align-items:center;gap:8px}
.sb-section-label::after{content:'';flex:1;height:1px;background:var(--border);opacity:.6}
.nav-link{display:flex;align-items:center;gap:10px;padding:9px 10px;border-radius:9px;font-size:13.5px;font-weight:500;color:var(--muted);transition:all .18s;position:relative;white-space:nowrap;margin-bottom:2px}
.nav-link:hover{color:var(--t2);background:var(--glow2)}
.nav-link.active{color:var(--g300);background:rgba(52,211,153,.1);font-weight:600}
.nav-link.active::after{content:'';position:absolute;right:0;top:22%;bottom:22%;width:3px;background:var(--g400);border-radius:3px 0 0 3px}
.nav-icon{width:26px;height:26px;display:grid;place-items:center;font-size:12.5px;flex-shrink:0}
.sb-footer{padding:10px 12px 18px;border-top:1px solid var(--border);flex-shrink:0}
.sb-user{display:flex;align-items:center;gap:10px;padding:10px 8px;border-radius:10px;background:var(--surf2);border:1px solid var(--border);margin-bottom:8px}
.sb-user-avatar{width:32px;height:32px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:12px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600)}
.sb-user-avatar img{width:100%;height:100%;object-fit:cover}
.sb-user-info{flex:1;overflow:hidden}
.sb-user-name{font-size:12px;font-weight:600;color:var(--t1);display:block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.sb-user-role{font-size:10.5px;color:var(--muted)}
.logout-link{color:#f87171!important}
.logout-link:hover{background:rgba(248,113,113,.08)!important;color:#fca5a5!important}
.sb-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.6);z-index:250;backdrop-filter:blur(2px)}
.sb-overlay.show{display:block}

/* ═══════════════════════════════════ MAIN ════════ */
.main{flex:1;margin-left:var(--sb);min-height:100vh;display:flex;flex-direction:column;position:relative;z-index:1}

/* ═══════════════════════════════════ TOPBAR ══════ */
.topbar{height:var(--topbar-h);display:flex;align-items:center;justify-content:space-between;padding:0 24px;background:rgba(13,20,16,.88);border-bottom:1px solid var(--border);backdrop-filter:blur(14px);position:sticky;top:0;z-index:200;flex-shrink:0}
.topbar-left{display:flex;align-items:center;gap:12px}
.topbar-right{display:flex;align-items:center;gap:10px}
.hamburger{display:none;background:none;border:none;color:var(--t2);font-size:17px;cursor:pointer;padding:6px;border-radius:7px;transition:background .15s}
.hamburger:hover{background:var(--surf2)}
.breadcrumb{font-family:'Sora',sans-serif;font-size:14px;font-weight:600;color:var(--t3);letter-spacing:.4px}
.notif-btn{width:34px;height:34px;border-radius:9px;background:var(--surf2);border:1px solid var(--border);display:grid;place-items:center;cursor:pointer;color:var(--t2);position:relative;font-size:13px;transition:all .2s}
.notif-btn:hover{border-color:var(--g400);color:var(--g400)}
.notif-dot{width:6px;height:6px;background:var(--g400);border-radius:50%;position:absolute;top:8px;right:8px;box-shadow:0 0 5px var(--g400)}
.user-dropdown{position:relative}
.user-trigger{display:flex;align-items:center;gap:7px;cursor:pointer;padding:5px 9px;border-radius:9px;transition:background .2s}
.user-trigger:hover{background:var(--surf2)}
.avatar-sm{width:30px;height:30px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:12px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600)}
.avatar-sm img,.avatar-md img{width:100%;height:100%;object-fit:cover}
.avatar-md{width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:15px;font-weight:700;color:#fff;overflow:hidden;flex-shrink:0;border:2px solid var(--g600)}
.user-name{font-size:13px;font-weight:600;color:var(--t1)}
.chev{font-size:10px;color:var(--muted);transition:transform .2s}
.user-trigger:hover .chev{transform:rotate(180deg)}
.dropdown-menu{display:none;position:absolute;top:calc(100% + 8px);right:0;width:210px;background:var(--surf2);border:1px solid var(--border);border-radius:13px;overflow:hidden;box-shadow:0 20px 48px rgba(0,0,0,.5);z-index:999;animation:dropIn .18s ease}
.dropdown-menu.show{display:block}
@keyframes dropIn{from{opacity:0;transform:translateY(-5px)}to{opacity:1;transform:translateY(0)}}
.dropdown-header{display:flex;align-items:center;gap:10px;padding:14px 14px 12px;background:var(--bg3)}
.dropdown-header strong{font-size:12.5px;color:var(--t1);display:block}
.dropdown-header small{font-size:11px;color:var(--muted)}
.dd-divider{height:1px;background:var(--border);margin:3px 0}
.dropdown-item{display:flex;align-items:center;gap:9px;padding:9px 14px;font-size:13px;color:var(--t2);transition:all .15s}
.dropdown-item i{width:14px;color:var(--g400);font-size:11px}
.dropdown-item:hover{background:var(--glow2);color:var(--g300)}
.dropdown-item.logout-item{color:#f87171}
.dropdown-item.logout-item i{color:#f87171}
.dropdown-item.logout-item:hover{background:rgba(248,113,113,.07)}

/* ═══════════════════════════════════ ALERTS ══════ */
.alert-stack{position:fixed;top:76px;right:20px;z-index:1000;display:flex;flex-direction:column;gap:10px;max-width:340px}
.alert{display:flex;align-items:flex-start;gap:10px;padding:14px 16px;border-radius:12px;font-size:13.5px;font-weight:500;line-height:1.4;box-shadow:0 8px 24px rgba(0,0,0,.4);animation:slideIn .35s cubic-bezier(.34,1.56,.64,1) both;position:relative}
@keyframes slideIn{from{opacity:0;transform:translateX(30px) scale(.95)}to{opacity:1;transform:translateX(0) scale(1)}}
@keyframes slideOut{from{opacity:1;transform:translateX(0) scale(1);max-height:100px}to{opacity:0;transform:translateX(30px) scale(.95);max-height:0}}
.alert.dismissing{animation:slideOut .3s ease both}
.alert-success{background:rgba(6,78,59,.9);backdrop-filter:blur(12px);color:#6ee7b7;border:1px solid rgba(52,211,153,.3)}
.alert-error{background:rgba(69,10,10,.9);backdrop-filter:blur(12px);color:#fca5a5;border:1px solid rgba(248,113,113,.3)}
.alert-icon{font-size:15px;flex-shrink:0;margin-top:1px}
.alert-body{flex:1}
.alert-close{background:none;border:none;color:inherit;opacity:.6;cursor:pointer;font-size:12px;padding:2px;flex-shrink:0;transition:opacity .2s}
.alert-close:hover{opacity:1}
.alert-progress{position:absolute;bottom:0;left:0;height:3px;border-radius:0 0 12px 12px;background:currentColor;opacity:.4;animation:progress 5s linear forwards}
@keyframes progress{from{width:100%}to{width:0%}}

/* ═══════════════════════════════════ PAGE ════════ */
.page-body{padding:22px 24px 40px;flex:1;max-width:100%;overflow-x:hidden}
.page-header{margin-bottom:20px}
.page-header h1{font-family:'Sora',sans-serif;font-size:20px;font-weight:700;color:var(--t1);display:flex;align-items:center;gap:8px;margin-bottom:4px}
.page-header h1 i{color:var(--g400);font-size:17px}
.page-header p{font-size:13px;color:var(--muted)}

/* ═══════════════════════════════════ GRID ════════ */
.edit-grid{display:grid;grid-template-columns:1fr 280px;gap:18px;align-items:start}
.box{background:var(--bg3);border:1px solid rgba(52,211,153,.08);border-radius:var(--radius);overflow:hidden}
.box-header{display:flex;align-items:center;justify-content:space-between;padding:16px 20px 13px;border-bottom:1px solid rgba(52,211,153,.07)}
.box-header h2{font-family:'Sora',sans-serif;font-size:13.5px;font-weight:600;color:var(--t1);display:flex;align-items:center;gap:6px}

/* avatar section */
.avatar-section{display:flex;align-items:center;gap:20px;padding:20px;border-bottom:1px solid rgba(52,211,153,.06);background:linear-gradient(to bottom,rgba(52,211,153,.03),transparent)}
.avatar-wrap{position:relative;width:80px;height:80px;flex-shrink:0}
.avatar-display{width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,var(--g700),var(--g500));border:3px solid var(--g700);display:grid;place-items:center;font-family:'Sora',sans-serif;font-size:28px;font-weight:700;color:#fff;overflow:hidden;position:relative;z-index:2}
.avatar-display img{width:100%;height:100%;object-fit:cover}
.avatar-ring{position:absolute;inset:-5px;border-radius:50%;border:2px solid transparent;background:linear-gradient(135deg,var(--g400),var(--g700)) border-box;-webkit-mask:linear-gradient(#fff 0 0) padding-box,linear-gradient(#fff 0 0);-webkit-mask-composite:destination-out;mask-composite:exclude;animation:spin 6s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.avatar-info{flex:1}
.avatar-info strong{display:block;font-family:'Sora',sans-serif;font-size:15px;font-weight:600;color:var(--t1);margin-bottom:3px}
.username-tag{font-size:11.5px;color:var(--g400);background:rgba(52,211,153,.08);padding:2px 9px;border-radius:20px;display:inline-block;border:1px solid rgba(52,211,153,.15)}
.change-photo-btn{display:inline-flex;align-items:center;gap:6px;font-size:12px;font-weight:600;color:var(--g400);background:rgba(52,211,153,.08);border:1px solid rgba(52,211,153,.2);border-radius:8px;padding:7px 14px;cursor:pointer;transition:all .2s;margin-top:10px;white-space:nowrap}
.change-photo-btn:hover{background:rgba(52,211,153,.16);border-color:var(--g400)}
.file-input-hidden{display:none}

/* form fields */
.form-body{padding:20px}
.form-section-title{font-size:10px;font-weight:700;letter-spacing:1px;text-transform:uppercase;color:var(--muted2);margin:20px 0 12px;padding-bottom:8px;border-bottom:1px solid rgba(52,211,153,.07);display:flex;align-items:center;gap:8px}
.form-section-title::after{content:'';flex:1;height:1px;background:var(--border);opacity:.5}
.form-section-title:first-child{margin-top:0}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.field{margin-bottom:14px}
.field label{display:block;font-size:11px;font-weight:700;color:var(--muted2);margin-bottom:6px;text-transform:uppercase;letter-spacing:.6px}
.field-wrap{position:relative;display:flex;align-items:center}
.field-icon{position:absolute;left:13px;color:var(--g600);font-size:12px;pointer-events:none;z-index:1}
.field input,.field select{width:100%;height:44px;background:var(--surf2);border:1px solid rgba(52,211,153,.1);border-radius:var(--radius-sm);color:var(--t1);font-family:'DM Sans',sans-serif;font-size:13.5px;padding:0 13px 0 36px;outline:none;transition:border-color .2s,box-shadow .2s,background .2s;-webkit-appearance:none;appearance:none}
.field input:focus,.field select:focus{border-color:var(--g600);box-shadow:0 0 0 3px rgba(52,211,153,.1);background:var(--surf3)}
.field input::placeholder{color:var(--muted);font-size:13px}
.field select option{background:var(--surf2);color:var(--t1)}
.toggle-pw{position:absolute;right:11px;background:none;border:none;color:var(--muted);cursor:pointer;font-size:13px;padding:4px;z-index:1;transition:color .2s}
.toggle-pw:hover{color:var(--g400)}
.select-arrow{position:absolute;right:11px;color:var(--muted);font-size:10px;pointer-events:none;z-index:1}
.field input.has-toggle{padding-right:38px}

/* actions */
.form-actions{display:flex;gap:12px;align-items:center;margin-top:8px;padding-top:18px;border-top:1px solid rgba(52,211,153,.06)}
.btn-submit{flex:1;height:48px;background:linear-gradient(135deg,var(--g700),var(--g500));color:#fff;border:none;border-radius:var(--radius-sm);font-family:'Sora',sans-serif;font-size:13.5px;font-weight:700;cursor:pointer;transition:all .25s;box-shadow:0 4px 16px rgba(52,211,153,.25);display:flex;align-items:center;justify-content:center;gap:8px}
.btn-submit:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(52,211,153,.35);background:linear-gradient(135deg,var(--g600),var(--g400))}
.btn-submit:active{transform:translateY(0)}
.btn-submit.loading{opacity:.7;pointer-events:none}
.btn-cancel{height:48px;padding:0 20px;background:transparent;color:var(--muted);border:1px solid rgba(52,211,153,.12);border-radius:var(--radius-sm);font-family:'DM Sans',sans-serif;font-size:13.5px;font-weight:500;cursor:pointer;transition:all .2s;display:flex;align-items:center;gap:6px;white-space:nowrap}
.btn-cancel:hover{color:var(--t2);border-color:rgba(52,211,153,.25);background:rgba(52,211,153,.04)}

/* right panel */
.right-panel{display:flex;flex-direction:column;gap:14px}
.info-card{background:var(--bg3);border:1px solid rgba(52,211,153,.08);border-radius:var(--radius);padding:18px}
.info-card h4{font-family:'Sora',sans-serif;font-size:12.5px;font-weight:600;color:var(--t2);margin-bottom:10px;display:flex;align-items:center;gap:6px}
.info-card h4 i{color:var(--g500);font-size:11px}
.info-stat{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid rgba(52,211,153,.05);font-size:12.5px}
.info-stat:last-child{border-bottom:none;padding-bottom:0}
.info-stat span:first-child{color:var(--muted)}
.info-stat span:last-child{color:var(--t2);font-weight:500}
.completion-wrap{margin-top:4px}
.completion-label{display:flex;justify-content:space-between;font-size:11.5px;color:var(--muted);margin-bottom:7px}
.completion-pct{font-weight:600;color:var(--g400)}
.completion-track{height:5px;background:var(--surf3);border-radius:99px;overflow:hidden}
.completion-fill{height:100%;background:linear-gradient(90deg,var(--g600),var(--g400));border-radius:99px;transition:width 1s cubic-bezier(.4,0,.2,1);box-shadow:0 0 7px rgba(52,211,153,.4)}
.tip-list{display:flex;flex-direction:column;gap:8px;margin-top:2px}
.tip-item{display:flex;align-items:flex-start;gap:8px;font-size:12px;color:var(--muted);line-height:1.5}
.tip-item i{color:var(--g600);font-size:10px;margin-top:3px;flex-shrink:0}

/* ═══════════════════════════════════ RESPONSIVE ══ */
@media(max-width:1024px){.edit-grid{grid-template-columns:1fr}.right-panel{flex-direction:row;flex-wrap:wrap}.info-card{flex:1;min-width:220px}}
@media(max-width:768px){.sidebar{transform:translateX(-100%)}.sidebar.open{transform:translateX(0)}.main{margin-left:0}.hamburger{display:flex;align-items:center;justify-content:center}.page-body{padding:14px 14px 36px}.form-row{grid-template-columns:1fr;gap:0}.form-actions{flex-direction:column}.btn-cancel{width:100%;justify-content:center}.avatar-section{flex-wrap:wrap}}
@media(max-width:480px){.topbar{padding:0 14px}.alert-stack{right:12px;left:12px;max-width:none;top:70px}.right-panel{flex-direction:column}}
</style>
</head>
<body>

<%-- ── DETERMINE whether user has a profile image (BLOB exists) ── --%>
<c:set var="hasImage" value="${not empty user.profileImage and user.profileImage.length > 0}"/>

<!-- ── ALERT STACK ── -->
<div class="alert-stack" id="alertStack">
  <c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">
      <i class="fas fa-check-circle alert-icon"></i>
      <span class="alert-body"><c:out value="${message}"/></span>
      <button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>
      <div class="alert-progress"></div>
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-error" role="alert">
      <i class="fas fa-exclamation-circle alert-icon"></i>
      <span class="alert-body"><c:out value="${error}"/></span>
      <button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>
      <div class="alert-progress"></div>
    </div>
  </c:if>
</div>
<c:remove var="message" scope="session"/>
<c:remove var="error"   scope="session"/>

<!-- ── OVERLAY ── -->
<div class="sb-overlay" id="sbOverlay" onclick="closeSidebar()"></div>

<!-- ══════════════════════════════════ SIDEBAR ══════════════════════════════ -->
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
    <a href="${pageContext.request.contextPath}/myregistrations" class="nav-link">
      <span class="nav-icon"><i class="fas fa-ticket-alt"></i></span><span>My Registrations</span>
    </a>
    <div class="sb-section-label">Account</div>
    <a href="${pageContext.request.contextPath}/profile" class="nav-link active">
      <span class="nav-icon"><i class="fas fa-user-edit"></i></span><span>Edit Profile</span>
    </a>
    <a href="${pageContext.request.contextPath}/settings" class="nav-link">
      <span class="nav-icon"><i class="fas fa-cog"></i></span><span>Settings</span>
    </a>
  </nav>
  <div class="sb-footer">
    <div class="sb-user">
      <div class="sb-user-avatar" id="sbAvatar">
        <c:choose>
          <c:when test="${hasImage}">
            <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
          </c:when>
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

<!-- ══════════════════════════════════ MAIN ══════════════════════════════════ -->
<div class="main" id="mainContent">

  <!-- TOPBAR -->
  <div class="topbar">
    <div class="topbar-left">
      <button class="hamburger" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
      <div class="breadcrumb">
        <i class="fas fa-user-edit" style="color:var(--g500);margin-right:6px;font-size:13px;"></i>Edit Profile
      </div>
    </div>
    <div class="topbar-right">
      <div class="notif-btn"><i class="fas fa-bell"></i><span class="notif-dot"></span></div>
      <div class="user-dropdown" id="userDropdown">
        <div class="user-trigger" onclick="toggleDropdown()">
          <div class="avatar-sm" id="topbarAvatar">
            <c:choose>
              <c:when test="${hasImage}">
                <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
              </c:when>
              <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
            </c:choose>
          </div>
          <span class="user-name" id="topbarName"><c:out value="${not empty user.firstName ? user.firstName : 'User'}"/></span>
          <i class="fas fa-chevron-down chev"></i>
        </div>
        <div class="dropdown-menu" id="dropdownMenu">
          <div class="dropdown-header">
            <div class="avatar-md">
              <c:choose>
                <c:when test="${hasImage}">
                  <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
                </c:when>
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

  <!-- PAGE BODY -->
  <div class="page-body">

    <div class="page-header">
      <h1><i class="fas fa-user-edit"></i> Edit Profile</h1>
      <p>Keep your information up to date — changes sync to your dashboard instantly.</p>
    </div>

    <div class="edit-grid">

      <!-- FORM CARD -->
      <div class="box">
        <div class="box-header">
          <h2><i class="fas fa-id-card" style="color:var(--g400)"></i> Profile Information</h2>
        </div>

        <form action="${pageContext.request.contextPath}/profile" method="post"
              enctype="multipart/form-data" id="profileForm" novalidate>

          <!-- AVATAR -->
          <div class="avatar-section">
            <div class="avatar-wrap">
              <div class="avatar-display" id="avatarDisplay">
                <c:choose>
                  <c:when test="${hasImage}">
                    <%-- Image served from DB via /profileImage servlet --%>
                    <img src="${pageContext.request.contextPath}/profileImage" alt="Profile" id="avatarImg">
                  </c:when>
                  <c:otherwise>
                    <span><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></span>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="avatar-ring"></div>
            </div>
            <div class="avatar-info">
              <strong><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></strong>
              <span class="username-tag">@<c:out value="${user.userName}"/></span><br>
              <label class="change-photo-btn" for="profileImageInput">
                <i class="fas fa-camera"></i> Change Photo
              </label>
              <input type="file" id="profileImageInput" name="profileImage"
                     class="file-input-hidden" accept="image/jpeg,image/png,image/gif,image/webp"
                     onchange="previewImage(this)">
            </div>
          </div>

          <!-- FIELDS -->
          <div class="form-body">

            <div class="form-section-title">Personal Info</div>

            <div class="form-row">
              <div class="field">
                <label for="fnIn">First Name</label>
                <div class="field-wrap">
                  <i class="fas fa-user field-icon"></i>
                  <input type="text" id="fnIn" name="firstName"
                         value="<c:out value='${user.firstName}'/>"
                         placeholder="First name" required maxlength="50">
                </div>
              </div>
              <div class="field">
                <label for="lnIn">Last Name</label>
                <div class="field-wrap">
                  <i class="fas fa-user field-icon"></i>
                  <input type="text" id="lnIn" name="lastName"
                         value="<c:out value='${user.lastName}'/>"
                         placeholder="Last name" required maxlength="50">
                </div>
              </div>
            </div>

            <div class="field">
              <label for="unIn">Username</label>
              <div class="field-wrap">
                <i class="fas fa-at field-icon"></i>
                <input type="text" id="unIn" name="username"
                       value="<c:out value='${user.userName}'/>"
                       placeholder="username" required maxlength="30">
              </div>
            </div>

            <div class="field">
              <label for="emIn">Email Address</label>
              <div class="field-wrap">
                <i class="fas fa-envelope field-icon"></i>
                <input type="email" id="emIn" name="email"
                       value="<c:out value='${user.email}'/>"
                       placeholder="you@example.com" required maxlength="100">
              </div>
            </div>

            <div class="form-row">
              <div class="field">
                <label for="phIn">Phone Number</label>
                <div class="field-wrap">
                  <i class="fas fa-phone field-icon"></i>
                  <input type="tel" id="phIn" name="phone"
                         value="<c:out value='${user.number}'/>"
                         placeholder="+977 98..." maxlength="20">
                </div>
              </div>
              <div class="field">
                <label for="dobIn">Date of Birth</label>
                <div class="field-wrap">
                  <i class="fas fa-birthday-cake field-icon"></i>
                  <input type="date" id="dobIn" name="dob"
                         value="<fmt:formatDate value='${user.dob}' pattern='yyyy-MM-dd'/>">
                </div>
              </div>
            </div>

            <div class="field">
              <label for="genSel">Gender</label>
              <div class="field-wrap">
                <i class="fas fa-venus-mars field-icon"></i>
                <select id="genSel" name="gender">
                  <option value="" disabled <c:if test="${empty user.gender}">selected</c:if>>Select gender</option>
                  <option value="Male"   <c:if test="${user.gender == 'Male'}">selected</c:if>>Male</option>
                  <option value="Female" <c:if test="${user.gender == 'Female'}">selected</c:if>>Female</option>
                  <option value="Other"  <c:if test="${user.gender == 'Other'}">selected</c:if>>Other / Prefer not to say</option>
                </select>
                <i class="fas fa-chevron-down select-arrow"></i>
              </div>
            </div>

            <div class="form-section-title">Security</div>

            <div class="field">
              <label for="pwIn">Password</label>
              <div class="field-wrap">
                <i class="fas fa-lock field-icon"></i>
                <input type="password" id="pwIn" name="password"
                       class="has-toggle"
                       placeholder="Leave blank to keep current password"
                       maxlength="100" autocomplete="new-password">
                <button type="button" class="toggle-pw" onclick="togglePw()">
                  <i class="fas fa-eye" id="pwEye"></i>
                </button>
              </div>
            </div>

            <div class="form-actions">
              <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-save"></i> Save Changes
              </button>
              <a href="${pageContext.request.contextPath}/dashboard" class="btn-cancel">
                <i class="fas fa-arrow-left"></i> Back
              </a>
            </div>

          </div><%-- /form-body --%>
        </form>
      </div><%-- /box --%>

      <!-- RIGHT PANEL -->
      <div class="right-panel">

        <div class="info-card">
          <h4><i class="fas fa-chart-pie"></i> Profile Completion</h4>
          <div class="completion-wrap">
            <div class="completion-label">
              <span>Filled fields</span>
              <span class="completion-pct" id="pctLabel">0%</span>
            </div>
            <div class="completion-track">
              <div class="completion-fill" id="pctFill" style="width:0%"></div>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h4><i class="fas fa-chart-bar"></i> Account Info</h4>
          <div class="info-stat">
            <span>Member Since</span>
            <span>—</span><%-- createdAt not in UserModel; add if needed --%>
          </div>
          <div class="info-stat">
            <span>Status</span>
            <span style="color:var(--g400)"><i class="fas fa-circle" style="font-size:7px"></i> Active</span>
          </div>
          <div class="info-stat">
            <span>Username</span>
            <span>@<c:out value="${user.userName}"/></span>
          </div>
        </div>

        <div class="info-card">
          <h4><i class="fas fa-shield-alt"></i> Profile Tips</h4>
          <div class="tip-list">
            <div class="tip-item"><i class="fas fa-check-circle"></i> Use a clear, recent photo for your avatar.</div>
            <div class="tip-item"><i class="fas fa-check-circle"></i> Keep your phone number current for notifications.</div>
            <div class="tip-item"><i class="fas fa-check-circle"></i> Leave the password field blank to keep your current one.</div>
          </div>
        </div>

      </div><%-- /right-panel --%>

    </div><%-- /edit-grid --%>
  </div><%-- /page-body --%>
</div><%-- /main --%>

<script>
/* ── sidebar ── */
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('sbOverlay').classList.toggle('show')}
function closeSidebar(){document.getElementById('sidebar').classList.remove('open');document.getElementById('sbOverlay').classList.remove('show')}

/* ── dropdown ── */
function toggleDropdown(){document.getElementById('dropdownMenu').classList.toggle('show')}
document.addEventListener('click',function(e){var dd=document.getElementById('userDropdown');if(dd&&!dd.contains(e.target))document.getElementById('dropdownMenu').classList.remove('show')});

/* ── avatar preview (live, before upload) ── */
function previewImage(input){
  if(!input.files||!input.files[0])return;
  var f=input.files[0];
  if(f.size>5*1024*1024){showAlert('Image must be under 5 MB.','error');input.value='';return}
  var r=new FileReader();
  r.onload=function(e){
    var src=e.target.result;
    /* large avatar */
    document.getElementById('avatarDisplay').innerHTML='<img src="'+src+'" alt="Preview" style="width:100%;height:100%;object-fit:cover">';
    /* topbar */
    var ta=document.getElementById('topbarAvatar');
    if(ta)ta.innerHTML='<img src="'+src+'" alt="" style="width:100%;height:100%;object-fit:cover">';
    /* sidebar */
    var sa=document.getElementById('sbAvatar');
    if(sa)sa.innerHTML='<img src="'+src+'" alt="" style="width:100%;height:100%;object-fit:cover">';
  };
  r.readAsDataURL(f);
}

/* ── password toggle ── */
function togglePw(){var i=document.getElementById('pwIn'),e=document.getElementById('pwEye');if(i.type==='password'){i.type='text';e.classList.replace('fa-eye','fa-eye-slash')}else{i.type='password';e.classList.replace('fa-eye-slash','fa-eye')}}

/* ── alerts ── */
function dismissAlert(btn){var a=btn.closest('.alert');a.classList.add('dismissing');setTimeout(function(){a.remove()},300)}
function showAlert(msg,type){
  var s=document.getElementById('alertStack'),d=document.createElement('div');
  d.className='alert alert-'+(type||'success');d.setAttribute('role','alert');
  d.innerHTML='<i class="fas fa-'+(type==='error'?'exclamation-circle':'check-circle')+' alert-icon"></i>'
    +'<span class="alert-body">'+msg+'</span>'
    +'<button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>'
    +'<div class="alert-progress"></div>';
  s.appendChild(d);
  setTimeout(function(){if(d.parentNode)dismissAlert(d.querySelector('.alert-close'))},5200);
}
document.querySelectorAll('.alert').forEach(function(el){
  setTimeout(function(){if(el.parentNode)dismissAlert(el.querySelector('.alert-close'))},5200);
});

/* ── profile completion (reads JSTL booleans rendered into JS) ── */
(function(){
  var fields=[
    '${not empty user.firstName}',
    '${not empty user.lastName}',
    '${not empty user.email}',
    '${not empty user.number}',
    '${not empty user.dob}',
    '${not empty user.gender}',
    '${hasImage}'
  ];
  var filled=fields.filter(function(f){return f==='true'}).length;
  var pct=Math.round(filled/fields.length*100);
  setTimeout(function(){
    document.getElementById('pctFill').style.width=pct+'%';
    document.getElementById('pctLabel').textContent=pct+'%';
  },400);
})();

/* ── form submit — loading state ── */
document.getElementById('profileForm').addEventListener('submit',function(){
  var btn=document.getElementById('submitBtn');
  btn.classList.add('loading');
  btn.innerHTML='<i class="fas fa-spinner fa-spin"></i> Saving\u2026';
  /* update topbar name live */
  var fn=document.getElementById('fnIn').value.trim();
  var tn=document.getElementById('topbarName');
  if(tn&&fn)tn.textContent=fn;
});
</script>
</body>
</html>
