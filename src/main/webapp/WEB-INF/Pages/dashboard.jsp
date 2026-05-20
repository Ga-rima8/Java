<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard | HangAura</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* ═══════════════════════════════════════════════════════
   DESIGN TOKENS
═══════════════════════════════════════════════════════ */
:root {
  --g50:  #ecfdf5; --g100: #d1fae5; --g200: #a7f3d0;
  --g300: #6ee7b7; --g400: #34d399; --g500: #10b981;
  --g600: #059669; --g700: #047857; --g800: #065f46; --g900: #064e3b;

  --bg:      #0a0f0d;
  --bg2:     #0d1410;
  --bg3:     #111a15;
  --surface: #162018;
  --surf2:   #1a2820;
  --surf3:   #1f3028;

  --t1: #f0fdf4; --t2: #bbf7d0; --t3: #6ee7b7;
  --muted: #4b6858; --muted2: #365445;

  --em: #34d399;
  --glow:  rgba(52,211,153,.18);
  --glow2: rgba(52,211,153,.07);

  --sb: 260px;
  --topbar-h: 60px;
  --radius: 14px;
  --radius-sm: 10px;
  --border: rgba(52,211,153,.1);
  --shadow: 0 4px 24px rgba(0,0,0,.45);
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; font-size: 15px; }

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--bg);
  color: var(--t1);
  min-height: 100vh;
  display: flex;
  overflow-x: hidden;
}
a { text-decoration: none; color: inherit; }

body::after {
  content: '';
  position: fixed; inset: 0;
  background:
    radial-gradient(ellipse 70% 50% at 10% 10%, rgba(52,211,153,.04), transparent),
    radial-gradient(ellipse 50% 70% at 90% 90%, rgba(16,185,129,.03), transparent);
  pointer-events: none; z-index: 0;
}

/* ═══════════════════════════════════════════════════════
   SIDEBAR
═══════════════════════════════════════════════════════ */
.sidebar {
  width: var(--sb); min-height: 100vh;
  background: var(--bg2); border-right: 1px solid var(--border);
  display: flex; flex-direction: column;
  position: fixed; top: 0; left: 0; z-index: 300;
  transition: transform .3s cubic-bezier(.4,0,.2,1);
  overflow-y: auto; overflow-x: hidden;
}
.sb-logo {
  display: flex; align-items: center; gap: 10px;
  padding: 22px 20px 18px; border-bottom: 1px solid var(--border); flex-shrink: 0;
}
.sb-logo-icon {
  width: 34px; height: 34px;
  background: linear-gradient(135deg, var(--g600), var(--g400));
  border-radius: 9px; display: grid; place-items: center;
  font-size: 14px; color: #fff; box-shadow: 0 0 14px rgba(52,211,153,.3); flex-shrink: 0;
}
.sb-logo h2 { font-family: 'Sora',sans-serif; font-weight: 700; font-size: 17px; color: var(--t1); letter-spacing: -.3px; }
.sb-logo h2 span { color: var(--g400); }
.sb-nav { flex: 1; padding: 14px 12px 8px; display: flex; flex-direction: column; gap: 0; }
.sb-section-label {
  font-size: 10px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase;
  color: var(--muted2); padding: 14px 8px 6px;
  display: flex; align-items: center; gap: 8px;
}
.sb-section-label::after { content:''; flex:1; height:1px; background:var(--border); opacity:.6; }
.nav-link {
  display: flex; align-items: center; gap: 10px; padding: 9px 10px;
  border-radius: 9px; font-size: 13.5px; font-weight: 500; color: var(--muted);
  transition: all .18s; position: relative; white-space: nowrap; margin-bottom: 2px;
}
.nav-link:hover { color: var(--t2); background: var(--glow2); }
.nav-link.active { color: var(--g300); background: rgba(52,211,153,.1); font-weight: 600; }
.nav-link.active::after {
  content:''; position:absolute; right:0; top:22%; bottom:22%;
  width:3px; background:var(--g400); border-radius:3px 0 0 3px;
}
.nav-icon { width: 26px; height: 26px; display: grid; place-items: center; font-size: 12.5px; flex-shrink: 0; }
.sb-footer { padding: 10px 12px 18px; border-top: 1px solid var(--border); flex-shrink: 0; }
.sb-user {
  display: flex; align-items: center; gap: 10px; padding: 10px 8px;
  border-radius: 10px; background: var(--surf2); border: 1px solid var(--border); margin-bottom: 8px;
}
.sb-user-avatar {
  width: 32px; height: 32px; border-radius: 50%;
  background: linear-gradient(135deg, var(--g700), var(--g500));
  display: grid; place-items: center;
  font-family: 'Sora',sans-serif; font-size: 12px; font-weight: 700; color: #fff;
  overflow: hidden; flex-shrink: 0; border: 2px solid var(--g600);
}
.sb-user-avatar img { width:100%; height:100%; object-fit:cover; }
.sb-user-info { flex:1; overflow:hidden; }
.sb-user-name { font-size:12px; font-weight:600; color:var(--t1); display:block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.sb-user-role { font-size:10.5px; color:var(--muted); }
.logout-link { color: #f87171 !important; }
.logout-link:hover { background: rgba(248,113,113,.08) !important; color: #fca5a5 !important; }
.sb-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.6); z-index:250; backdrop-filter:blur(2px); }
.sb-overlay.show { display:block; }

/* ═══════════════════════════════════════════════════════
   MAIN
═══════════════════════════════════════════════════════ */
.main { flex:1; margin-left:var(--sb); min-height:100vh; display:flex; flex-direction:column; position:relative; z-index:1; }

/* ═══════════════════════════════════════════════════════
   TOPBAR
═══════════════════════════════════════════════════════ */
.topbar {
  height: var(--topbar-h); display:flex; align-items:center; justify-content:space-between;
  padding: 0 24px; background:rgba(13,20,16,.88); border-bottom:1px solid var(--border);
  backdrop-filter:blur(14px); position:sticky; top:0; z-index:200; flex-shrink:0;
}
.topbar-left { display:flex; align-items:center; gap:12px; }
.topbar-right { display:flex; align-items:center; gap:10px; }
.hamburger { display:none; background:none; border:none; color:var(--t2); font-size:17px; cursor:pointer; padding:6px; border-radius:7px; transition:background .15s; }
.hamburger:hover { background:var(--surf2); }
.breadcrumb { font-family:'Sora',sans-serif; font-size:14px; font-weight:600; color:var(--t3); letter-spacing:.4px; }
.notif-btn { width:34px; height:34px; border-radius:9px; background:var(--surf2); border:1px solid var(--border); display:grid; place-items:center; cursor:pointer; color:var(--t2); position:relative; font-size:13px; transition:all .2s; }
.notif-btn:hover { border-color:var(--g400); color:var(--g400); }
.notif-dot { width:6px; height:6px; background:var(--g400); border-radius:50%; position:absolute; top:8px; right:8px; box-shadow:0 0 5px var(--g400); }
.user-dropdown { position:relative; }
.user-trigger { display:flex; align-items:center; gap:7px; cursor:pointer; padding:5px 9px; border-radius:9px; transition:background .2s; }
.user-trigger:hover { background:var(--surf2); }
.avatar-sm { width:30px; height:30px; border-radius:50%; background:linear-gradient(135deg,var(--g700),var(--g500)); display:grid; place-items:center; font-family:'Sora',sans-serif; font-size:12px; font-weight:700; color:#fff; overflow:hidden; flex-shrink:0; border:2px solid var(--g600); }
.avatar-sm img { width:100%; height:100%; object-fit:cover; }
.avatar-md { width:42px; height:42px; border-radius:50%; background:linear-gradient(135deg,var(--g700),var(--g500)); display:grid; place-items:center; font-family:'Sora',sans-serif; font-size:15px; font-weight:700; color:#fff; overflow:hidden; flex-shrink:0; border:2px solid var(--g600); }
.avatar-md img { width:100%; height:100%; object-fit:cover; }
.user-name { font-size:13px; font-weight:600; color:var(--t1); }
.chev { font-size:10px; color:var(--muted); transition:transform .2s; }
.user-trigger:hover .chev { transform:rotate(180deg); }
.dropdown-menu { display:none; position:absolute; top:calc(100% + 8px); right:0; width:210px; background:var(--surf2); border:1px solid var(--border); border-radius:13px; overflow:hidden; box-shadow:0 20px 48px rgba(0,0,0,.5); z-index:999; animation:dropIn .18s ease; }
.dropdown-menu.show { display:block; }
@keyframes dropIn { from{opacity:0;transform:translateY(-5px)} to{opacity:1;transform:translateY(0)} }
.dropdown-header { display:flex; align-items:center; gap:10px; padding:14px 14px 12px; background:var(--bg3); }
.dropdown-header strong { font-size:12.5px; color:var(--t1); display:block; }
.dropdown-header small  { font-size:11px; color:var(--muted); }
.dd-divider { height:1px; background:var(--border); margin:3px 0; }
.dropdown-item { display:flex; align-items:center; gap:9px; padding:9px 14px; font-size:13px; color:var(--t2); transition:all .15s; }
.dropdown-item i { width:14px; color:var(--g400); font-size:11px; }
.dropdown-item:hover { background:var(--glow2); color:var(--g300); }
.dropdown-item.logout-item { color:#f87171; }
.dropdown-item.logout-item i { color:#f87171; }
.dropdown-item.logout-item:hover { background:rgba(248,113,113,.07); }

/* ═══════════════════════════════════════════════════════
   ALERTS
═══════════════════════════════════════════════════════ */
.alert { display:flex; align-items:center; gap:9px; padding:12px 18px; margin:18px 24px 0; border-radius:var(--radius-sm); font-size:13.5px; font-weight:500; animation:slideDown .3s ease; }
@keyframes slideDown { from{opacity:0;transform:translateY(-8px)} to{opacity:1;transform:translateY(0)} }
.alert-success { background:rgba(52,211,153,.1); color:var(--g300); border:1px solid rgba(52,211,153,.2); }
.alert-error   { background:rgba(248,113,113,.09); color:#fca5a5; border:1px solid rgba(248,113,113,.18); }
.alert-close { margin-left:auto; background:none; border:none; color:inherit; cursor:pointer; opacity:.6; font-size:11px; padding:2px 4px; }
.alert-close:hover { opacity:1; }

/* ═══════════════════════════════════════════════════════
   PAGE BODY
═══════════════════════════════════════════════════════ */
.page-body { padding:22px 24px 40px; flex:1; max-width:100%; overflow-x:hidden; }

/* ═══════════════════════════════════════════════════════
   WELCOME BANNER
═══════════════════════════════════════════════════════ */
.welcome-banner {
  background:linear-gradient(135deg,var(--bg3) 0%,var(--surf3) 100%);
  border:1px solid rgba(52,211,153,.12); border-radius:var(--radius);
  padding:24px 28px; margin-bottom:20px; position:relative; overflow:hidden;
  display:flex; align-items:center; justify-content:space-between;
}
.welcome-banner::before { content:''; position:absolute; top:-40px; right:-40px; width:180px; height:180px; background:radial-gradient(circle,rgba(52,211,153,.13),transparent 70%); pointer-events:none; }
.welcome-text h1 { font-family:'Sora',sans-serif; font-size:22px; font-weight:700; color:var(--t1); margin-bottom:5px; }
.welcome-text h1 span { color:var(--g400); }
.welcome-text p { color:var(--muted); font-size:13.5px; }
.welcome-art { position:relative; width:90px; height:65px; flex-shrink:0; }
.art-circle { position:absolute; border-radius:50%; border:1px solid rgba(52,211,153,.2); animation:pulse 4s ease-in-out infinite; }
.art-circle.c1 { width:56px;height:56px; top:4px; right:8px; animation-delay:0s; }
.art-circle.c2 { width:36px;height:36px; top:14px; right:28px; animation-delay:.8s; border-color:rgba(52,211,153,.35); }
.art-circle.c3 { width:18px;height:18px; top:23px; right:47px; animation-delay:1.6s; background:rgba(52,211,153,.15); border-color:var(--g400); }
@keyframes pulse { 0%,100%{transform:scale(1);opacity:.8} 50%{transform:scale(1.1);opacity:.4} }

/* ═══════════════════════════════════════════════════════
   STAT CARDS
═══════════════════════════════════════════════════════ */
.stats { display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-bottom:20px; }
.stat-card {
  background:var(--bg3); border:1px solid rgba(52,211,153,.07); border-radius:var(--radius);
  padding:18px 16px; display:flex; align-items:center; gap:13px;
  position:relative; overflow:hidden; transition:transform .22s,border-color .22s,box-shadow .22s;
  animation:fadeUp .5s ease both; animation-delay:var(--delay,0s); cursor:default;
}
@keyframes fadeUp { from{opacity:0;transform:translateY(16px)} to{opacity:1;transform:translateY(0)} }
.stat-card:hover { transform:translateY(-3px); border-color:rgba(52,211,153,.2); box-shadow:0 8px 28px rgba(52,211,153,.1); }
.stat-icon { width:42px; height:42px; border-radius:11px; display:grid; place-items:center; font-size:16px; flex-shrink:0; }
.stat-icon.green   { background:rgba(52,211,153,.11); color:var(--g400); }
.stat-icon.teal    { background:rgba(20,184,166,.11);  color:#2dd4bf; }
.stat-icon.lime    { background:rgba(163,230,53,.09);  color:#a3e635; }
.stat-icon.emerald { background:rgba(16,185,129,.11);  color:var(--g500); }
.stat-body h3 { font-family:'Sora',sans-serif; font-size:24px; font-weight:700; color:var(--t1); line-height:1; }
.stat-body p { font-size:11.5px; color:var(--muted); margin-top:4px; }
.stat-bg-icon { position:absolute; right:-6px; bottom:-6px; font-size:50px; opacity:.04; color:var(--g400); pointer-events:none; }

/* ═══════════════════════════════════════════════════════
   CONTENT GRID
═══════════════════════════════════════════════════════ */
.content-grid { display:grid; grid-template-columns:300px 1fr; gap:18px; align-items:start; }
.box { background:var(--bg3); border:1px solid rgba(52,211,153,.08); border-radius:var(--radius); overflow:hidden; animation:fadeUp .5s ease both; }
.box-header { display:flex; align-items:center; justify-content:space-between; padding:16px 18px 13px; border-bottom:1px solid rgba(52,211,153,.07); }
.box-header h2 { font-family:'Sora',sans-serif; font-size:13.5px; font-weight:600; color:var(--t1); display:flex; align-items:center; gap:6px; }
.box-badge { font-size:10.5px; font-weight:600; background:rgba(52,211,153,.1); color:var(--g400); padding:2px 8px; border-radius:20px; border:1px solid rgba(52,211,153,.17); }
.btn-ghost { display:flex; align-items:center; gap:5px; font-size:11.5px; font-weight:600; color:var(--g400); background:rgba(52,211,153,.07); padding:5px 11px; border-radius:7px; border:1px solid rgba(52,211,153,.15); transition:all .2s; cursor:pointer; }
.btn-ghost:hover { background:rgba(52,211,153,.16); border-color:var(--g400); }

/* ═══════════════════════════════════════════════════════
   PROFILE CARD
═══════════════════════════════════════════════════════ */
.profile-hero { padding:22px 18px 14px; display:flex; flex-direction:column; align-items:center; text-align:center; background:linear-gradient(to bottom,rgba(52,211,153,.04),transparent); }
.profile-avatar-wrap { position:relative; margin-bottom:13px; }
.profile-avatar { width:84px; height:84px; border-radius:50%; background:linear-gradient(135deg,var(--g700),var(--g500)); display:grid; place-items:center; overflow:hidden; font-family:'Sora',sans-serif; font-size:30px; font-weight:700; color:#fff; position:relative; z-index:2; border:3px solid var(--g700); }
.profile-avatar img { width:100%; height:100%; object-fit:cover; }
.avatar-ring { position:absolute; inset:-5px; border-radius:50%; border:2px solid transparent; background:linear-gradient(135deg,var(--g400),var(--g700)) border-box; -webkit-mask:linear-gradient(#fff 0 0) padding-box,linear-gradient(#fff 0 0); -webkit-mask-composite:destination-out; mask-composite:exclude; animation:spin 6s linear infinite; }
@keyframes spin { to{transform:rotate(360deg)} }

.avatar-upload-btn {
  position: absolute; bottom: -2px; right: -2px; z-index: 10;
  width: 26px; height: 26px; border-radius: 50%;
  background: linear-gradient(135deg, var(--g600), var(--g400));
  border: 2px solid var(--bg3);
  display: grid; place-items: center;
  cursor: pointer; font-size: 10px; color: #fff;
  transition: transform .2s, box-shadow .2s;
  box-shadow: 0 2px 8px rgba(52,211,153,.4);
}
.avatar-upload-btn:hover { transform: scale(1.15); box-shadow: 0 4px 14px rgba(52,211,153,.5); }
.avatar-upload-input { display: none; }

.upload-panel {
  display: none; margin: 0 18px 14px;
  background: var(--surf2); border: 1px solid rgba(52,211,153,.15);
  border-radius: 10px; padding: 12px 14px; animation: slideDown .25s ease;
}
.upload-panel.show { display: block; }
.upload-panel-top { display: flex; align-items: center; gap: 9px; margin-bottom: 10px; }
.upload-filename { font-size: 12px; color: var(--t2); flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.upload-actions { display: flex; gap: 6px; }
.btn-upload-confirm {
  display: inline-flex; align-items: center; gap: 5px;
  font-size: 12px; font-weight: 600; padding: 6px 13px;
  border-radius: 7px; background: linear-gradient(135deg, var(--g600), var(--g500));
  color: #fff; border: none; cursor: pointer; transition: all .2s;
}
.btn-upload-confirm:hover { box-shadow: 0 4px 12px rgba(52,211,153,.3); }
.btn-upload-cancel {
  display: inline-flex; align-items: center; gap: 5px;
  font-size: 12px; font-weight: 600; padding: 6px 11px;
  border-radius: 7px; background: transparent;
  color: var(--muted); border: 1px solid var(--border); cursor: pointer; transition: all .2s;
}
.btn-upload-cancel:hover { color: var(--t2); border-color: rgba(52,211,153,.25); }
.upload-hint { font-size: 10.5px; color: var(--muted); }

.remove-photo-wrap { padding: 0 18px 10px; text-align: center; }
.remove-photo-btn {
  font-size: 11px; color: #f87171; cursor: pointer; background: none; border: none;
  display: inline-flex; align-items: center; gap: 4px; opacity: .7; transition: opacity .2s;
}
.remove-photo-btn:hover { opacity: 1; }

.profile-identity h3 { font-family:'Sora',sans-serif; font-size:15px; font-weight:700; color:var(--t1); }
.username-tag { font-size:11.5px; color:var(--g400); background:rgba(52,211,153,.08); padding:2px 9px; border-radius:20px; display:inline-block; margin-top:4px; border:1px solid rgba(52,211,153,.15); }
.profile-details { padding:0 18px 14px; }
.detail-row { display:flex; align-items:center; justify-content:space-between; padding:8px 0; border-bottom:1px solid rgba(52,211,153,.05); }
.detail-row:last-child { border-bottom:none; }
.detail-label { display:flex; align-items:center; gap:5px; font-size:11.5px; color:var(--muted); }
.detail-label i { color:var(--g600); font-size:10.5px; width:13px; }
.detail-value { font-size:12px; font-weight:500; color:var(--t2); text-align:right; max-width:150px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }

/* ── Profile completion bar ── */
.completion-wrap { padding:0 18px 18px; }
.completion-label { display:flex; justify-content:space-between; font-size:11.5px; color:var(--muted); margin-bottom:7px; }
.completion-pct { font-weight:600; color:var(--g400); }
.completion-track { height:5px; background:var(--surf3); border-radius:99px; overflow:hidden; }
.completion-fill { height:100%; background:linear-gradient(90deg,var(--g600),var(--g400)); border-radius:99px; transition:width 1s cubic-bezier(.4,0,.2,1); box-shadow:0 0 7px rgba(52,211,153,.4); }

/* ═══════════════════════════════════════════════════════
   EVENTS GRID
═══════════════════════════════════════════════════════ */
.events-grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; padding:14px; }
.event-card { background:var(--surf2); border:1px solid rgba(52,211,153,.08); border-radius:var(--radius-sm); padding:13px; transition:all .2s; position:relative; overflow:hidden; }
.event-card::after { content:''; position:absolute; top:0; left:0; right:0; height:2px; background:linear-gradient(90deg,var(--g600),var(--g400)); opacity:0; transition:opacity .2s; }
.event-card:hover { border-color:rgba(52,211,153,.2); transform:translateY(-2px); box-shadow:0 6px 20px rgba(0,0,0,.28); }
.event-card:hover::after { opacity:1; }
.event-cat-badge { display:inline-block; font-size:10px; font-weight:600; text-transform:uppercase; letter-spacing:.6px; color:var(--g400); background:rgba(52,211,153,.07); border:1px solid rgba(52,211,153,.14); padding:2px 6px; border-radius:5px; margin-bottom:6px; }
.event-card h4 { font-family:'Sora',sans-serif; font-size:12.5px; font-weight:600; color:var(--t1); margin-bottom:7px; line-height:1.35; }
.event-meta { display:flex; flex-direction:column; gap:3px; margin-bottom:9px; }
.event-meta span { display:flex; align-items:center; gap:4px; font-size:10.5px; color:var(--muted); }
.event-meta i { color:var(--g600); font-size:9.5px; width:11px; }
.capacity-badge { display:inline-block; font-size:11.5px; font-weight:600; color:var(--t2); background:var(--bg3); padding:2px 7px; border-radius:5px; border:1px solid rgba(52,211,153,.1); }

.cat-grid { display:flex; flex-direction:column; gap:1px; padding:8px 0; }
.cat-chip { display:flex; align-items:center; gap:11px; padding:9px 18px; transition:background .15s; cursor:pointer; }
.cat-chip:hover { background:var(--glow2); }
.cat-icon { width:32px; height:32px; border-radius:9px; background:rgba(52,211,153,.09); display:grid; place-items:center; font-size:12px; color:var(--g400); flex-shrink:0; border:1px solid rgba(52,211,153,.14); }
.cat-info strong { display:block; font-size:12.5px; font-weight:600; color:var(--t1); }
.cat-info small  { font-size:10.5px; color:var(--muted); }

.reg-table-wrap { padding:0 0 4px; overflow-x:auto; }
.reg-table { width:100%; border-collapse:collapse; font-size:12.5px; }
.reg-table thead tr { border-bottom:1px solid rgba(52,211,153,.1); }
.reg-table th { padding:9px 16px; text-align:left; font-size:10.5px; font-weight:600; text-transform:uppercase; letter-spacing:.6px; color:var(--muted); }
.reg-table tbody tr { border-bottom:1px solid rgba(52,211,153,.04); transition:background .15s; }
.reg-table tbody tr:last-child { border-bottom:none; }
.reg-table tbody tr:hover { background:var(--glow2); }
.reg-table td { padding:10px 16px; color:var(--t2); vertical-align:middle; }
.reg-table td:first-child { font-weight:500; color:var(--t1); }
.empty-state { display:flex; flex-direction:column; align-items:center; gap:9px; padding:32px 18px; color:var(--muted); font-size:12.5px; }
.empty-state i { font-size:26px; color:var(--muted2); }
.right-col { display:flex; flex-direction:column; gap:18px; }

/* ═══════════════════════════════════════════════════════
   RESPONSIVE
═══════════════════════════════════════════════════════ */
@media (max-width:1200px) { .stats{grid-template-columns:repeat(2,1fr)} .content-grid{grid-template-columns:270px 1fr} }
@media (max-width:1024px) { .content-grid{grid-template-columns:1fr} }
@media (max-width:900px)  { .events-grid{grid-template-columns:1fr} }
@media (max-width:768px)  { .sidebar{transform:translateX(-100%)} .sidebar.open{transform:translateX(0)} .main{margin-left:0} .hamburger{display:flex;align-items:center;justify-content:center} .page-body{padding:14px 14px 36px} .welcome-banner{padding:18px 20px} .topbar{padding:0 14px} .stats{grid-template-columns:1fr 1fr} .welcome-text h1{font-size:18px} .welcome-art{display:none} }
@media (max-width:480px)  { .stats{grid-template-columns:1fr} .alert{margin:12px 14px 0} .box-header{padding:13px 14px 11px} .events-grid{padding:10px;gap:10px} }
</style>
</head>
<body>

<c:set var="hasImage" value="${not empty user.profileImage}"/>

<!-- ═══════════════════ SIDEBAR ═══════════════════ -->
<div class="sidebar" id="sidebar">
  <div class="sb-logo">
    <span class="sb-logo-icon"><i class="fas fa-leaf"></i></span>
    <h2>Hang<span>Aura</span></h2>
  </div>
  <nav class="sb-nav">
    <div class="sb-section-label">Main</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">
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
    <a href="${pageContext.request.contextPath}/profile" class="nav-link">
      <span class="nav-icon"><i class="fas fa-user-edit"></i></span><span>Edit Profile</span>
    </a>
  </nav>
  <div class="sb-footer">
    <div class="sb-user">
      <div class="sb-user-avatar">
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
<div class="sb-overlay" id="sbOverlay" onclick="closeSidebar()"></div>

<!-- ═══════════════════ MAIN ═══════════════════ -->
<div class="main" id="mainContent">

  <!-- TOPBAR -->
  <div class="topbar">
    <div class="topbar-left">
      <button class="hamburger" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
      <div class="breadcrumb">Dashboard</div>
    </div>
    <div class="topbar-right">
      <div class="notif-btn"><i class="fas fa-bell"></i><span class="notif-dot"></span></div>
      <div class="user-dropdown" id="userDropdown">
        <div class="user-trigger" onclick="toggleDropdown()">
          <div class="avatar-sm">
            <c:choose>
              <c:when test="${hasImage}">
                <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
              </c:when>
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
  <c:remove var="error"   scope="session"/>

  <!-- PAGE BODY -->
  <div class="page-body">

    <!-- WELCOME BANNER -->
    <div class="welcome-banner">
      <div class="welcome-text">
        <h1>Welcome back, <span><c:out value="${not empty user.firstName ? user.firstName : 'User'}"/></span> 👋</h1>
        <p>Here's what's happening in your HangAura world today.</p>
      </div>
      <div class="welcome-art">
        <div class="art-circle c1"></div>
        <div class="art-circle c2"></div>
        <div class="art-circle c3"></div>
      </div>
    </div>

    <!-- STAT CARDS -->
    <div class="stats">
      <div class="stat-card" style="--delay:.05s">
        <div class="stat-icon green"><i class="fas fa-calendar-alt"></i></div>
        <div class="stat-body">
          <h3><c:out value="${not empty totalEvents ? totalEvents : 0}"/></h3>
          <p>Total Events</p>
        </div>
        <div class="stat-bg-icon"><i class="fas fa-calendar-alt"></i></div>
      </div>
      <div class="stat-card" style="--delay:.1s">
        <div class="stat-icon teal"><i class="fas fa-check-circle"></i></div>
        <div class="stat-body">
          <h3><c:out value="${not empty registeredCount ? registeredCount : 0}"/></h3>
          <p>My Registrations</p>
        </div>
        <div class="stat-bg-icon"><i class="fas fa-check-circle"></i></div>
      </div>
      <div class="stat-card" style="--delay:.15s">
        <div class="stat-icon lime"><i class="fas fa-clock"></i></div>
        <div class="stat-body">
          <h3><c:out value="${not empty upcomingCount ? upcomingCount : 0}"/></h3>
          <p>Upcoming Events</p>
        </div>
        <div class="stat-bg-icon"><i class="fas fa-clock"></i></div>
      </div>
      <div class="stat-card" style="--delay:.2s">
        <div class="stat-icon emerald"><i class="fas fa-tags"></i></div>
        <div class="stat-body">
          <h3><c:out value="${not empty totalCategories ? totalCategories : 0}"/></h3>
          <p>Categories</p>
        </div>
        <div class="stat-bg-icon"><i class="fas fa-tags"></i></div>
      </div>
    </div>

    <!-- CONTENT GRID -->
    <div class="content-grid">

      <!-- LEFT: PROFILE CARD -->
      <div class="box profile-card">
        <div class="box-header">
          <h2><i class="fas fa-user" style="color:var(--g400)"></i> My Profile</h2>
          <a href="${pageContext.request.contextPath}/profile" class="btn-ghost"><i class="fas fa-edit"></i> Edit</a>
        </div>

        <div class="profile-hero">
          <div class="profile-avatar-wrap">
            <div class="profile-avatar" id="profileAvatarEl">
              <c:choose>
                <c:when test="${hasImage}">
                  <img src="${pageContext.request.contextPath}/profileImage" alt="profile" id="profileAvatarImg">
                </c:when>
                <c:otherwise>
                  <span id="profileAvatarInitial"><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></span>
                </c:otherwise>
              </c:choose>
            </div>
            <div class="avatar-ring"></div>
            <label class="avatar-upload-btn" for="avatarFileInput" title="Change profile photo">
              <i class="fas fa-camera"></i>
            </label>
            <input type="file" id="avatarFileInput" class="avatar-upload-input"
                   accept="image/jpg,image/png,image/gif,image/webp"
                   onchange="onAvatarSelected(this)">
          </div>
          <div class="profile-identity">
            <h3><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></h3>
            <span class="username-tag">@<c:out value="${user.userName}"/></span>
          </div>
        </div>

        <div class="upload-panel" id="uploadPanel">
          <div class="upload-panel-top">
            <i class="fas fa-image" style="color:var(--g400);font-size:13px;flex-shrink:0;"></i>
            <span class="upload-filename" id="uploadFilename">photo.jpg</span>
          </div>
          <div class="upload-actions">
            <button class="btn-upload-confirm" onclick="submitUpload()">
              <i class="fas fa-upload"></i> Upload
            </button>
            <button class="btn-upload-cancel" onclick="cancelUpload()">
              <i class="fas fa-times"></i> Cancel
            </button>
          </div>
          <div class="upload-hint" style="margin-top:8px;">
            <i class="fas fa-info-circle" style="margin-right:3px;"></i>
            JPG, PNG, GIF or WebP &middot; Max 5 MB
          </div>
        </div>

        <c:if test="${hasImage}">
          <div class="remove-photo-wrap">
            <%-- FIX: must be POST — servlet only exposes doPost for this action --%>
            <form action="${pageContext.request.contextPath}/removeProfileImage"
                  method="post" style="display:inline;"
                  onsubmit="return confirm('Remove your profile photo?')">
              <button type="submit" class="remove-photo-btn">
                <i class="fas fa-trash-alt"></i> Remove photo
              </button>
            </form>
          </div>
        </c:if>

        <form id="avatarUploadForm"
              action="${pageContext.request.contextPath}/uploadProfileImage"
              method="post"
              enctype="multipart/form-data"
              style="display:none;">
          <input type="file" name="profileImage" id="avatarFormInput">
        </form>

        <div class="profile-details">
          <div class="detail-row">
            <span class="detail-label"><i class="fas fa-envelope"></i> Email</span>
            <span class="detail-value"><c:out value="${user.email}"/></span>
          </div>
          <div class="detail-row">
            <span class="detail-label"><i class="fas fa-phone"></i> Phone</span>
            <span class="detail-value"><c:out value="${not empty user.number ? user.number : 'Not set'}"/></span>
          </div>
          <div class="detail-row">
            <span class="detail-label"><i class="fas fa-birthday-cake"></i> DOB</span>
            <span class="detail-value">
              <c:choose>
                <c:when test="${not empty user.dob}"><fmt:formatDate value="${user.dob}" pattern="dd MMM yyyy"/></c:when>
                <c:otherwise>Not set</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="detail-row">
            <span class="detail-label"><i class="fas fa-venus-mars"></i> Gender</span>
            <span class="detail-value"><c:out value="${not empty user.gender ? user.gender : 'Not set'}"/></span>
          </div>
        </div>

        <%--
          FIX: profile completion is computed by UserService.computeProfileCompletion()
          and passed as the integer attribute "profileCompletion".
          The JSP only renders the value — no calculation happens here.
        --%>
        <div class="completion-wrap">
          <div class="completion-label">
            <span>Profile Completion</span>
            <span class="completion-pct"><c:out value="${profileCompletion}"/>%</span>
          </div>
          <div class="completion-track">
            <div class="completion-fill" id="pctFill" style="width:0%"
                 data-pct="<c:out value='${profileCompletion}'/>"></div>
          </div>
        </div>
      </div>

      <!-- RIGHT COLUMN -->
      <div class="right-col">

        <!-- LATEST EVENTS -->
        <div class="box">
          <div class="box-header">
            <h2><i class="fas fa-calendar-alt" style="color:var(--g400)"></i> Latest Events</h2>
            <span class="box-badge"><c:out value="${not empty totalEvents ? totalEvents : 0}"/> total</span>
          </div>
          <c:choose>
            <c:when test="${not empty recentEvents}">
              <div class="events-grid">
                <c:forEach var="ev" items="${recentEvents}">
                  <div class="event-card">
                    <c:if test="${not empty ev.category}">
                      <span class="event-cat-badge"><c:out value="${ev.category}"/></span>
                    </c:if>
                    <h4><c:out value="${ev.eventName}"/></h4>
                    <div class="event-meta">
                      <span><i class="fas fa-calendar"></i>
                        <fmt:formatDate value="${ev.eventDate}" pattern="dd MMM yyyy"/>
                      </span>
                      <span><i class="fas fa-map-marker-alt"></i>
                        <c:out value="${ev.eventLocation}"/>
                      </span>
                      <span><i class="fas fa-user-tie"></i> HangAura</span>
                    </div>
                    <span class="capacity-badge">
                      <i class="fas fa-users" style="font-size:9px;margin-right:3px;"></i>
                      Max <c:out value="${ev.maxCapacity}"/>
                    </span>
                  </div>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                No events found. Check back soon!
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- MY REGISTRATIONS -->
        <div class="box">
          <div class="box-header">
            <h2><i class="fas fa-ticket-alt" style="color:var(--g400)"></i> My Registrations</h2>
            <a href="${pageContext.request.contextPath}/myregistrations" class="box-badge" style="cursor:pointer;text-decoration:none;">
              <c:out value="${not empty registeredCount ? registeredCount : 0}"/> events →
            </a>
          </div>
          <c:choose>
            <c:when test="${not empty registeredEvents}">
              <div class="reg-table-wrap">
                <table class="reg-table">
                  <thead>
                    <tr>
                      <th>Event</th>
                      <th>Date</th>
                      <th>Location</th>
                      <th>Capacity</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="ev" items="${registeredEvents}">
                      <tr>
                        <td><c:out value="${ev.eventName}"/></td>
                        <td><fmt:formatDate value="${ev.eventDate}" pattern="dd MMM yyyy"/></td>
                        <td><c:out value="${ev.eventLocation}"/></td>
                        <td><c:out value="${ev.capacity}"/></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state">
                <i class="fas fa-ticket-alt"></i>
                You haven't registered for any events yet.
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- CATEGORIES -->
        <div class="box">
          <div class="box-header">
            <h2><i class="fas fa-tags" style="color:var(--g400)"></i> Categories</h2>
            <span class="box-badge"><c:out value="${not empty totalCategories ? totalCategories : 0}"/> active</span>
          </div>
          <c:choose>
            <c:when test="${not empty categories}">
              <div class="cat-grid">
                <c:forEach var="cat" items="${categories}">
                  <div class="cat-chip">
                    <div class="cat-icon"><i class="fas fa-layer-group"></i></div>
                    <div class="cat-info">
                      <strong><c:out value="${cat.categoryName}"/></strong>
                      <small><c:out value="${cat.eventCount}"/> events</small>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="empty-state"><i class="fas fa-folder-open"></i> No categories yet.</div>
            </c:otherwise>
          </c:choose>
        </div>

      </div>
    </div>
  </div>
</div>

<script>
/* ── UI only — no data computation ── */
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('sbOverlay').classList.toggle('show');}
function closeSidebar(){document.getElementById('sidebar').classList.remove('open');document.getElementById('sbOverlay').classList.remove('show');}
function toggleDropdown(){document.getElementById('dropdownMenu').classList.toggle('show');}
document.addEventListener('click',function(e){var dd=document.getElementById('userDropdown');if(dd&&!dd.contains(e.target))document.getElementById('dropdownMenu').classList.remove('show');});

/* ── Profile photo preview (UI only — upload goes to servlet) ── */
var _selectedFile = null;
function onAvatarSelected(input){
  if(!input.files||!input.files[0])return;
  var file=input.files[0];
  if(file.size>5*1024*1024){alert('Image must be under 5 MB.');input.value='';return;}
  _selectedFile=file;
  var reader=new FileReader();
  reader.onload=function(e){
    var avatarEl=document.getElementById('profileAvatarEl');
    var existing=avatarEl.querySelector('img');
    var initial=avatarEl.querySelector('span');
    if(existing){existing.src=e.target.result;}
    else{var img=document.createElement('img');img.src=e.target.result;img.id='profileAvatarImg';if(initial)initial.remove();avatarEl.appendChild(img);}
  };
  reader.readAsDataURL(file);
  document.getElementById('uploadFilename').textContent=file.name;
  document.getElementById('uploadPanel').classList.add('show');
}
function submitUpload(){
  if(!_selectedFile)return;
  var dt=new DataTransfer();
  dt.items.add(_selectedFile);
  document.getElementById('avatarFormInput').files=dt.files;
  document.getElementById('avatarUploadForm').submit();
}
function cancelUpload(){
  _selectedFile=null;
  document.getElementById('avatarFileInput').value='';
  document.getElementById('uploadPanel').classList.remove('show');
  location.reload();
}

/*
 * FIX: Profile completion bar is animated from the server-supplied data-pct
 * attribute — no calculation happens here. The servlet computed the integer;
 * this JavaScript only triggers the CSS transition.
 */
(function(){
  var fill = document.getElementById('pctFill');
  if (!fill) return;
  var pct  = parseInt(fill.getAttribute('data-pct'), 10) || 0;
  setTimeout(function(){ fill.style.width = pct + '%'; }, 400);
})();

/* Auto-dismiss alert */
setTimeout(function(){
  var al=document.getElementById('alertMsg');
  if(al){al.style.transition='opacity .5s';al.style.opacity='0';setTimeout(function(){if(al&&al.parentNode)al.remove();},500);}
},4500);
</script>
</body>
</html>
