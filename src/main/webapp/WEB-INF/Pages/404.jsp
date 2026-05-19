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