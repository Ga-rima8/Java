<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserve — ${param.title} | Ghost Adventure Ops</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Booking.css">
</head>
<body>



<div class="noise"></div>

<div class="confirm-screen" id="confirmScreen">
    <div class="confirm-inner">
        <div class="confirm-icon">
            <svg viewBox="0 0 60 60" fill="none">
                <circle cx="30" cy="30" r="29" stroke="#afff00" stroke-width="1.5"/>
                <path d="M18 30L26 38L42 22" stroke="#afff00" stroke-width="2"
                      stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
        <p class="confirm-label">CLEARANCE INITIATED</p>
        <h2 class="confirm-title">You're on the list.</h2>
        <p class="confirm-sub">
            Ghost-clearance ID will be sent within 24 hrs.
            Prepare for <strong>${param.title}</strong>.
        </p>
        <a href="${pageContext.request.contextPath}/Adventure" class="back-link">
            &larr; Back to Expeditions
        </a>
    </div>
</div>


<div class="page-wrap" id="pageWrap">

  
    <aside class="info-panel">

        <a href="${pageContext.request.contextPath}/Adventure" class="back-nav">
            &larr; All Expeditions
        </a>

        <div class="event-img-wrap">
            <img src="${pageContext.request.contextPath}/${param.img}"
                 alt="${param.title}" class="event-hero-img">
            <div class="img-gradient"></div>
            <span class="type-badge">${param.type}</span>
        </div>

        <div class="info-content">
            <p class="info-eyebrow">You are booking</p>
            <h1 class="info-title">${param.title}</h1>
            <p class="info-desc">${param.desc}</p>

            <div class="meta-list">
                <div class="meta-row">
                    <span class="meta-key">Organizer</span>
                    <span class="meta-val">${param.org}</span>
                </div>
                <div class="meta-row">
                    <span class="meta-key">Founded by</span>
                    <span class="meta-val">${param.inv}</span>
                </div>
                <div class="meta-row">
                    <span class="meta-key">Venue</span>
                    <span class="meta-val">${param.venue}</span>
                </div>
                <div class="meta-row">
                    <span class="meta-key">Group Size</span>
                    <span class="meta-val">${param.size}</span>
                </div>
                <div class="meta-row">
                    <span class="meta-key">Price</span>
                    <span class="meta-val price-highlight">${param.price}</span>
                </div>
            </div>

            <div class="legacy-box">
                <p class="legacy-label">Historical Legacy</p>
                <p class="legacy-text">${param.hist}</p>
            </div>

            <div class="prev-events">
                <p class="prev-label">Previous Events by ${param.org}</p>
                <div class="prev-list">
                    <div class="prev-item">
                        <span class="prev-dot"></span>
                        <span>Summit Recon 2022 — 94% success rate</span>
                    </div>
                    <div class="prev-item">
                        <span class="prev-dot"></span>
                        <span>Void Descent 2023 — Featured in NatGeo</span>
                    </div>
                    <div class="prev-item">
                        <span class="prev-dot"></span>
                        <span>Ghost Circuit 2024 — Sold out in 6 hrs</span>
                    </div>
                </div>
            </div>

            <div class="participants-box">
                <p class="participants-label">Current Participants</p>
                <div class="avatar-row">
                    <div class="avatar" style="background:#1f5f3a;">J</div>
                    <div class="avatar" style="background:#0b3d1f;">M</div>
                    <div class="avatar" style="background:#143d26;">R</div>
                    <div class="avatar" style="background:#2a7a4e;">S</div>
                    <div class="avatar more">+2</div>
                </div>
                <p class="slots-left">2 slots remaining</p>
            </div>

        </div>
    </aside>

  
    <main class="form-panel">
        <div class="form-wrap">

            <div class="form-header">
                <p class="form-eyebrow">Step 01 — Identity Verification</p>
                <h2 class="form-title">Secure Your Slot</h2>
                <p class="form-sub">Fill in your details to initialize ghost clearance.</p>
            </div>

            <form class="booking-form" id="bookingForm" onsubmit="submitBooking(event)">

                <%-- Row 1 --%>
                <div class="field-group two-col">
                    <div class="field floating">
                        <input type="text" id="fullName" required placeholder=" ">
                        <label for="fullName">Full Name</label>
                        <span class="field-line"></span>
                    </div>
                    <div class="field floating">
                        <input type="email" id="email" required placeholder=" ">
                        <label for="email">Official Email</label>
                        <span class="field-line"></span>
                    </div>
                </div>

                <%-- Row 2 --%>
                <div class="field-group two-col">
                    <div class="field floating">
                        <input type="tel" id="phone" required placeholder=" ">
                        <label for="phone">Phone Number</label>
                        <span class="field-line"></span>
                    </div>
                    <div class="field floating">
                        <input type="number" id="age" min="18" max="70" required placeholder=" ">
                        <label for="age">Age</label>
                        <span class="field-line"></span>
                    </div>
                </div>

                <%-- Emergency contact --%>
                <div class="field floating full">
                    <input type="text" id="emergency" required placeholder=" ">
                    <label for="emergency">Emergency Contact — Name &amp; Number</label>
                    <span class="field-line"></span>
                </div>

              
                <div class="field full">
                    <p class="select-label">Experience Level</p>
                    <div class="level-picker">
                        <button type="button" class="level-btn active" data-level="Beginner">Beginner</button>
                        <button type="button" class="level-btn" data-level="Intermediate">Intermediate</button>
                        <button type="button" class="level-btn" data-level="Expert">Expert</button>
                    </div>
                    <input type="hidden" id="expLevel" value="Beginner">
                </div>

              
                <div class="field full">
                    <p class="select-label">Citizenship / ID Proof</p>
                    <div class="upload-zone" id="uploadZone" onclick="triggerUpload()">
                        <div class="upload-inner" id="uploadInner">
                            <div class="upload-icon">
                                <svg viewBox="0 0 48 48" fill="none">
                                    <path d="M24 32V16M24 16L16 24M24 16L32 24"
                                          stroke="#afff00" stroke-width="1.5"
                                          stroke-linecap="round" stroke-linejoin="round"/>
                                    <rect x="8" y="34" width="32" height="4" rx="1"
                                          stroke="#333" stroke-width="1"/>
                                </svg>
                            </div>
                            <p class="upload-text">Click or drop your ID / Citizenship card image</p>
                            <p class="upload-hint">JPG, PNG &middot; max 5MB</p>
                        </div>
                        <div class="upload-preview" id="uploadPreview">
                            <img id="previewImg" src="" alt="ID Preview">
                            <p id="previewName" class="preview-name"></p>
                            <button type="button" class="remove-img"
                                    onclick="removeImage(event)">&#x2715; Remove</button>
                        </div>
                    </div>
                    <input type="file" id="cidFile" accept="image/*" required
                           style="display:none" onchange="handleFile(this)">
                </div>

                <div class="field full">
                    <p class="select-label">Anything we should know?</p>
                    <textarea id="notes" rows="3"
                              placeholder="Medical conditions, dietary needs, special requests..."></textarea>
                </div>

               
                <div class="terms-row">
                    <input type="checkbox" id="terms" required>
                    <label for="terms">
                        I accept the risk waiver and Ghost Adventure Ops terms of expedition.
                    </label>
                </div>

              
                <button type="submit" class="submit-btn" id="submitBtn">
                    <span class="btn-text">Initialize Reservation</span>
                    <span class="btn-arrow">&#8594;</span>
                    <div class="btn-glow"></div>
                </button>

            </form>
        </div>
    </main>

</div>

<script src="${pageContext.request.contextPath}/js/Booking.js"></script>
</body>
</html>
