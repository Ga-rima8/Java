<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>404 Not Found | HangAura</title>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=DM+Sans:opsz,wght@9..40,300;9..40,400;9..40,500&display=swap" rel="stylesheet">
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/404.css">
<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
  --g400: #34d399;
  --g500: #10b981;
  --g600: #059669;
  --g700: #047857;
  --g800: #065f46;
  --bg:   #0a0f0d;
  --bg2:  #0f1712;
  --bg3:  #131d18;
  --surf: #172119;
  --surf2: #1c2a22;
  --t1:  #f0fdf4;
  --t2:  #bbf7d0;
  --muted: #4b6858;
  --border: rgba(52,211,153,.12);
}

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: 'DM Sans', sans-serif;
  background: var(--bg);
  color: var(--t1);
  overflow-x: hidden;
}

/* ── ANIMATED BG ── */
body::before {
  content: '';
  position: fixed;
  inset: 0;
  background:
    radial-gradient(ellipse 70% 50% at 15% 15%, rgba(52,211,153,.07), transparent),
    radial-gradient(ellipse 50% 70% at 85% 85%, rgba(16,185,129,.06), transparent),
    radial-gradient(ellipse 40% 40% at 50% 50%, rgba(52,211,153,.03), transparent);
  pointer-events: none;
  z-index: 0;
}

/* floating particles */
.particles {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 0;
  overflow: hidden;
}

.particle {
  position: absolute;
  border-radius: 50%;
  background: var(--g500);
  opacity: 0;
  animation: drift linear infinite;
}

@keyframes drift {
  0% {
    transform: translateY(100vh) scale(0);
    opacity: 0;
  }

  10% {
    opacity: .15;
  }

  90% {
    opacity: .08;
  }

  100% {
    transform: translateY(-20px) scale(1);
    opacity: 0;
  }
}

/* ── LAYOUT ── */
.page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 32px 20px;
  position: relative;
  z-index: 1;
  text-align: center;
}

/* ── LOGO ── */
.logo {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 48px;
  text-decoration: none;
}

.logo-icon {
  width: 32px;
  height: 32px;
  background: linear-gradient(135deg, var(--g700), var(--g400));
  border-radius: 8px;
  display: grid;
  place-items: center;
  font-size: 13px;
  color: #fff;
  box-shadow: 0 0 16px rgba(52,211,153,.3);
}

.logo span {
  font-family: 'Sora', sans-serif;
  font-weight: 700;
  font-size: 17px;
  color: var(--t1);
}

.logo span em {
  color: var(--g400);
  font-style: normal;
}

/* ── GHOST SCENE ── */
.scene {
  width: 280px;
  height: 280px;
  position: relative;
  margin: 0 auto 8px;
  cursor: none;
}

/* glow under ghost */
.ghost-shadow {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 18px;
  background: radial-gradient(ellipse, rgba(52,211,153,.25) 0%, transparent 70%);
  border-radius: 50%;
  animation: shadowPulse 3s ease-in-out infinite;
}

@keyframes shadowPulse {
  0%, 100% {
    transform: translateX(-50%) scaleX(1);
    opacity: .8;
  }

  50% {
    transform: translateX(-50%) scaleX(.75);
    opacity: .4;
  }
}

/* ghost body */
.ghost-wrap {
  position: absolute;
  top: 10px;
  left: 50%;
  transform: translateX(-50%);
  width: 140px;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% {
    transform: translateX(-50%) translateY(0);
  }

  50% {
    transform: translateX(-50%) translateY(-18px);
  }
}

.ghost-body {
  width: 140px;
  height: 150px;
  background: var(--surf2);
  border: 2px solid rgba(52,211,153,.25);
  border-radius: 70px 70px 0 0;
  position: relative;
  box-shadow:
    0 0 40px rgba(52,211,153,.12),
    inset 0 0 30px rgba(52,211,153,.05);
}

/* wiggly bottom */
.ghost-bottom {
  width: 140px;
  height: 30px;
  position: relative;
  overflow: hidden;
}

.ghost-bottom svg {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
}

/* eyes */
.ghost-eyes {
  position: absolute;
  top: 55px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 26px;
  transition: transform .05s linear;
}

.eye {
  width: 16px;
  height: 16px;
  background: var(--g400);
  border-radius: 50%;
  box-shadow: 0 0 8px var(--g500);
  position: relative;
}

.eye::after {
  content: '';
  position: absolute;
  width: 7px;
  height: 7px;
  background: var(--g800);
  border-radius: 50%;
  top: 50%;
  left: 50%;
  transform: translate(
    calc(-50% + var(--px, 0px)),
    calc(-50% + var(--py, 0px))
  );
  transition: transform .05s linear;
}

/* mouth */
.ghost-mouth {
  position: absolute;
  bottom: 38px;
  left: 50%;
  transform: translateX(-50%);
  width: 28px;
  height: 14px;
  border: 2px solid var(--g600);
  border-top: none;
  border-radius: 0 0 14px 14px;
}

/* blush */
.ghost-blush {
  position: absolute;
  bottom: 52px;
  width: 18px;
  height: 9px;
  background: rgba(52,211,153,.2);
  border-radius: 50%;
}

.ghost-blush.left {
  left: 18px;
}

.ghost-blush.right {
  right: 18px;
}

/* symbols */
.symbol {
  position: absolute;
  font-family: 'Sora', sans-serif;
  font-weight: 700;
  color: var(--g500);
  opacity: 0;
  pointer-events: none;
  font-size: 20px;
}

.symbol:nth-child(1) {
  top: 30px;
  left: -30px;
  animation: symbolFloat 4s ease-in-out 0s infinite;
}

.symbol:nth-child(2) {
  top: 10px;
  right: -20px;
  animation: symbolFloat 4s ease-in-out 1s infinite;
  font-size: 14px;
}

.symbol:nth-child(3) {
  top: 70px;
  left: -50px;
  animation: symbolFloat 4s ease-in-out 2s infinite;
  font-size: 16px;
}

.symbol:nth-child(4) {
  top: 60px;
  right: -40px;
  animation: symbolFloat 4s ease-in-out 1.5s infinite;
  font-size: 24px;
}

@keyframes symbolFloat {
  0% {
    opacity: 0;
    transform: translate(0,0) rotate(0deg);
  }

  20% {
    opacity: .7;
  }

  80% {
    opacity: .4;
  }

  100% {
    opacity: 0;
    transform: translate(-10px,-30px) rotate(30deg);
  }
}

/* ── 404 TEXT ── */
.four-o-four {
  font-family: 'Sora', sans-serif;
  font-size: clamp(72px, 18vw, 120px);
  font-weight: 800;
  letter-spacing: -4px;
  line-height: 1;
  margin-bottom: 8px;
  background: linear-gradient(
    135deg,
    var(--g400) 0%,
    var(--g600) 60%,
    rgba(52,211,153,.3) 100%
  );
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  filter: drop-shadow(0 0 24px rgba(52,211,153,.2));
}

.tagline {
  font-family: 'Sora', sans-serif;
  font-size: clamp(16px, 4vw, 22px);
  font-weight: 600;
  color: var(--t2);
  margin-bottom: 10px;
}

.sub {
  font-size: 14px;
  color: var(--muted);
  max-width: 320px;
  line-height: 1.6;
  margin: 0 auto 36px;
}

/* ── BUTTONS ── */
.btn-group {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  justify-content: center;
}

.btn-primary,
.btn-ghost {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  height: 48px;
  padding: 0 28px;
  border-radius: 12px;
  text-decoration: none;
  transition: all .25s;
  font-family: 'Sora', sans-serif;
  font-size: 14px;
}

.btn-primary {
  background: linear-gradient(135deg, var(--g700), var(--g500));
  color: #fff;
  font-weight: 700;
  border: none;
  box-shadow: 0 4px 20px rgba(52,211,153,.25);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 30px rgba(52,211,153,.4);
  background: linear-gradient(135deg, var(--g600), var(--g400));
}

.btn-ghost {
  background: transparent;
  color: var(--g400);
  border: 1px solid rgba(52,211,153,.25);
  font-weight: 600;
}

.btn-ghost:hover {
  background: rgba(52,211,153,.08);
  border-color: var(--g500);
  transform: translateY(-2px);
}

/* ── SCAN LINE EFFECT ── */
body::after {
  content: '';
  position: fixed;
  inset: 0;
  background: repeating-linear-gradient(
    0deg,
    transparent,
    transparent 2px,
    rgba(0,0,0,.03) 2px,
    rgba(0,0,0,.03) 4px
  );
  pointer-events: none;
  z-index: 999;
}

/* ── RESPONSIVE ── */
@media (max-width: 480px) {

  .scene {
    width: 220px;
    height: 220px;
  }

  .ghost-wrap {
    width: 110px;
  }

  .ghost-body {
    width: 110px;
    height: 120px;
    border-radius: 55px 55px 0 0;
  }

  .ghost-bottom {
    width: 110px;
  }

  .ghost-eyes {
    top: 42px;
    gap: 20px;
  }

  .ghost-shadow {
    width: 80px;
  }

  .btn-group {
    flex-direction: column;
    align-items: center;
  }

  .btn-primary,
  .btn-ghost {
    width: 220px;
  }
}
</style>
</head>

<body>

<div class="particles" id="particles"></div>

<main class="page">

  <a href="<%= request.getContextPath() %>/" class="logo">
    <span class="logo-icon">
      <i class="fas fa-leaf"></i>
    </span>
    <span>Hang<em>Aura</em></span>
  </a>

  <!-- GHOST SCENE -->
  <div class="scene" id="scene">

    <span class="symbol">?</span>
    <span class="symbol">!</span>
    <span class="symbol">×</span>
    <span class="symbol">∅</span>

    <div class="ghost-wrap">

      <div class="ghost-body">

        <div class="ghost-blush left"></div>
        <div class="ghost-blush right"></div>

        <div class="ghost-eyes" id="ghostEyes">
          <div class="eye" id="eyeL"></div>
          <div class="eye" id="eyeR"></div>
        </div>

        <div class="ghost-mouth"></div>

      </div>

      <div class="ghost-bottom">
        <svg viewBox="0 0 140 30"
             xmlns="http://www.w3.org/2000/svg"
             preserveAspectRatio="none">

          <path
            d="M0,0 L0,15 Q17.5,30 35,15 Q52.5,0 70,15 Q87.5,30 105,15 Q122.5,0 140,15 L140,0 Z"
            fill="#1c2a22"
            stroke="rgba(52,211,153,.25)"
            stroke-width="2"/>
        </svg>
      </div>

    </div>

    <div class="ghost-shadow"></div>

  </div>

  <!-- TEXT -->
  <div class="four-o-four">404</div>

  <p class="tagline">
    Whoops — this page vanished!
  </p>

  <p class="sub">
    The page you're looking for doesn't exist or may have been moved.
    Don't worry, our ghost checked everywhere.
  </p>

  <!-- BUTTONS -->
  <div class="btn-group">

    <a href="<%= request.getContextPath() %>/" class="btn-primary">
      <i class="fas fa-home"></i>
      Back to Home
    </a>

    <a href="javascript:history.back()" class="btn-ghost">
      <i class="fas fa-arrow-left"></i>
      Go Back
    </a>

  </div>

</main>

<script>
// ── PARTICLES ──
const particlesEl = document.getElementById('particles');

for (let i = 0; i < 18; i++) {

  const p = document.createElement('div');
  p.className = 'particle';

  const size = Math.random() * 4 + 2;

  p.style.cssText = `
    width:${size}px;
    height:${size}px;
    left:${Math.random() * 100}%;

    animation-duration:${Math.random() * 12 + 8}s;
    animation-delay:${Math.random() * 10}s;
  `;

  particlesEl.appendChild(p);
}

// ── EYES FOLLOW MOUSE ──
const scene = document.getElementById('scene');
const eyes  = document.getElementById('ghostEyes');
const eyeL  = document.getElementById('eyeL');
const eyeR  = document.getElementById('eyeR');

document.addEventListener('mousemove', (e) => {

  const rect = scene.getBoundingClientRect();

  const sceneX = rect.left + rect.width / 2;
  const sceneY = rect.top  + rect.height / 2;

  const dx = e.clientX - sceneX;
  const dy = e.clientY - sceneY;

  const angle = Math.atan2(dy, dx);
  const dist  = Math.min(Math.sqrt(dx * dx + dy * dy), 60);

  const ex = Math.cos(angle) * dist * 0.08;
  const ey = Math.sin(angle) * dist * 0.06;

  eyes.style.transform =
    `translateX(calc(-50% + ${ex}px)) translateY(${ey}px)`;

  const px = Math.cos(angle) * 3;
  const py = Math.sin(angle) * 3;

  eyeL.style.setProperty('--px', px + 'px');
  eyeL.style.setProperty('--py', py + 'px');

  eyeR.style.setProperty('--px', px + 'px');
  eyeR.style.setProperty('--py', py + 'px');
});

// touch support
document.addEventListener('touchmove', (e) => {

  const t = e.touches[0];

  document.dispatchEvent(
    new MouseEvent('mousemove', {
      clientX: t.clientX,
      clientY: t.clientY
    })
  );

}, { passive: true });
</script>

</body>
</html>