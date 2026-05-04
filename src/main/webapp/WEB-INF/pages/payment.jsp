<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payments | Hangaura</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
</head>
<body>
<div class="layout">
    <% request.setAttribute("currentPage", "payment"); %>
    <jsp:include page="sidebar.jsp" />

    <div class="main">
        <div class="topbar">
            <div class="page-title">Payment History</div>
            <div class="admin-tag">Admin</div>
        </div>

        <div class="content">

            <!-- SUMMARY CARDS -->
            <div class="cards">
                <div class="card">
                    <div class="card-top">Total Earnings</div>
                    <div class="card-num">Rs. ${totalEarnings}</div>
                    <div class="card-sub">All payments</div>
                </div>
                <div class="card">
                    <div class="card-top">Transactions</div>
                    <div class="card-num">${totalTransactions}</div>
                    <div class="card-sub">Total count</div>
                </div>
                <div class="card">
                    <div class="card-top">Total Refunds</div>
                    <div class="card-num" style="color:#b91c1c;">Rs. ${totalRefunds}</div>
                    <div class="card-sub">${refundCount} refunds</div>
                </div>
                <div class="card">
                    <div class="card-top">Net Revenue</div>
                    <div class="card-num" style="color:#2d6a4f;">Rs. ${netRevenue}</div>
                    <div class="card-sub">After refunds</div>
                </div>
            </div>

            <!-- PAYMENT TABLE -->
            <div class="box">
                <div class="box-title">All Transactions</div>
                <div class="search-row">
                    <input type="text" id="pSearch" placeholder="Search transactions..." onkeyup="ft('pSearch','pTable')" />
                    <select onchange="filterType(this)">
                        <option value="">All Types</option>
                        <option>Payment</option>
                        <option>Refund</option>
                    </select>
                </div>
                <table id="pTable">
                    <thead>
                        <tr><th>#</th><th>User</th><th>Event</th><th>Amount</th><th>Date</th><th>Method</th><th>Type</th></tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty payments}">
                                <c:forEach var="p" items="${payments}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${p.userName}</td>
                                    <td>${p.eventName}</td>
                                    <td>Rs. ${p.amount}</td>
                                    <td>${p.paymentDate}</td>
                                    <td>${p.method}</td>
                                    <td>
                                        <span class="tag ${p.type == 'Payment' ? 'green' : 'red'}">
                                            ${p.type}
                                        </span>
                                    </td>
                                </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="7" style="text-align:center; color:#5a7a65; padding:20px;">No payment records yet.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<script>
    function ft(i,t){
        const v=document.getElementById(i).value.toLowerCase();
        document.querySelectorAll('#'+t+' tbody tr').forEach(r=>{
            r.style.display=r.textContent.toLowerCase().includes(v)?'':'none';
        });
    }
    function filterType(sel){
        const v=sel.value.toLowerCase();
        document.querySelectorAll('#pTable tbody tr').forEach(r=>{
            r.style.display=v===''||r.textContent.toLowerCase().includes(v)?'':'none';
        });
    }
</script>
</body>
</html>