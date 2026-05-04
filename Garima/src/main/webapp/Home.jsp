<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%String path = request.getContextPath();%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>HangAura</title>

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@900&family=Raleway:wght@400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet"/>

  <!-- GSAP -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollToPlugin.min.js"></script>

  <!-- Vue 2 -->
  <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>

  <!-- Page CSS -->
  <link rel="stylesheet" href="<%=path%>/css/Home.css">
</head>
<body>

  <!-- NAVBAR -->
  <nav id="navbar">
    <a class="nav-logo" href="<%=path%>/Home.jsp">HangAura</a>
    <ul class="nav-links">
      <li><a href="<%=path%>/home.jsp">Home</a></li>
      <!-- Adventure link navigates to the Ghost Elements adventure portal -->
      <li><a href="Adventure.jsp">Adventure</a></li>
      <li><a href="Adventure.jsp">Social</a></li>
      <li><a href="Adventure.jsp">Creative</a></li>
      <li><a href="Adventure.jsp">Trails</a></li>
      <li><a href="Adventure.jsp">About Us</a></li>
    </ul>
    <div class="nav-buttons">
      <button class="nav-host" id="open-host-modal">Host Event</button>
      <button class="nav-login" onclick="window.location.href='<%=path%>/login.jsp'">Login</button>
    </div>
  </nav>

  <!-- PARALLAX -->
  <div class="scrollDist"></div>

  <div id="parallax-scene">
    <svg
      viewBox="0 0 1500 850"
      xmlns="http://www.w3.org/2000/svg"
      preserveAspectRatio="xMidYMid slice"
      width="100%"
      height="100%"
    >
      <mask id="m">
        <g class="cloud1">
          <rect fill="#fff" width="100%" height="801" y="799"/>
          <image href="<%=path%>/img/cloud1Mask.jpg" width="1200" height="800"/>
        </g>
      </mask>

      <image class="tree"   href="<%=path%>/img/Tree.png"   width="1500" height="900"/>
      <image class="TreeBg" href="<%=path%>/img/Treebg.png"  x="150"  y="50"  width="1200" height="800"/>
      <image class="Tree1"  href="<%=path%>/img/Tree1.png"   x="600"  y="90"  width="1200" height="1000"/>
      <image class="cloud2" href="<%=path%>/img/cloud2.png"  x="350"  y="200" width="1200" height="800"/>
      <image class="Tree1"  href="<%=path%>/img/Tree1.png"   x="-150" y="90"  width="800"  height="1000"/>
      <image class="cloud1" href="<%=path%>/img/cloud1.png"  x="800"  y="10"  width="1200" height="800"/>
      <image class="cloud3" href="<%=path%>/img/cloud3.png"  x="200"  y="100" width="1200" height="800"/>

      <text fill="#022c22" x="500" y="400">HangAura</text>

      <g mask="url(#m)">
        <rect fill="#fff" width="100%" height="100%"/>
        <text x="500" y="300" fill="#022c22">LIVE MORE</text>
        <text x="300" y="350" fill="#022c22" font-size="18" text-anchor="middle" font-family="Raleway, sans-serif">
          <tspan x="750" dy="0">HangAura is where boredom goes to die and memories come to life.</tspan>
          <tspan x="750" dy="22">It's not just a website. It's your personal gateway to discovering cool events,</tspan>
          <tspan x="750" dy="22">meeting new people, and turning "I have nothing to do" into "That was the best day ever."</tspan>
          <tspan x="750" dy="22">Whether you're chasing adventure, creativity, or just an excuse to get out of the house,</tspan>
          <tspan x="750" dy="22">HangAura's got your vibe covered.</tspan>
        </text>
      </g>

      <rect id="arrow-btn" width="2600" height="100" opacity="0" x="500" y="400" style="cursor:pointer"/>
    </svg>
  </div>

  <!-- CARDS SECTION -->
  <section id="cards-section">
    <h1 class="cards-title">Explore the Events</h1>

    <div id="app" class="container">
      <!-- Clicking Adventure card also navigates to adventure.jsp -->
   <card data-image="<%=path%>/img/adventure.png" link="<%=path%>/Adventure.jsp">
        <h1 slot="header">Adventure</h1>
        <p slot="content">Join the excitement to move the adrenaline.</p>
      </card>
      <card data-image="<%=path%>/img/creative.png" alt="Creative" link="<%=path%>/Adventure.jsp">
        <h1 slot="header">Creative</h1>
        <p slot="content">Let the inner voice speak and blend.</p>
      </card>
      <card data-image="<%=path%>/img/social.png" alt="Social" link="<%=path%>/Adventure.jsp">
        <h1 slot="header">Social</h1>
        <p slot="content">Help humans to be human. Join the social hub ASAP.</p>
      </card>
      <card data-image="<%=path%>/img/trails.png" alt="Trails" link="<%=path%>/Adventure.jsp">
        <h1 slot="header">Trails</h1>
        <p slot="content">Make your journey more exciting and memorable.</p>
      </card>
    </div>
  </section>

  <!-- GALLERY SECTION -->
  <div class="columns">
    <div class="column column-reverse">
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/1.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/2.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/3.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/4.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/5.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/6.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/7.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/8.png"  alt=""></div></figure>
    </div>
    <div class="column">
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/9.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/10.png" alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/11.png" alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/12.png" alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/1.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/2.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/3.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/6.png"  alt=""></div></figure>
    </div>
    <div class="column column-reverse">
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/9.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/5.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/7.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/10.png" alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/4.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/12.png" alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/8.png"  alt=""></div></figure>
      <figure class="column__item"><div class="column__item-imgwrap"><img src="<%=path%>/img/1.png"  alt=""></div></figure>
    </div>
  </div>

  <footer id="footer">
  <div class="footer-top">
    <div class="footer-brand">
      <h2>HangAura</h2>
      <p>Where every moment becomes a memory. Discover events that move your soul, spark your creativity, and connect you with the world.</p>
      <div class="social-row">
        <a class="social-btn" href="#" title="Instagram">IG</a>
        <a class="social-btn" href="#" title="Twitter/X">X</a>
        <a class="social-btn" href="#" title="YouTube">YT</a>
        <a class="social-btn" href="#" title="Facebook">FB</a>
      </div>
    </div>
    <div class="footer-col">
      <h4>Explore</h4>
      <ul>
        <li><a href="home.jsp">Home</a></li>
        <li><a href="Adventure.jsp">Adventure</a></li>
        <li><a href="Social.jsp">Social</a></li>
        <li><a href="Creative.jsp">Creative</a></li>
        <li><a href="Trails.jsp">Trails</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Company</h4>
      <ul>
        <li><a href="#">About Us</a></li>
        <li><a href="#">Our Story</a></li>
        <li><a href="#">Careers</a></li>
        <li><a href="#">Press</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Stay in the Loop</h4>
      <p class="newsletter-sub">Get the latest events and drops straight to your inbox.</p>
      <div class="newsletter-row">
        <input type="email" id="emailInput" placeholder="your@email.com" />
        <button onclick="handleSubscribe()">Go</button>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    <p>&copy; 2025 HangAura. All rights reserved.</p>
    <div class="footer-bottom-links">
      <a href="#">Privacy Policy</a>
      <span class="leaf-divider">✦</span>
      <a href="#">Terms of Use</a>
      <span class="leaf-divider">✦</span>
      <a href="#">Cookies</a>
    </div>
  </div>
  <div class="toast" id="toast"></div>
</footer>

  <!-- Page JS -->
  <script src="<%=path%>/js/Home.js"></script>
</body>
</html>
