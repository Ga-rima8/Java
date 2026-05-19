<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GHOST ELEMENTS | Adventure Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Adventure.css">
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

    <div class="event-grid" id="mainGrid"></div>
</div>

<script>
    const CTX = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/js/Adventure.js"></script>
</body>
</html>
