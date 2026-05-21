<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HangAura – Login</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,wght@0,400;0,700;0,900;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

<style>
/* ── RESET & BASE ── */
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

:root {
  --green-bright: #a3e635;
  --green-dark:   #0d2818;
  --green-deep:   #01150e;
  --surface-1:    rgba(255,255,255,0.03);
  --surface-2:    rgba(255,255,255,0.06);
  --border:       rgba(163,230,53,0.14);
  --text-primary: #eefbf3;
  --text-muted:   #7a9b86;
  --radius-card:  26px;
  --radius-input: 13px;
}

html, body { height: 100%; }

body {
  font-family: 'DM Sans', sans-serif;
  background: var(--green-deep);
  color: var(--text-primary);
  min-height: 100vh;
  overflow-x: hidden;
}

body::before {
  content: '';
  position: fixed;
  inset: 0;
  background:
    radial-gradient(ellipse 65% 55% at 10% 5%, rgba(10,80,40,0.5) 0%, transparent 60%),
    radial-gradient(ellipse 45% 45% at 90% 90%, rgba(163,230,53,0.07) 0%, transparent 55%);
  z-index: 0;
  pointer-events: none;
}

/* ── NAVBAR ── */
nav {
  position: fixed;
  top: 0; left: 0;
  width: 100%;
  height: 72px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 5%;
  background: rgba(1,21,14,0.85);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
  z-index: 200;
}

.logo {
  font-family: 'Fraunces', serif;
  font-size: 1.8rem;
  font-weight: 900;
  letter-spacing: -0.5px;
  color: var(--text-primary);
}
.logo span { color: var(--green-bright); }

.nav-pill {
  padding: 8px 20px;
  border-radius: 50px;
  border: 1px solid var(--border);
  color: var(--text-muted);
  font-size: 0.85rem;
  text-decoration: none;
  transition: all 0.2s;
}
.nav-pill:hover {
  border-color: var(--green-bright);
  color: var(--green-bright);
}

/* ── ALERTS ── */
.message-container {
  position: fixed;
  top: 82px;
  left: 0; right: 0;
  display: flex;
  justify-content: center;
  z-index: 300;
  pointer-events: none;
  padding: 0 20px;
}
.banner {
  pointer-events: all;
  padding: 13px 24px;
  border-radius: 12px;
  font-weight: 600;
  font-size: 0.9rem;
  animation: slideDown 0.35s cubic-bezier(0.34,1.56,0.64,1);
  display: flex;
  align-items: center;
  gap: 8px;
}
.error-banner   { background: rgba(198,40,40,0.92);  border: 1px solid rgba(255,100,100,0.3); }
.success-banner { background: rgba(30,120,60,0.92);  border: 1px solid rgba(163,230,53,0.3); color: var(--green-bright); }

@keyframes slideDown {
  from { opacity: 0; transform: translateY(-16px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ── SPLIT LAYOUT ── */
.split-container {
  position: relative;
  z-index: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 56px;
  padding: 100px 5% 60px;
  min-height: 100vh;
  animation: pageIn 0.6s cubic-bezier(0.22,1,0.36,1) both;
}
@keyframes pageIn {
  from { opacity: 0; transform: translateY(18px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ── LEFT IMAGE ── */
.left-side {
  flex: 1.1;
  display: flex;
  justify-content: center;
  align-self: stretch;
}

.image-card {
  width: 100%;
  max-width: 520px;
  min-height: 580px;
  border-radius: var(--radius-card);
  overflow: hidden;
  position: relative;
  border: 1px solid var(--border);
  box-shadow: 0 24px 80px rgba(0,0,0,0.6), 0 0 50px rgba(163,230,53,0.05);
}

.side-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  filter: brightness(0.82) saturate(0.8);
  transition: transform 0.7s ease, filter 0.5s ease;
}
.image-card:hover .side-image {
  transform: scale(1.03);
  filter: brightness(0.72) saturate(0.85);
}

.image-overlay {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 32px;
  background: linear-gradient(
    to bottom,
    rgba(1,21,14,0.1) 0%,
    transparent 35%,
    rgba(1,21,14,0.96) 100%
  );
}

.explore-badge {
  align-self: flex-start;
  padding: 8px 18px;
  border-radius: 50px;
  background: rgba(163,230,53,0.15);
  border: 1px solid rgba(163,230,53,0.3);
  color: var(--green-bright);
  font-size: 0.8rem;
  font-weight: 600;
  letter-spacing: 0.04em;
  backdrop-filter: blur(8px);
}

.overlay-bottom h2 {
  font-family: 'Fraunces', serif;
  font-size: 2.4rem;
  font-weight: 900;
  line-height: 1.1;
  margin-bottom: 10px;
}
.overlay-bottom p {
  color: rgba(238,251,243,0.65);
  line-height: 1.7;
  font-size: 0.9rem;
}

/* ── RIGHT SIDE ── */
.right-side {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 20px;
}

/* ── ABOUT CARD ── */
.about-card {
  width: 100%;
  max-width: 420px;
  background: var(--surface-1);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 18px 22px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.about-icon {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: rgba(163,230,53,0.12);
  border: 1px solid rgba(163,230,53,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  color: var(--green-bright);
  font-size: 1.1rem;
}

.about-text h3 {
  font-size: 0.95rem;
  font-weight: 700;
  margin-bottom: 3px;
}
.about-text p {
  font-size: 0.8rem;
  color: var(--text-muted);
  line-height: 1.5;
}

/* ── FORM CONTAINER ── */
.form-container {
  width: 100%;
  max-width: 420px;
  background: var(--surface-1);
  border: 1px solid var(--border);
  border-radius: var(--radius-card);
  padding: 36px 32px 32px;
  box-shadow: 0 20px 60px rgba(0,0,0,0.35);
}

.form-header {
  margin-bottom: 26px;
}
.form-header h1 {
  font-family: 'Fraunces', serif;
  font-size: 2.4rem;
  font-weight: 900;
  color: var(--text-primary);
  line-height: 1.05;
  letter-spacing: -0.5px;
  margin-bottom: 6px;
}
.form-header p {
  color: var(--text-muted);
  font-size: 0.9rem;
}

/* ── INPUTS ── */
.input-group {
  margin-bottom: 14px;
}

.input-group input {
  width: 100%;
  height: 54px;
  background: var(--surface-2);
  border: 1px solid var(--border);
  border-radius: var(--radius-input);
  color: var(--text-primary);
  padding: 0 18px;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.93rem;
  outline: none;
  transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
}

.input-group input::placeholder { color: var(--text-muted); }

.input-group input:focus {
  border-color: var(--green-bright);
  background: rgba(163,230,53,0.04);
  box-shadow: 0 0 0 4px rgba(163,230,53,0.09);
}
.input-group input:hover:not(:focus) {
  border-color: rgba(163,230,53,0.28);
}

/* ── FORM ACTIONS ── */
.form-actions {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-top: 6px;
}

/* ── BUTTON ── */
.primary-btn {
  flex: 1;
  height: 54px;
  border: none;
  border-radius: var(--radius-input);
  background: var(--green-bright);
  color: #010e07;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.95rem;
  font-weight: 700;
  letter-spacing: 0.02em;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s;
  position: relative;
  overflow: hidden;
}
.primary-btn::after {
  content: '';
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, rgba(255,255,255,0.14) 0%, transparent 60%);
  pointer-events: none;
}
.primary-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 36px rgba(163,230,53,0.32);
  background: #b5f24a;
}
.primary-btn:active { transform: none; box-shadow: none; }

.forgot-link {
  font-size: 0.83rem;
  color: var(--text-muted);
  text-decoration: none;
  white-space: nowrap;
  transition: color 0.2s;
}
.forgot-link:hover { color: var(--green-bright); }

/* ── DIVIDER ── */
.divider {
  display: flex;
  align-items: center;
  gap: 12px;
  margin: 20px 0 16px;
}
.divider::before, .divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: var(--border);
}
.divider span {
  font-size: 0.8rem;
  color: var(--text-muted);
  white-space: nowrap;
}

/* ── SWITCH TEXT ── */
.switch-text {
  text-align: center;
  color: var(--text-muted);
  font-size: 0.88rem;
}
.highlight-link {
  color: var(--green-bright);
  font-weight: 700;
  text-decoration: none;
  transition: opacity 0.2s;
}
.highlight-link:hover { opacity: 0.8; }

/* ── RESPONSIVE ── */
@media (max-width: 1000px) {
  .split-container { flex-direction: column; gap: 28px; padding-top: 100px; }
  .image-card { min-height: 320px; max-width: 100%; }
  .left-side, .right-side { flex: unset; width: 100%; max-width: 560px; }
}
@media (max-width: 500px) {
  .form-container { padding: 28px 20px 24px; }
  .form-header h1 { font-size: 2rem; }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav>
  <div class="logo">Hang<span>Aura</span></div>
  <a href="#" class="nav-pill">Connect with us</a>
</nav>

<!-- ALERTS -->
<div class="message-container">
  <c:if test="${not empty error}">
    <div class="banner error-banner">⚠ ${error}</div>
  </c:if>
  <%-- Show success message after registration redirect --%>
  <c:if test="${param.registered == 'true'}">
    <div class="banner success-banner">✓ Account created! You can now log in.</div>
  </c:if>
  <c:if test="${not empty success}">
    <div class="banner success-banner">✓ ${success}</div>
  </c:if>
</div>

<!-- MAIN -->
<main class="split-container">

  <!-- LEFT -->
  <div class="left-side">
    <div class="image-card">
      <img src="${pageContext.request.contextPath}/img/pic1.jpg" alt="HangAura Nature" class="side-image">
      <div class="image-overlay">
        <span class="explore-badge">✦ Explore Nature</span>
        <div class="overlay-bottom">
          <h2>Reconnect With The Wild</h2>
          <p>Discover peaceful forests, mountain escapes, and unforgettable outdoor experiences.</p>
        </div>
      </div>
    </div>
  </div>

  <!-- RIGHT -->
  <div class="right-side">

    <div class="about-card">
      <div class="about-icon">
        <i class="fa fa-leaf"></i>
      </div>
      <div class="about-text">
        <h3>About HangAura</h3>
        <p>Discover pristine forests, majestic animals, and the magic of nature right at your fingertips.</p>
      </div>
    </div>

    <div class="form-container">

      <div class="form-header">
        <h1>Welcome Back</h1>
        <p>Login to continue your adventure</p>
      </div>

      <%--
        field name="username"  → LoginServlet reads req.getParameter("username")
        Admin also uses this field — they type their email address in the username box.
        The servlet checks admin table first (email match), then user table (username match).
      --%>
      <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="input-group">
          <input type="text" name="username" placeholder="Username  (admin: use your email)" required
                 value="${not empty param.username ? param.username : ''}">
        </div>

        <div class="input-group">
          <input type="password" name="password" placeholder="Password" required>
        </div>

        <div class="form-actions">
          <button type="submit" class="primary-btn">Login</button>
          <a href="#" class="forgot-link">Forgot Password?</a>
        </div>

      </form>

      <div class="divider"><span>New to HangAura?</span></div>

      <p class="switch-text">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register" class="highlight-link">Create one free →</a>
      </p>

    </div>
  </div>

</main>

</body>
</html>
