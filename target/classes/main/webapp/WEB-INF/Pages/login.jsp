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
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/login.css">
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
  <c:if test="${not empty success}">
    <div class="banner success-banner">✓ ${success}</div>
  </c:if>
</div>

<!-- MAIN -->
<main class="split-container">

  <!-- LEFT -->
  <div class="left-side">
    <div class="image-card">
      <img src="${pageContext.request.contextPath}/Image/pic1.jpg" alt="HangAura Nature" class="side-image">
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
      <div class="about-icon">🌿</div>
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

      <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="input-group">
          <input type="text" name="username" placeholder="username" required>
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
