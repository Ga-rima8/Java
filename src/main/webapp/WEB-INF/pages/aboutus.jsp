<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Hangaura</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;0,700;1,400;1,700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/aboutus.css">
</head>
<body>

    <!-- HERO — replace hero-bg.jpg with your own image -->
    <section class="hero">
        <img class="hero-img" src="${pageContext.request.contextPath}/images/abt.jpg" alt="Hangaura Background" />
        <div class="hero-overlay"></div>
        <div class="hero-glass">
            <p class="eyebrow on-dark">WHO WE ARE</p>
            <h1>About<br><em>Hangaura</em></h1>
            <div class="hero-line"></div>
            <p class="hero-desc">We are a driven team committed to building extraordinary experiences — empowering people to connect, explore, and create events effortlessly.</p>
            <a href="#team" class="hero-btn">Meet The Team</a>
        </div>
    </section>

    <!-- STORY / STATS -->
    <section class="invite">
        <div class="invite-content">
            <p class="eyebrow on-light">OUR STORY</p>
            <h2>We Invite You to<br>Experience <em>Hangaura</em></h2>
            <p class="invite-text">Born from a shared passion for seamless event management, Hangaura is more than a platform — it is a community. We believe that every gathering, big or small, deserves to be remembered.</p>
        </div>
        <div class="invite-visual">
            <div class="visual-card">
                <div class="vc-num">200+</div>
                <div class="vc-label">Events Hosted</div>
            </div>
            <div class="visual-card">
                <div class="vc-num">1K+</div>
                <div class="vc-label">Happy Guests</div>
            </div>
            <div class="visual-card">
                <div class="vc-num">3</div>
                <div class="vc-label">Passionate Founders</div>
            </div>
        </div>
    </section>

    <!-- TEAM -->
    <section class="team" id="team">
        <p class="eyebrow on-light center">THE PEOPLE BEHIND IT</p>
        <h2 class="section-title center">Meet Our <em>Team</em></h2>
        <p class="team-sub">Three driven individuals, one shared vision — excellence in everything we do.</p>

        <div class="grid">

            <div class="card">
                <div class="card-number">01</div>
                <div class="img-wrap">
                    <img src="${pageContext.request.contextPath}/images/Member.jpeg" alt="Garima Pandey" />
                </div>
                <h3>Garima Pandey</h3>
                <p class="role">Student &amp; Co-Founder</p>
                <div class="bar-sm"></div>
                <p class="bio">Driving the Hangaura mission with creativity and strategic insight. The visionary behind our design language.</p>
            </div>

            <div class="card card-featured">
                <div class="card-number">02</div>
                <div class="img-wrap">
                    <img src="${pageContext.request.contextPath}/images/Member2.jpeg" alt="Sadikchya Lamichanne" />
                </div>
                <h3>Sadikchya Lamichanne</h3>
                <p class="role">Student &amp; Co-Founder</p>
                <div class="bar-sm"></div>
                <p class="bio">Driving the Hangaura mission with dedication and passion. The engine that keeps our team moving forward.</p>
            </div>

            <div class="card">
                <div class="card-number">03</div>
                <div class="img-wrap">
                    <img src="${pageContext.request.contextPath}/images/Member3.jpeg" alt="Suditi Shrestha" />
                </div>
                <h3>Suditi Shrestha</h3>
                <p class="role">Student &amp; Co-Founder</p>
                <div class="bar-sm"></div>
                <p class="bio">Driving the Hangaura mission with relentless energy and focus. The force behind our community growth.</p>
            </div>

        </div>
    </section>

</body>
</html>