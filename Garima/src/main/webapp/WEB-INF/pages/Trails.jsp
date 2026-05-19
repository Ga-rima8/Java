<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GHOST ELEMENTS | Adventure Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Trails.css">
</head>
<body>

<div class="container">
    <header>
        <span class="logo">Ghost Adventure Ops</span>
        <h1>Beyond the <span style="color: var(--ghost-green);">Horizon.</span></h1>
    </header>

    <div class="filter-bar">
        <div class="filter-link active" onclick="filterData('all', this)">All Experiences</div>
        <div class="filter-link" onclick="filterData('Air', this)">Air</div>
        <div class="filter-link" onclick="filterData('Water', this)">Water</div>
        <div class="filter-link" onclick="filterData('Land', this)">Land</div>
    </div>

    <div class="event-grid" id="mainGrid">
        </div>
</div>

<div class="overlay" id="eventOverlay">
    <div class="modal">
        <button class="close-modal" onclick="closeModal()">CLOSE</button>
        <img id="modalImg" class="modal-header-img" src="" alt="">
        <div class="modal-body">
            <div class="event-details">
                <span id="modalTag" class="card-tag"></span>
                <h2 id="modalTitle" style="font-size: 2.5rem; margin-bottom: 20px;"></h2>
                <p id="modalDesc" style="color: #aaa; line-height: 1.8;"></p>
                
                <div class="info-grid">
                    <div class="info-item"><b>Founder</b><span id="mInventor"></span></div>
                    <div class="info-item"><b>Curated By</b><span id="mOrg"></span></div>
                    <div class="info-item"><b>Expedition Venue</b><span id="mVenue"></span></div>
                    <div class="info-item"><b>Capacity</b><span id="mSize"></span></div>
                    <div class="info-item" style="grid-column: span 2;"><b>Historical Legacy</b><span id="mHist"></span></div>
                </div>
            </div>

            <div class="booking-section">
                <div class="price-box" id="mPrice"></div>
                <form onsubmit="finishBooking(event)">
                    <div class="input-group">
                        <label>Full Name</label>
                        <input type="text" required placeholder="John Doe">
                    </div>
                    <div class="input-group">
                        <label>Official Email</label>
                        <input type="email" required placeholder="john@example.com">
                    </div>
                    <div class="input-group">
                        <label>ID / Citizenship Proof (Image)</label>
                        <input type="file" accept="image/*" required>
                    </div>
                    <button type="submit" class="submit-btn">Initialize Reservation</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/Trails.js"></script>

</body>
</html>
