<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile | HangAura</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,400&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/profile.css">
</head>
<body>

<%-- ── DETERMINE whether user has a profile image (BLOB exists) ── --%>
<c:set var="hasImage" value="${not empty user.profileImage and user.profileImage.length > 0}"/>

<!-- ── ALERT STACK ── -->
<div class="alert-stack" id="alertStack">
  <c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">
      <i class="fas fa-check-circle alert-icon"></i>
      <span class="alert-body"><c:out value="${message}"/></span>
      <button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>
      <div class="alert-progress"></div>
    </div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-error" role="alert">
      <i class="fas fa-exclamation-circle alert-icon"></i>
      <span class="alert-body"><c:out value="${error}"/></span>
      <button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>
      <div class="alert-progress"></div>
    </div>
  </c:if>
</div>
<c:remove var="message" scope="session"/>
<c:remove var="error"   scope="session"/>

<!-- ── OVERLAY ── -->
<div class="sb-overlay" id="sbOverlay" onclick="closeSidebar()"></div>

<!-- ══════════════════════════════════ SIDEBAR ══════════════════════════════ -->
<div class="sidebar" id="sidebar">
  <div class="sb-logo">
    <span class="sb-logo-icon"><i class="fas fa-leaf"></i></span>
    <h2>Hang<span>Aura</span></h2>
  </div>
  <nav class="sb-nav">
    <div class="sb-section-label">Main</div>
    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
      <span class="nav-icon"><i class="fas fa-th-large"></i></span><span>Dashboard</span>
    </a>
    <a href="${pageContext.request.contextPath}/Home" class="nav-link">
      <span class="nav-icon"><i class="fas fa-home"></i></span><span>Home</span>
    </a>
    <div class="sb-section-label">Events</div>
    <a href="${pageContext.request.contextPath}/Event" class="nav-link">
      <span class="nav-icon"><i class="fas fa-calendar-alt"></i></span><span>Browse Events</span>
    </a>
    <a href="${pageContext.request.contextPath}/myregistrations" class="nav-link">
      <span class="nav-icon"><i class="fas fa-ticket-alt"></i></span><span>My Registrations</span>
    </a>
    <div class="sb-section-label">Account</div>
    <a href="${pageContext.request.contextPath}/profile" class="nav-link active">
      <span class="nav-icon"><i class="fas fa-user-edit"></i></span><span>Edit Profile</span>
    </a>
  </nav>
  <div class="sb-footer">
    <div class="sb-user">
      <div class="sb-user-avatar" id="sbAvatar">
        <c:choose>
          <c:when test="${hasImage}">
            <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
          </c:when>
          <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
        </c:choose>
      </div>
      <div class="sb-user-info">
        <span class="sb-user-name"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
        <span class="sb-user-role">Member</span>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="nav-link logout-link">
      <span class="nav-icon"><i class="fas fa-sign-out-alt"></i></span><span>Logout</span>
    </a>
  </div>
</div>

<!-- ══════════════════════════════════ MAIN ══════════════════════════════════ -->
<div class="main" id="mainContent">

  <!-- TOPBAR -->
  <div class="topbar">
    <div class="topbar-left">
      <button class="hamburger" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
      <div class="breadcrumb">
        <i class="fas fa-user-edit" style="color:var(--g500);margin-right:6px;font-size:13px;"></i>Edit Profile
      </div>
    </div>
    <div class="topbar-right">
      <div class="notif-btn"><i class="fas fa-bell"></i><span class="notif-dot"></span></div>
      <div class="user-dropdown" id="userDropdown">
        <div class="user-trigger" onclick="toggleDropdown()">
          <div class="avatar-sm" id="topbarAvatar">
            <c:choose>
              <c:when test="${hasImage}">
                <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
              </c:when>
              <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
            </c:choose>
          </div>
          <span class="user-name" id="topbarName"><c:out value="${not empty user.firstName ? user.firstName : 'User'}"/></span>
          <i class="fas fa-chevron-down chev"></i>
        </div>
        <div class="dropdown-menu" id="dropdownMenu">
          <div class="dropdown-header">
            <div class="avatar-md">
              <c:choose>
                <c:when test="${hasImage}">
                  <img src="${pageContext.request.contextPath}/profileImage" alt="avatar">
                </c:when>
                <c:otherwise><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></c:otherwise>
              </c:choose>
            </div>
            <div>
              <strong><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></strong>
              <small><c:out value="${user.email}"/></small>
            </div>
          </div>
          <div class="dd-divider"></div>
          <a href="${pageContext.request.contextPath}/dashboard" class="dropdown-item"><i class="fas fa-th-large"></i> Dashboard</a>
          <a href="${pageContext.request.contextPath}/profile"   class="dropdown-item"><i class="fas fa-user-edit"></i> Edit Profile</a>
          <div class="dd-divider"></div>
          <a href="${pageContext.request.contextPath}/logout"    class="dropdown-item logout-item"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- PAGE BODY -->
  <div class="page-body">

    <div class="page-header">
      <h1><i class="fas fa-user-edit"></i> Edit Profile</h1>
      <p>Keep your information up to date — changes sync to your dashboard instantly.</p>
    </div>

    <div class="edit-grid">

      <!-- FORM CARD -->
      <div class="box">
        <div class="box-header">
          <h2><i class="fas fa-id-card" style="color:var(--g400)"></i> Profile Information</h2>
        </div>

        <form action="${pageContext.request.contextPath}/profile" method="post"
              enctype="multipart/form-data" id="profileForm" novalidate>

          <!-- AVATAR -->
          <div class="avatar-section">
            <div class="avatar-wrap">
              <div class="avatar-display" id="avatarDisplay">
                <c:choose>
                  <c:when test="${hasImage}">
                    <%-- Image served from DB via /profileImage servlet --%>
                    <img src="${pageContext.request.contextPath}/profileImage" alt="Profile" id="avatarImg">
                  </c:when>
                  <c:otherwise>
                    <span><c:out value="${not empty user.firstName ? user.firstName.substring(0,1).toUpperCase() : 'U'}"/></span>
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="avatar-ring"></div>
            </div>
            <div class="avatar-info">
              <strong><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></strong>
              <span class="username-tag">@<c:out value="${user.userName}"/></span><br>
              <label class="change-photo-btn" for="profileImageInput">
                <i class="fas fa-camera"></i> Change Photo
              </label>
              <input type="file" id="profileImageInput" name="profileImage"
                     class="file-input-hidden" accept="image/jpeg,image/png,image/gif,image/webp"
                     onchange="previewImage(this)">
            </div>
          </div>

          <!-- FIELDS -->
          <div class="form-body">

            <div class="form-section-title">Personal Info</div>

            <div class="form-row">
              <div class="field">
                <label for="fnIn">First Name</label>
                <div class="field-wrap">
                  <i class="fas fa-user field-icon"></i>
                  <input type="text" id="fnIn" name="firstName"
                         value="<c:out value='${user.firstName}'/>"
                         placeholder="First name" required maxlength="50">
                </div>
              </div>
              <div class="field">
                <label for="lnIn">Last Name</label>
                <div class="field-wrap">
                  <i class="fas fa-user field-icon"></i>
                  <input type="text" id="lnIn" name="lastName"
                         value="<c:out value='${user.lastName}'/>"
                         placeholder="Last name" required maxlength="50">
                </div>
              </div>
            </div>

            <div class="field">
              <label for="unIn">Username</label>
              <div class="field-wrap">
                <i class="fas fa-at field-icon"></i>
                <input type="text" id="unIn" name="username"
                       value="<c:out value='${user.userName}'/>"
                       placeholder="username" required maxlength="30">
              </div>
            </div>

            <div class="field">
              <label for="emIn">Email Address</label>
              <div class="field-wrap">
                <i class="fas fa-envelope field-icon"></i>
                <input type="email" id="emIn" name="email"
                       value="<c:out value='${user.email}'/>"
                       placeholder="you@example.com" required maxlength="100">
              </div>
            </div>

            <div class="form-row">
              <div class="field">
                <label for="phIn">Phone Number</label>
                <div class="field-wrap">
                  <i class="fas fa-phone field-icon"></i>
                  <input type="tel" id="phIn" name="phone"
                         value="<c:out value='${user.number}'/>"
                         placeholder="+977 98..." maxlength="20">
                </div>
              </div>
              <div class="field">
                <label for="dobIn">Date of Birth</label>
                <div class="field-wrap">
                  <i class="fas fa-birthday-cake field-icon"></i>
                  <input type="date" id="dobIn" name="dob"
                         value="<fmt:formatDate value='${user.dob}' pattern='yyyy-MM-dd'/>">
                </div>
              </div>
            </div>

            <div class="field">
              <label for="genSel">Gender</label>
              <div class="field-wrap">
                <i class="fas fa-venus-mars field-icon"></i>
                <select id="genSel" name="gender">
                  <option value="" disabled <c:if test="${empty user.gender}">selected</c:if>>Select gender</option>
                  <option value="Male"   <c:if test="${user.gender == 'Male'}">selected</c:if>>Male</option>
                  <option value="Female" <c:if test="${user.gender == 'Female'}">selected</c:if>>Female</option>
                  <option value="Other"  <c:if test="${user.gender == 'Other'}">selected</c:if>>Other / Prefer not to say</option>
                </select>
                <i class="fas fa-chevron-down select-arrow"></i>
              </div>
            </div>

            <div class="form-section-title">Security</div>

            <div class="field">
              <label for="pwIn">Password</label>
              <div class="field-wrap">
                <i class="fas fa-lock field-icon"></i>
                <input type="password" id="pwIn" name="password"
                       class="has-toggle"
                       placeholder="Leave blank to keep current password"
                       maxlength="100" autocomplete="new-password">
                <button type="button" class="toggle-pw" onclick="togglePw()">
                  <i class="fas fa-eye" id="pwEye"></i>
                </button>
              </div>
            </div>

            <div class="form-actions">
              <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-save"></i> Save Changes
              </button>
              <a href="${pageContext.request.contextPath}/dashboard" class="btn-cancel">
                <i class="fas fa-arrow-left"></i> Back
              </a>
            </div>

          </div><%-- /form-body --%>
        </form>
      </div><%-- /box --%>

      <!-- RIGHT PANEL -->
      <div class="right-panel">

        <div class="info-card">
          <h4><i class="fas fa-chart-pie"></i> Profile Completion</h4>
          <div class="completion-wrap">
            <div class="completion-label">
              <span>Filled fields</span>
              <span class="completion-pct" id="pctLabel">0%</span>
            </div>
            <div class="completion-track">
              <div class="completion-fill" id="pctFill" style="width:0%"></div>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h4><i class="fas fa-chart-bar"></i> Account Info</h4>
          <div class="info-stat">
            <span>Member Since</span>
            <span>—</span><%-- createdAt not in UserModel; add if needed --%>
          </div>
          <div class="info-stat">
            <span>Status</span>
            <span style="color:var(--g400)"><i class="fas fa-circle" style="font-size:7px"></i> Active</span>
          </div>
          <div class="info-stat">
            <span>Username</span>
            <span>@<c:out value="${user.userName}"/></span>
          </div>
        </div>

        <div class="info-card">
          <h4><i class="fas fa-shield-alt"></i> Profile Tips</h4>
          <div class="tip-list">
            <div class="tip-item"><i class="fas fa-check-circle"></i> Use a clear, recent photo for your avatar.</div>
            <div class="tip-item"><i class="fas fa-check-circle"></i> Keep your phone number current for notifications.</div>
            <div class="tip-item"><i class="fas fa-check-circle"></i> Leave the password field blank to keep your current one.</div>
          </div>
        </div>

      </div><%-- /right-panel --%>

    </div><%-- /edit-grid --%>
  </div><%-- /page-body --%>
</div><%-- /main --%>

<script>
/* ── sidebar ── */
function toggleSidebar(){document.getElementById('sidebar').classList.toggle('open');document.getElementById('sbOverlay').classList.toggle('show')}
function closeSidebar(){document.getElementById('sidebar').classList.remove('open');document.getElementById('sbOverlay').classList.remove('show')}

/* ── dropdown ── */
function toggleDropdown(){document.getElementById('dropdownMenu').classList.toggle('show')}
document.addEventListener('click',function(e){var dd=document.getElementById('userDropdown');if(dd&&!dd.contains(e.target))document.getElementById('dropdownMenu').classList.remove('show')});

/* ── avatar preview (live, before upload) ── */
function previewImage(input){
  if(!input.files||!input.files[0])return;
  var f=input.files[0];
  if(f.size>5*1024*1024){showAlert('Image must be under 5 MB.','error');input.value='';return}
  var r=new FileReader();
  r.onload=function(e){
    var src=e.target.result;
    /* large avatar */
    document.getElementById('avatarDisplay').innerHTML='<img src="'+src+'" alt="Preview" style="width:100%;height:100%;object-fit:cover">';
    /* topbar */
    var ta=document.getElementById('topbarAvatar');
    if(ta)ta.innerHTML='<img src="'+src+'" alt="" style="width:100%;height:100%;object-fit:cover">';
    /* sidebar */
    var sa=document.getElementById('sbAvatar');
    if(sa)sa.innerHTML='<img src="'+src+'" alt="" style="width:100%;height:100%;object-fit:cover">';
  };
  r.readAsDataURL(f);
}

/* ── password toggle ── */
function togglePw(){var i=document.getElementById('pwIn'),e=document.getElementById('pwEye');if(i.type==='password'){i.type='text';e.classList.replace('fa-eye','fa-eye-slash')}else{i.type='password';e.classList.replace('fa-eye-slash','fa-eye')}}

/* ── alerts ── */
function dismissAlert(btn){var a=btn.closest('.alert');a.classList.add('dismissing');setTimeout(function(){a.remove()},300)}
function showAlert(msg,type){
  var s=document.getElementById('alertStack'),d=document.createElement('div');
  d.className='alert alert-'+(type||'success');d.setAttribute('role','alert');
  d.innerHTML='<i class="fas fa-'+(type==='error'?'exclamation-circle':'check-circle')+' alert-icon"></i>'
    +'<span class="alert-body">'+msg+'</span>'
    +'<button class="alert-close" onclick="dismissAlert(this)"><i class="fas fa-times"></i></button>'
    +'<div class="alert-progress"></div>';
  s.appendChild(d);
  setTimeout(function(){if(d.parentNode)dismissAlert(d.querySelector('.alert-close'))},5200);
}
document.querySelectorAll('.alert').forEach(function(el){
  setTimeout(function(){if(el.parentNode)dismissAlert(el.querySelector('.alert-close'))},5200);
});

/* ── profile completion (reads JSTL booleans rendered into JS) ── */
(function(){
  var fields=[
    '${not empty user.firstName}',
    '${not empty user.lastName}',
    '${not empty user.email}',
    '${not empty user.number}',
    '${not empty user.dob}',
    '${not empty user.gender}',
    '${hasImage}'
  ];
  var filled=fields.filter(function(f){return f==='true'}).length;
  var pct=Math.round(filled/fields.length*100);
  setTimeout(function(){
    document.getElementById('pctFill').style.width=pct+'%';
    document.getElementById('pctLabel').textContent=pct+'%';
  },400);
})();

/* ── form submit — loading state ── */
document.getElementById('profileForm').addEventListener('submit',function(){
  var btn=document.getElementById('submitBtn');
  btn.classList.add('loading');
  btn.innerHTML='<i class="fas fa-spinner fa-spin"></i> Saving\u2026';
  /* update topbar name live */
  var fn=document.getElementById('fnIn').value.trim();
  var tn=document.getElementById('topbarName');
  if(tn&&fn)tn.textContent=fn;
});
</script>
</body>
</html>
