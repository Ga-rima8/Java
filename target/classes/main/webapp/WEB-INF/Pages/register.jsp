<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>HangAura – Create Account</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,wght@0,400;0,700;0,900;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/register.css">
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

.nav-link {
  font-size: 0.88rem;
  color: var(--text-muted);
  text-decoration: none;
  transition: color 0.2s;
}
.nav-link strong { color: var(--green-bright); }
.nav-link:hover { color: var(--text-primary); }

/* ── ALERT ── */
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
.error-banner { background: rgba(198,40,40,0.92); border: 1px solid rgba(255,100,100,0.3); }
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
  max-width: 580px;
  min-height: 680px;
  border-radius: var(--radius-card);
  overflow: hidden;
  position: relative;
  border: 1px solid var(--border);
  box-shadow: 0 24px 80px rgba(0,0,0,0.6), 0 0 50px rgba(163,230,53,0.05);
  flex-shrink: 0;
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

.overlay-badge {
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

.overlay-bottom { max-width: 420px; }
.overlay-bottom h2 {
  font-family: 'Fraunces', serif;
  font-size: 2.6rem;
  font-weight: 900;
  line-height: 1.1;
  margin-bottom: 12px;
}
.overlay-bottom p {
  color: rgba(238,251,243,0.65);
  line-height: 1.7;
  font-size: 0.9rem;
}

/* Perks list inside image */
.perks {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 18px;
}
.perk-item {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 0.85rem;
  color: rgba(238,251,243,0.75);
}
.perk-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--green-bright);
  flex-shrink: 0;
}

/* ── RIGHT SIDE ── */
.right-side {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

/* ── FORM CONTAINER ── */
.form-container {
  width: 100%;
  max-width: 500px;
}

.form-header {
  margin-bottom: 26px;
}
.form-header h1 {
  font-family: 'Fraunces', serif;
  font-size: 2.8rem;
  font-weight: 900;
  color: var(--text-primary);
  line-height: 1.05;
  letter-spacing: -0.5px;
  margin-bottom: 6px;
}
.form-header p {
  color: var(--text-muted);
  font-size: 0.92rem;
}

/* Step indicator */
.steps {
  display: flex;
  align-items: center;
  gap: 0;
  margin-bottom: 24px;
}
.step {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 0.8rem;
  color: var(--text-muted);
}
.step-dot {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  border: 1px solid var(--border);
  background: var(--surface-1);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.75rem;
  font-weight: 700;
  flex-shrink: 0;
  transition: all 0.3s;
}
.step.active .step-dot {
  background: var(--green-bright);
  border-color: var(--green-bright);
  color: #01150e;
}
.step.active { color: var(--text-primary); }
.step-line {
  flex: 1;
  height: 1px;
  background: var(--border);
  margin: 0 10px;
  max-width: 50px;
}

/* ── INPUTS ── */
.input-group {
  margin-bottom: 13px;
  position: relative;
}

.input-group input,
.input-group select {
  width: 100%;
  height: 54px;
  background: var(--surface-1);
  border: 1px solid var(--border);
  border-radius: var(--radius-input);
  color: var(--text-primary);
  padding: 0 18px;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.93rem;
  outline: none;
  transition: border-color 0.25s, box-shadow 0.25s, background 0.25s;
  appearance: none;
  -webkit-appearance: none;
}

.input-group select {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' fill='none'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%237a9b86' stroke-width='1.5' stroke-linecap='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
  padding-right: 40px;
}

.input-group input::placeholder { color: var(--text-muted); }

.input-group select option {
  background: #0d2818;
  color: var(--text-primary);
}

.input-group select:invalid,
.input-group select option[value=""] { color: var(--text-muted); }

.input-group input:focus,
.input-group select:focus {
  border-color: var(--green-bright);
  background: rgba(163,230,53,0.04);
  box-shadow: 0 0 0 4px rgba(163,230,53,0.09);
}
.input-group input:hover:not(:focus),
.input-group select:hover:not(:focus) {
  border-color: rgba(163,230,53,0.28);
}

/* Date input color fix */
.input-group input[type="date"]::-webkit-calendar-picker-indicator {
  filter: invert(0.5) sepia(1) hue-rotate(80deg) saturate(2);
  opacity: 0.7;
  cursor: pointer;
}

/* Input row */
.input-row {
  display: flex;
  gap: 12px;
}
.input-row .input-group { flex: 1; }

/* Section label */
.section-label {
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--text-muted);
  margin: 16px 0 10px;
}

/* ── BUTTON ── */
.primary-btn {
  width: 100%;
  height: 56px;
  border: none;
  border-radius: var(--radius-input);
  background: var(--green-bright);
  color: #010e07;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.95rem;
  font-weight: 700;
  letter-spacing: 0.02em;
  cursor: pointer;
  margin-top: 6px;
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

/* ── SWITCH TEXT ── */
.switch-text {
  text-align: center;
  margin-top: 20px;
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
@media (max-width: 1100px) {
  .split-container { flex-direction: column; gap: 32px; padding-top: 110px; }
  .image-card { min-height: 380px; max-width: 100%; }
  .left-side, .right-side { flex: unset; width: 100%; max-width: 600px; }
  .right-side { align-items: stretch; }
  .form-container { max-width: 100%; }
}

@media (max-width: 600px) {
  .split-container { padding: 100px 5% 40px; }
  .form-header h1 { font-size: 2.2rem; }
  .image-card { min-height: 280px; }
  .input-row { flex-direction: column; gap: 0; }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav>
  <div class="logo">Hang<span>Aura</span></div>
  <a href="${pageContext.request.contextPath}/login" class="nav-link">
    Already a member? <strong>Login →</strong>
  </a>
</nav>

<!-- ALERTS -->
<div class="message-container">
  <c:if test="${not empty error}">
    <div class="banner error-banner">⚠ ${error}</div>
  </c:if>
</div>

<!-- MAIN -->
<main class="split-container">

  <!-- LEFT -->
  <div class="left-side">
    <div class="image-card">
      <img src="${pageContext.request.contextPath}/Image/pic1.jpg" alt="HangAura" class="side-image">
      <div class="image-overlay">
        <span class="overlay-badge">✦ Join HangAura</span>
        <div class="overlay-bottom">
          <h2>Your Journey Begins Here</h2>
          <p>Step into a world of pristine forests, mountain trails, and untamed wilderness.</p>
          <div class="perks">
            <div class="perk-item"><div class="perk-dot"></div> Curated nature experiences</div>
            <div class="perk-item"><div class="perk-dot"></div> Wildlife guides & trail maps</div>
            <div class="perk-item"><div class="perk-dot"></div> Community of explorers</div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- RIGHT -->
  <div class="right-side">
    <div class="form-container">

      <div class="form-header">
        <h1>Create Account</h1>
        <p>Join HangAura and explore nature like never before</p>
      </div>

      <form action="${pageContext.request.contextPath}/register" method="post">

        <p class="section-label">Personal Details</p>

        <div class="input-row">
          <div class="input-group">
            <input type="text" name="first_name" placeholder="First Name" required>
          </div>
          <div class="input-group">
            <input type="text" name="last_name" placeholder="Last Name" required>
          </div>
        </div>

        <div class="input-group">
          <input type="text" name="username" placeholder="Username" required>
        </div>

        <div class="input-group">
          <input type="email" name="email" placeholder="Email Address">
        </div>

        <div class="input-group">
          <input type="tel" name="number" placeholder="Phone Number">
        </div>

        <p class="section-label">Additional Info</p>

        <div class="input-row">
          <div class="input-group">
            <select name="gender" required>
              <option value="" disabled selected>Gender</option>
              <option value="Male">Male</option>
              <option value="Female">Female</option>
              <option value="Other">Prefer not to say</option>
            </select>
          </div>
          <div class="input-group">
            <input type="date" name="dob" required>
          </div>
        </div>
        
        <!-- PROGRAM ID (REQUIRED BY SERVLET) -->
        <div class="input-group">
          <input type="number" name="program" placeholder="Program ID" required />
        </div>

        <p class="section-label">Security</p>

        <div class="input-group">
          <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit" class="primary-btn">Create My Account →</button>

      </form>

      <p class="switch-text">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login" class="highlight-link">Login here</a>
      </p>

    </div>
  </div>

</main>

</body>
</html>
