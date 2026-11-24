<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>QDSD Details | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/qdsdmanager.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/qdsdmanager-details.css">
</head>

<body>

<div class="app-shell">

    <!-- Header -->
    <header class="header-container">

        <div class="flex-item-center gap-10">
            <img src="${pageContext.request.contextPath}/assets/Icon_logo.svg"
                 alt="Ascert.en logo"
                 width="32"
                 height="32">

            <div class="heading">
                <span class="brand-title">Ascert.en</span>
                <span class="brand-subtitle">Back Office</span>
            </div>
        </div>

        <div class="user-menu">
            <button type="button"
                    class="user-chip"
                    onclick="toggleUserMenu()">

                <img src="${pageContext.request.contextPath}/assets/person_logo.svg"
                     alt=""
                     width="32"
                     height="32">

                <div class="heading">
                    <span class="user-name"><c:out value="${userName}"/></span>
                    <span class="user-role"><c:out value="${userRole}"/></span>
                </div>
            </button>

           <div class="logout-container" id="logoutMenu" hidden>
               <form action="${pageContext.request.contextPath}/logout"
                     method="post">

                   <input type="hidden"
                          name="${_csrf.parameterName}"
                          value="${_csrf.token}">

                   <button type="submit" class="logout-btn-minimal">
                       Log Out
                   </button>
               </form>
           </div>

    </header>

    <div class="app-body">

        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <!-- Main Content -->
        <main class="app-content">

            <section class="qdsd-details-section">

                <!-- Back Navigation -->
                <a href="${pageContext.request.contextPath}/qdsdmanager"
                   class="details-back-link">
                    &larr; Back to QDSD Manager
                </a>

                <!-- Page Heading -->
                <header class="details-page-heading">
                    <div>
                        <h1>QDSD Details</h1>
                    </div>
                </header>

                <!-- QDSD Summary -->
                <div class="details-summary-card">

                    <div class="details-summary-item">
                        <span>QDSD ID</span>
                        <strong>
                            <c:out value="${qdsdDetails.qdsdId}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>Serial Number</span>
                        <strong>
                            <c:out value="${qdsdDetails.serialNumber}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>Assigned User</span>
                        <strong>
                            <c:out value="${qdsdDetails.assignedUser}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>Organization</span>
                        <strong>
                            <c:out value="${qdsdDetails.organizationName}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>Pairing Status</span>
                        <strong>
                            <c:out value="${qdsdDetails.pairingStatus}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>Download Status</span>
                        <strong>
                            <c:out value="${qdsdDetails.downloadStatus}" default="—"/>
                        </strong>
                    </div>

                    <div class="details-summary-item">
                        <span>QDSD Status</span>
                        <strong>
                            <c:out value="${qdsdDetails.qdsdStatus}" default="—"/>
                        </strong>
                    </div>

                </div>

                <!-- Tabs -->
                <nav class="details-tabs" aria-label="QDSD details sections">

                    <button type="button"
                            class="details-tab"
                            data-tab="overview">
                        Overview
                    </button>

                    <button type="button"
                            class="details-tab active"
                            data-tab="download-history">
                        Download History
                    </button>

                    <button type="button"
                            class="details-tab"
                            data-tab="signing-history">
                        Signing History
                    </button>

                    <button type="button"
                            class="details-tab"
                            data-tab="error-logs">
                        Error Logs
                    </button>

                    <button type="button"
                            class="details-tab"
                            data-tab="activity-history">
                        Activity History
                    </button>

                </nav>

                <!-- Overview Tab -->
                <div id="overview"
                     class="details-tab-content"
                     hidden>

                    <div class="details-content-section">

                        <h2>Basic Information</h2>

                        <div class="details-information-grid">

                            <div class="details-info-item">
                                <span>QDSD ID</span>
                                <strong><c:out value="${qdsdDetails.qdsdId}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Lifecycle</span>
                                <strong><c:out value="${qdsdDetails.lifecycle}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Firmware Version</span>
                                <strong><c:out value="${qdsdDetails.firmwareVersion}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Created Date</span>
                                <strong><c:out value="${qdsdDetails.createdDate}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Updated Date</span>
                                <strong><c:out value="${qdsdDetails.updatedDate}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Created IP</span>
                                <strong><c:out value="${qdsdDetails.createdIp}" default="—"/></strong>
                            </div>

                        </div>

                        <h2>Pairing Information</h2>

                        <div class="details-information-grid">

                            <div class="details-info-item">
                                <span>Pairing Status</span>
                                <strong><c:out value="${qdsdDetails.pairingStatus}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Assigned User</span>
                                <strong><c:out value="${qdsdDetails.assignedUser}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Email</span>
                                <strong><c:out value="${qdsdDetails.emailId}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Mobile Number</span>
                                <strong><c:out value="${qdsdDetails.mobileE164}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Organization</span>
                                <strong><c:out value="${qdsdDetails.organizationName}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Device ID</span>
                                <strong><c:out value="${qdsdDetails.deviceId}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Device Model</span>
                                <strong><c:out value="${qdsdDetails.deviceModel}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Device Version</span>
                                <strong><c:out value="${qdsdDetails.deviceVersion}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>App Version</span>
                                <strong><c:out value="${qdsdDetails.appVersion}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Pairing Requested Date</span>
                                <strong><c:out value="${qdsdDetails.pairingRequestedDate}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Pairing Expiry Date</span>
                                <strong><c:out value="${qdsdDetails.pairingExpiryDate}" default="—"/></strong>
                            </div>

                        </div>

                        <h2>DSC / Download Information</h2>

                        <div class="details-information-grid">

                            <div class="details-info-item">
                                <span>Download Status</span>
                                <strong><c:out value="${qdsdDetails.downloadStatus}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Serial Number</span>
                                <strong><c:out value="${qdsdDetails.serialNumber}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Certificate Type</span>
                                <strong><c:out value="${qdsdDetails.certificateType}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Downloaded Date</span>
                                <strong><c:out value="${qdsdDetails.downloadedDate}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Downloaded OS</span>
                                <strong><c:out value="${qdsdDetails.downloadedOs}" default="—"/></strong>
                            </div>

                        </div>

                        <h2>Certificate Details</h2>

                        <div class="details-information-grid">

                            <div class="details-info-item">
                                <span>Issuer Name</span>
                                <strong><c:out value="${qdsdDetails.issuerName}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Subscriber Name</span>
                                <strong><c:out value="${qdsdDetails.subscriberName}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Valid From</span>
                                <strong><c:out value="${qdsdDetails.validFrom}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Valid To</span>
                                <strong><c:out value="${qdsdDetails.validTo}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Key Slot</span>
                                <strong><c:out value="${qdsdDetails.keySlot}" default="—"/></strong>
                            </div>

                            <div class="details-info-item">
                                <span>Key Generation Sequence</span>
                                <strong><c:out value="${qdsdDetails.keygenSeq}" default="—"/></strong>
                            </div>

                        </div>

                    </div>
                </div>

                <!-- Download History Tab -->
                <div id="download-history"
                     class="details-tab-content">

                    <div class="details-history-section">

                        <div class="details-history-table-container">

                            <table class="details-history-table">

                                <thead>
                                    <tr>
                                        <th>Date &amp; Time</th>
                                        <th>Status</th>
                                        <th>CA Name</th>
                                        <th>Downloaded By</th>
                                        <th>Attempt</th>
                                        <th>Error Details</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:choose>

                                        <c:when test="${not empty downloadHistory}">

                                            <c:forEach var="history"
                                                       items="${downloadHistory}">

                                                <tr>
                                                    <td>
                                                        <c:out value="${history.dateTime}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:set var="statusText" value="${fn:toLowerCase(history.status)}"/>

                                                        <c:choose>
                                                            <c:when test="${fn:contains(statusText, 'fail') or fn:contains(statusText, 'error')}">
                                                                <span class="history-status status-failed">
                                                                    <c:out value="${history.status}" default="—"/>
                                                                </span>
                                                            </c:when>

                                                            <c:when test="${fn:contains(statusText, 'pending') or fn:contains(statusText, 'requested') or fn:contains(statusText, 'declined') or fn:contains(statusText, 'expired')}">
                                                                <span class="history-status status-pending">
                                                                    <c:out value="${history.status}" default="—"/>
                                                                </span>
                                                            </c:when>

                                                            <c:when test="${fn:contains(statusText, 'downloaded') or fn:contains(statusText, 'success') or fn:contains(statusText, 'approved') or fn:contains(statusText, 'installed')}">
                                                                <span class="history-status status-success">
                                                                    <c:out value="${history.status}" default="—"/>
                                                                </span>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <span class="history-status status-neutral">
                                                                    <c:out value="${history.status}" default="—"/>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <td>
                                                        <c:out value="${history.caName}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:out value="${history.downloadedBy}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:out value="${history.attempt}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:out value="${history.errorDetails}" default="—"/>
                                                    </td>
                                                </tr>

                                            </c:forEach>

                                        </c:when>

                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="history-empty">
                                                    No download history available for this QDSD.
                                                </td>
                                            </tr>
                                        </c:otherwise>

                                    </c:choose>

                                </tbody>

                            </table>

                        </div>

                    </div>
                </div>



<!-- Signing History Tab -->
<div id="signing-history"
     class="details-tab-content"
     hidden>

    <div class="details-history-section">
        <div class="details-history-table-container">

            <table class="details-history-table">

                <thead>
                    <tr>
                        <th>Date &amp; Time</th>
                        <th>Document</th>
                        <th>Status</th>
                        <th>Requested By</th>
                        <th>Error Details</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty signingHistory}">

                            <c:forEach var="history" items="${signingHistory}">
                                <tr>
                                    <td>
                                        <c:out value="${history.signedAt}" default="—"/>
                                    </td>
                                    <td>
                                        <c:out value="${history.document}" default="—"/>
                                    </td>
                                    <td>
                                        <c:set var="statusText" value="${fn:toLowerCase(history.status)}"/>

                                        <c:choose>
                                            <c:when test="${fn:contains(statusText, 'fail') or fn:contains(statusText, 'error')}">
                                                <span class="history-status status-failed">
                                                    <c:out value="${history.status}" default="—"/>
                                                </span>
                                            </c:when>

                                            <c:when test="${fn:contains(statusText, 'pending') or fn:contains(statusText, 'requested') or fn:contains(statusText, 'declined') or fn:contains(statusText, 'expired')}">
                                                <span class="history-status status-pending">
                                                    <c:out value="${history.status}" default="—"/>
                                                </span>
                                            </c:when>

                                            <c:when test="${fn:contains(statusText, 'signed') or fn:contains(statusText, 'success') or fn:contains(statusText, 'approved')}">
                                                <span class="history-status status-success">
                                                    <c:out value="${history.status}" default="—"/>
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="history-status status-neutral">
                                                    <c:out value="${history.status}" default="—"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:out value="${history.signedBy}" default="—"/>
                                    </td>
                                    <td>
                                        <c:out value="${history.errorDetails}" default="—"/>
                                    </td>
                                </tr>
                            </c:forEach>

                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="history-empty">
                                    No signing history available for this QDSD.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>

            </table>

        </div>
    </div>
</div>

                <!-- Error Logs Tab -->
                <div id="error-logs"
                     class="details-tab-content"
                     hidden>

                    <div class="details-history-section">

                        <div class="details-history-table-container">

                            <table class="details-history-table">

                                <thead>
                                    <tr>
                                        <th>Date &amp; Time</th>
                                        <th>Status</th>
                                        <th>IP Address</th>
                                        <th>Host Details</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:choose>

                                        <c:when test="${not empty errorLogs}">

                                            <c:forEach var="error"
                                                       items="${errorLogs}">

                                                <tr>
                                                    <td>
                                                        <c:out value="${error.dateTime}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <span class="history-status status-failed">
                                                            <c:out value="${error.status}" default="—"/>
                                                        </span>
                                                    </td>

                                                    <td>
                                                        <c:out value="${error.ipAddress}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:out value="${error.hostDetails}" default="—"/>
                                                    </td>
                                                </tr>

                                            </c:forEach>

                                        </c:when>

                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" class="history-empty">
                                                    No error logs available for this QDSD.
                                                </td>
                                            </tr>
                                        </c:otherwise>

                                    </c:choose>

                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>

                <!-- Activity History Tab -->
                <div id="activity-history"
                     class="details-tab-content"
                     hidden>

                    <div class="details-history-section">

                        <div class="details-history-table-container">

                            <table class="details-history-table">

                                <thead>
                                    <tr>
                                        <th>Date &amp; Time</th>
                                        <th>Activity</th>
                                        <th>IP Address</th>
                                        <th>Host Details</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:choose>

                                        <c:when test="${not empty activityHistory}">

                                            <c:forEach var="activity"
                                                       items="${activityHistory}">

                                                <tr>
                                                    <td>
                                                        <c:out value="${activity.dateTime}" default="—"/>
                                                    </td>

                                                    <td>
                                                       <c:set var="statusText" value="${fn:toLowerCase(activity.activity)}"/>

                                                       <c:choose>
                                                           <c:when test="${fn:contains(statusText, 'fail') or fn:contains(statusText, 'error')}">
                                                               <span class="history-status status-failed">
                                                                   <c:out value="${activity.activity}" default="—"/>
                                                               </span>
                                                           </c:when>

                                                           <c:when test="${fn:contains(statusText, 'pending') or fn:contains(statusText, 'requested') or fn:contains(statusText, 'declined') or fn:contains(statusText, 'expired')}">
                                                               <span class="history-status status-pending">
                                                                   <c:out value="${activity.activity}" default="—"/>
                                                               </span>
                                                           </c:when>

                                                           <c:when test="${fn:contains(statusText, 'paired') or fn:contains(statusText, 'signed') or fn:contains(statusText, 'approved') or fn:contains(statusText, 'installed') or fn:contains(statusText, 'logged in')}">
                                                               <span class="history-status status-success">
                                                                   <c:out value="${activity.activity}" default="—"/>
                                                               </span>
                                                           </c:when>

                                                           <c:otherwise>
                                                               <span class="history-status status-neutral">
                                                                   <c:out value="${activity.activity}" default="—"/>
                                                               </span>
                                                           </c:otherwise>
                                                       </c:choose>
                                                    </td>

                                                    <td>
                                                        <c:out value="${activity.ipAddress}" default="—"/>
                                                    </td>

                                                    <td>
                                                        <c:out value="${activity.hostDetails}" default="—"/>
                                                    </td>
                                                </tr>

                                            </c:forEach>

                                        </c:when>

                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" class="history-empty">
                                                    No activity history available for this QDSD.
                                                </td>
                                            </tr>
                                        </c:otherwise>

                                    </c:choose>

                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>

            </section>

        </main>

    </div>
</div>

<script>

    // User menu
    function toggleUserMenu() {
        const menu = document.getElementById("logoutMenu");
        menu.hidden = !menu.hidden;
    }

    document.addEventListener("click", function(event) {
        const menu = document.getElementById("logoutMenu");
        const userMenu = document.querySelector(".user-menu");

        if (!userMenu.contains(event.target)) {
            menu.hidden = true;
        }
    });

    // QDSD Details tabs
    document.addEventListener("DOMContentLoaded", function() {

        const tabButtons = document.querySelectorAll(".details-tab");
        const tabContents = document.querySelectorAll(".details-tab-content");

        tabButtons.forEach(function(button) {

            button.addEventListener("click", function() {

                const selectedTab = button.dataset.tab;

                // Remove active class from all tabs
                tabButtons.forEach(function(tab) {
                    tab.classList.remove("active");
                });

                // Hide all tab contents
                tabContents.forEach(function(content) {
                    content.hidden = true;
                });

                // Activate selected tab
                button.classList.add("active");

                // Show selected content
                const selectedContent =
                    document.getElementById(selectedTab);

                if (selectedContent) {
                    selectedContent.hidden = false;
                }

            });

        });

    });

</script>

</body>
</html>