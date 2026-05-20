<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>505 HTTP Version Not Supported | HangAura</title>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@400;600;700;800&family=DM+Sans:opsz,wght@9..40,300;9..40,400;9..40,500&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    min-height: 100vh;
    background: #0d1f13;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-family: 'DM Sans', sans-serif;
    padding: 2rem;
    position: relative;
    overflow: hidden;
  }

  /* ── GRID BACKGROUND ── */
  .grid-bg {
    position: fixed;
    inset: 0;
    background-image:
      linear-gradient(rgba(52,211,153,0.04) 1px, transparent 1px),
      linear-gradient(90deg, rgba(52,211,153,0.04) 1px, transparent 1px);
    background-size: 40px 40px;
    pointer-events: none;
    z-index: 0;
  }

  /* ── SCANLINES ── */
  .scanlines {
    position: fixed;
    inset: 0;
    background: repeating-linear-gradient(
      0deg,
      transparent,
      transparent 3px,
      rgba(0,0,0,0.06) 3px,
      rgba(0,0,0,0.06) 4px
    );
    pointer-events: none;
    z-index: 1;
  }

  /* ── PARTICLES ── */
  .particles {
    position: fixed;
    inset: 0;
    pointer-events: none;
    z-index: 2;
  }

  .particle {
    position: absolute;
    border-radius: 50%;
    background: #34d399;
    opacity: 0;
    animation: float-up linear infinite;
  }

  @keyframes float-up {
    0%   { transform: translateY(100vh) scale(0); opacity: 0; }
    10%  { opacity: 0.35; }
    90%  { opacity: 0.20; }
    100% { transform: translateY(-120px) scale(1); opacity: 0; }
  }

  /* ── LOGO ── */
  .logo {
    position: absolute;
    top: 1.5rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: 'Sora', sans-serif;
    font-weight: 700;
    font-size: 1.2rem;
    color: #a7f3d0;
    text-decoration: none;
    z-index: 10;
  }

  .logo-icon {
    width: 34px;
    height: 34px;
    border-radius: 10px;
    background: #14532d;
    border: 1px solid #34d399;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
  }

  .logo em { font-style: normal; color: #34d399; }

  /* ── MAIN ── */
  main.page {
    position: relative;
    z-index: 5;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  /* ── SCENE ── */
  .scene {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 0.25rem;
  }

  /* Floating symbols */
  .symbol {
    position: absolute;
    font-family: 'Sora', sans-serif;
    font-size: 1.4rem;
    font-weight: 800;
    color: #34d399;
    opacity: 0.45;
    animation: sym-bob 3s ease-in-out infinite;
    pointer-events: none;
    user-select: none;
  }

  .symbol:nth-child(1) { top: -10px;  left: -70px; animation-delay: 0s;    }
  .symbol:nth-child(2) { top:   0px;  right: -65px; animation-delay: 0.7s; }
  .symbol:nth-child(3) { bottom: 30px; left: -60px; animation-delay: 1.4s; }
  .symbol:nth-child(4) { bottom: 20px; right: -55px; animation-delay: 2.1s; }

  @keyframes sym-bob {
    0%, 100% { transform: translateY(0); }
    50%       { transform: translateY(-8px); }
  }

  /* ── GHOST WRAP (bobbing) ── */
  .ghost-wrap {
    animation: ghost-bob 3.2s ease-in-out infinite;
    position: relative;
  }

  @keyframes ghost-bob {
    0%, 100% { transform: translateY(0); }
    50%       { transform: translateY(-14px); }
  }

  /* ── GHOST BODY ── */
  .ghost-body {
    width: 120px;
    height: 120px;
    background: #166534;
    border-radius: 60px 60px 0 0;
    border: 2px solid rgba(52,211,153,0.4);
    position: relative;
  }

  .ghost-blush {
    position: absolute;
    bottom: 28px;
    width: 20px;
    height: 10px;
    border-radius: 50%;
    background: rgba(52,211,153,0.25);
  }
  .ghost-blush.left  { left: 14px; }
  .ghost-blush.right { right: 14px; }

  .ghost-eyes {
    position: absolute;
    bottom: 36px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 20px;
    transition: transform 0.05s linear;
  }

  .eye {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    background: #d1fae5;
    position: relative;
    overflow: hidden;
  }

  .eye::after {
    content: '';
    position: absolute;
    width: 9px;
    height: 9px;
    border-radius: 50%;
    background: #0d1f13;
    top:  calc(50% - 4.5px + var(--py, 0px));
    left: calc(50% - 4.5px + var(--px, 0px));
  }

  .ghost-mouth {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    width: 28px;
    height: 10px;
    border: 2px solid #a7f3d0;
    border-top: none;
    border-radius: 0 0 14px 14px;
  }

  /* ── GHOST BOTTOM (wavy) ── */
  .ghost-bottom svg {
    width: 124px;
    height: 26px;
    display: block;
    margin-top: -2px;
  }

  /* ── SHADOW ── */
  .ghost-shadow {
    width: 80px;
    height: 14px;
    border-radius: 50%;
    background: rgba(52,211,153,0.12);
    margin: 4px auto 0;
    animation: shadow-pulse 3.2s ease-in-out infinite;
  }

  @keyframes shadow-pulse {
    0%, 100% { transform: scaleX(1);   opacity: 0.5; }
    50%       { transform: scaleX(0.6); opacity: 0.2; }
  }

  /* ── 505 TEXT ── */
  .five-o-five {
    font-family: 'Sora', sans-serif;
    font-size: clamp(5rem, 18vw, 8rem);
    font-weight: 800;
    color: #34d399;
    line-height: 1;
    letter-spacing: -4px;
    margin: 0.25rem 0 0;
  }

  /* ── BADGE ── */
  .http-badge {
    display: inline-block;
    background: #14532d;
    border: 1px solid rgba(52,211,153,0.35);
    color: #6ee7b7;
    font-size: 0.78rem;
    font-family: 'DM Sans', sans-serif;
    padding: 4px 14px;
    border-radius: 999px;
    margin: 0.35rem 0 0.75rem;
    letter-spacing: 0.04em;
  }

  /* ── TAGLINE ── */
  .tagline {
    font-family: 'Sora', sans-serif;
    font-size: 1.3rem;
    font-weight: 700;
    color: #a7f3d0;
    margin: 0.1rem 0 0.3rem;
  }

  /* ── SUB TEXT ── */
  .sub {
    font-size: 0.95rem;
    color: #6ee7b7;
    max-width: 380px;
    line-height: 1.65;
    margin: 0 0 1.75rem;
  }

  /* ── BUTTONS ── */
  .btn-group {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    justify-content: center;
  }

  .btn-primary {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 0.65rem 1.4rem;
    border-radius: 999px;
    background: #16a34a;
    color: #f0fdf4;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.95rem;
    font-weight: 500;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: transform 0.15s, opacity 0.15s;
  }

  .btn-primary:hover {
    transform: translateY(-2px);
    opacity: 0.9;
  }

  .btn-ghost {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 0.65rem 1.4rem;
    border-radius: 999px;
    background: transparent;
    color: #a7f3d0;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.95rem;
    font-weight: 500;
    text-decoration: none;
    border: 1px solid rgba(52,211,153,0.4);
    cursor: pointer;
    transition: transform 0.15s, background 0.15s;
  }

  .btn-ghost:hover {
    transform: translateY(-2px);
    background: rgba(52,211,153,0.07);
  }
</style>
</head>

<body>

<div class="grid-bg"></div>
<div class="scanlines"></div>
<div class="particles" id="particles"></div>

<a href="<%= request.getContextPath() %>/" class="logo">
  <span class="logo-icon">
    <i class="fas fa-leaf"></i>
  </span>
  <span>Hang<em>Aura</em></span>
</a>

<main class="page">

  <!-- GHOST SCENE -->
  <div class="scene" id="scene">

    <span class="symbol">!</span>
    <span class="symbol">⚡</span>
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
        <svg viewBox="0 0 124 26"
             xmlns="http://www.w3.org/2000/svg"
             preserveAspectRatio="none">
          <path
            d="M0,0 L0,13 Q15.5,26 31,13 Q46.5,0 62,13 Q77.5,26 93,13 Q108.5,0 124,13 L124,0 Z"
            fill="#166534"
            stroke="rgba(52,211,153,.3)"
            stroke-width="1.5"/>
        </svg>
      </div>

    </div>

    <div class="ghost-shadow"></div>

  </div>

  <!-- TEXT -->
  <div class="five-o-five">505</div>

  <p class="tagline">
    HTTP Version Not Supported
  </p>

  <span class="http-badge">HTTP/1.0 &bull; Not Supported</span>

  <p class="sub">
    The server doesn't support the HTTP protocol version used in this request.
    Our ghost tried every version &mdash; even the ancient ones.
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

for (let i = 0; i < 20; i++) {

  const p = document.createElement('div');
  p.className = 'particle';

  const size = Math.random() * 4 + 2;

  p.style.cssText = `
    width:${size}px;
    height:${size}px;
    left:${Math.random() * 100}%;
    animation-duration:${Math.random() * 14 + 8}s;
    animation-delay:${Math.random() * 12}s;
  `;

  particlesEl.appendChild(p);
}

// ── EYES FOLLOW MOUSE ──
const scene  = document.getElementById('scene');
const eyes   = document.getElementById('ghostEyes');
const eyeL   = document.getElementById('eyeL');
const eyeR   = document.getElementById('eyeR');

document.addEventListener('mousemove', (e) => {

  const rect   = scene.getBoundingClientRect();
  const sceneX = rect.left + rect.width  / 2;
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

// ── TOUCH SUPPORT ──
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
