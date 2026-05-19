<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>HangAura | Contact Us</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/contact.css">
</head>

<body>

<div class="container">

<!-- LEFT INFO PANEL -->
<div class="left">

    <h2>Contact HangAura</h2>
    <p>Have questions, feedback, or business inquiries? Our team is here to help you.</p>

    <div class="info">
        <h4>Email</h4>
        <span>support@hangaura.com</span>
    </div>

    <div class="info">
        <h4>Phone</h4>
        <span>+977-98XXXXXXXX</span>
    </div>

    <div class="info">
        <h4>Location</h4>
        <span>Kathmandu, Nepal</span>
    </div>

    <!-- SOCIAL MEDIA -->
    <div class="social">
        <h4>Follow Us</h4>

        <div class="social-icons">

            <a href="https://instagram.com" target="_blank" class="icon ig">
                <i class="fab fa-instagram"></i>
            </a>

            <a href="https://facebook.com" target="_blank" class="icon fb">
                <i class="fab fa-facebook-f"></i>
            </a>

            <a href="https://tiktok.com" target="_blank" class="icon tt">
                <i class="fab fa-tiktok"></i>
            </a>

        </div>
    </div>

</div>

<!-- RIGHT FORM PANEL -->
<div class="right">

    <h2>Send Message</h2>

    <c:if test="${not empty success}">
        <div class="alert success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/contact" method="post">

        <div class="form-group">
            <div class="input-box">
                <input type="text" name="firstName" placeholder="First Name" required>
            </div>
            <div class="input-box">
                <input type="text" name="lastName" placeholder="Last Name" required>
            </div>
        </div>

        <div class="form-group">
            <div class="input-box">
                <input type="email" name="email" placeholder="Email Address" required>
            </div>
            <div class="input-box">
                <input type="tel" name="phone" placeholder="Phone Number" required>
            </div>
        </div>

        <div class="input-box">
            <input type="text" name="company" placeholder="Company / Organization">
        </div>

        <div class="input-box">
            <select name="inquiryType" required>
                <option value="">Select Inquiry Type</option>
                <option>General Inquiry</option>
                <option>Support</option>
                <option>Feedback</option>
                <option>Business</option>
            </select>
        </div>

        <div class="input-box">
            <textarea name="message" placeholder="Write your message..." required></textarea>
        </div>

        <button type="submit">Send Message</button>

    </form>

</div>

</div>

</body>
</html>