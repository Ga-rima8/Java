<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Hangaura</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/aboutus.css">
</head>
<body>

    <!-- About Us Hero -->
    <section class="hero">
        <div class="hero-content">
            <p class="top-label">WHO WE ARE</p>
            <h1>About Us</h1>
            <div class="divider"></div>
            <p class="hero-desc">
                We are a driven team committed to building extraordinary experiences with Hangaura. We believe that even the smallest details can make the biggest difference
                . Our mission is to empower people to connect, explore, and create events effortlessly. With innovation and teamwork at our core, we aim to deliver more than just a service - we create experiences that truly matter.
            </p>
        </div>
    </section>

    <!-- Separator -->
    <div class="section-sep"></div>

    <!-- Meet Our Team -->
    <section class="team-section">
        <div class="container">
            <div class="sec-header">
                <p class="top-label">THE PEOPLE BEHIND IT</p>
                <h2>Meet Our Team</h2>
                <p class="sec-sub">Three driven individuals, one shared vision — excellence in everything we do.</p>
            </div>

            <div class="team-grid">

                <!-- Member 1 — replace name, role, bio, image src -->
                <div class="card">
                    <div class="card-img-wrap">
                        <img src="${pageContext.request.contextPath}/images/Member.jpeg" alt="Member One" class="card-img" />
                        <%-- No image? Remove the img tag and use this:
                        <div class="placeholder">M1</div>
                        --%>
                    </div>
                    <div class="card-body">
                        <div class="card-line"></div>
                        <h3>Garima Pandey</h3>
                        <p class="role">Student</p>
                        <p class="bio">Visionary student driving the Hangaura mission</p>
                    </div>
                </div>

                <!-- Member 2 -->
                <div class="card">
                    <div class="card-img-wrap">
                        <img src="${pageContext.request.contextPath}/images/Member2.jpeg" alt="Member Two" class="card-img" />
                    </div>
                    <div class="card-body">
                        <div class="card-line"></div>
                        <h3>Sadikchya Lamichanne </h3>
                        <p class="role">Student</p>
                        <p class="bio">Visionary student driving the Hangaura mission</p>
                    </div>
                </div>

                <!-- Member 3 -->
                <div class="card">
                    <div class="card-img-wrap">
                        <img src="${pageContext.request.contextPath}/images/Member3.jpeg" alt="Member Three" class="card-img" />
                    </div>
                    <div class="card-body">
                        <div class="card-line"></div>
                        <h3>Suditi Shrestha</h3>
                        <p class="role">Student</p>
                        <p class="bio">Visionary student driving the Hangaura mission</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <script>
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
        }, { threshold: 0.15 });
        document.querySelectorAll('.card').forEach(el => observer.observe(el));
    </script>

</body>
</html>