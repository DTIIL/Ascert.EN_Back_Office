
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Factory Provisioning Details | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/factory-provisioning.css">
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

        <!-- User Menu -->
        <div class="user-menu">

            <button type="button"
                    class="user-chip"
                    aria-expanded="false"
                    aria-controls="logoutMenu"
                    onclick="toggleUserMenu()">

                <img src="${pageContext.request.contextPath}/assets/person_logo.svg"
                     alt=""
                     width="32"
                     height="32">

                <div class="heading">
                    <span class="user-name">
                        <c:out value="${userName}"/>
                    </span>

                    <span class="user-role">
                        <c:out value="${userRole}"/>
                    </span>
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

        </div>

    </header>

    <div class="app-body">

        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <!-- Main Content -->
        <main class="app-content">

            <section class="factory-details-page">

                <!-- Page Header -->
                <div class="detail-header-section">

                    <a href="${pageContext.request.contextPath}/factoryprovising"
                       class="back-to-dashboard">
                        ← Back to provisioning
                    </a>

                    <span>
                        Last update:
                        <span class="device-last-updated">
                            <c:choose>
                                <c:when test="${not empty device.updatedAt}">
                                    <c:out value="${device.updatedAt}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${device.createdAt}"/>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </span>

                </div>

                <div class="factory-page-title">
                    <h1>Factory Provisioning Details</h1>
                </div>

                <!-- Summary Card -->
                <div class="summary-card">

                    <div class="summary-details">

                        <div class="summary-content">
                            <span>Device ID</span>
                            <span class="body-span">
                                <c:out value="${device.deviceId}"/>
                            </span>
                        </div>

                        <div class="summary-content">
                            <span>Secure Element ID</span>
                            <span class="body-span">
                                <c:out value="${device.deviceId}"/>
                            </span>
                        </div>

                        <div class="summary-content">
                            <span>Factory ID</span>
                            <span class="body-span">Not available</span>
                        </div>

                        <div class="summary-content">
                            <span>Current Stage</span>
                            <span class="body-span">
                                <c:out value="${device.lifecycle}"/>
                            </span>
                        </div>

                        <div class="summary-content">
                            <span>Provisioning Status</span>
                            <span class="grid-status">
                                <c:out value="${device.status}"/>
                            </span>
                        </div>

                    </div>

                </div>

                <!-- Device Information and Key Details -->
                <div class="device-overview-grid">

                    <section class="detail-section">

                        <div class="detail-section-header">
                            Device Information
                        </div>

                        <div class="device-info-content">

                            <div class="device-info-item">
                                <span class="info-label">Device ID</span>
                                <span class="info-value">
                                    <c:out value="${device.deviceId}"/>
                                </span>
                            </div>

                            <div class="device-info-item">
                                <span class="info-label">Factory ID</span>
                                <span class="info-value">Not available</span>
                            </div>

                            <div class="device-info-item">
                                <span class="info-label">Serial Number</span>
                                <span class="info-value">Not available</span>
                            </div>

                            <div class="device-info-item">
                                <span class="info-label">Secure Element ID</span>
                                <span class="info-value">
                                    <c:out value="${device.deviceId}"/>
                                </span>
                            </div>

                            <div class="device-info-item">
                                <span class="info-label">Device State</span>
                                <span class="info-value">
                                    <c:out value="${device.lifecycle}"/>
                                </span>
                            </div>

                            <div class="device-info-item">
                                <span class="info-label">Firmware Version</span>
                                <span class="info-value">
                                    <c:out value="${device.firmwareVersion}"
                                           default="Not available"/>
                                </span>
                            </div>

                        </div>

                    </section>

                    <section class="detail-section">

                        <div class="detail-section-header">
                            Key Details
                        </div>

                        <div class="key-details-content">

                            <div class="key-details-item">
                                <span class="info-label">Device Public Key</span>
                                <span class="info-value key-value">
                                    <c:choose>
                                        <c:when test="${not empty device.publicKey}">
                                            Available
                                        </c:when>
                                        <c:otherwise>Not available</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="key-details-item">
                                <span class="info-label">QC Data</span>
                                <span class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty device.qcData}">
                                            Available
                                        </c:when>
                                        <c:otherwise>Not available</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="key-details-item">
                                <span class="info-label">Binding Number</span>
                                <span class="info-value">
                                    <c:out value="${device.bindingNo}"/>
                                </span>
                            </div>

                            <div class="key-details-item">
                                <span class="info-label">Counter</span>
                                <span class="info-value">
                                    <c:out value="${device.signCounter}"/>
                                </span>
                            </div>

                            <div class="key-details-item">
                                <span class="info-label">Keygen Counter</span>
                                <span class="info-value">
                                    <c:out value="${device.keygenCounter}"/>
                                </span>
                            </div>

                        </div>

                    </section>

                </div>

                <!-- Provisioning Stages -->
                <section class="detail-section table-section">

                    <div class="detail-section-header">
                        Provisioning Stages
                    </div>

                    <div class="unavailable-message">
                        Manufacturing stage history is not available in the current database.
                    </div>

                </section>

                <!-- Provisioning Events -->
                <section class="detail-section table-section">

                    <div class="detail-section-header">
                        Provisioning Events
                    </div>

                    <div class="unavailable-message">
                        Manufacturing event history is not available in the current database.
                    </div>

                </section>

                <!-- Device Key Information -->
                <section class="detail-section table-section">

                    <div class="detail-section-header">
                        Device Key Information
                    </div>

                    <div class="key-data-content">

                        <div class="key-data-item">
                            <span class="info-label">Public Key</span>
                            <pre><c:out value="${device.publicKey}"
                                       default="Not available"/></pre>
                        </div>

                        <div class="key-data-item">
                            <span class="info-label">Vendor Attestation</span>
                            <pre><c:out value="${device.vendorAttestation}"
                                       default="Not available"/></pre>
                        </div>

                        <div class="key-data-item">
                            <span class="info-label">QC Data</span>
                            <pre><c:out value="${device.qcData}"
                                       default="Not available"/></pre>
                        </div>

                    </div>

                </section>

            </section>

        </main>

    </div>

</div>

<script>

// User menu
function toggleUserMenu() {

    const menu = document.getElementById("logoutMenu");
    const button = document.querySelector(".user-chip");

    menu.hidden = !menu.hidden;

    button.setAttribute("aria-expanded", String(!menu.hidden));
}

// Close user menu when clicking outside
document.addEventListener("click", function(event) {

    const menu = document.getElementById("logoutMenu");
    const userMenu = document.querySelector(".user-menu");
    const button = document.querySelector(".user-chip");

    if (!userMenu.contains(event.target)) {

        menu.hidden = true;

        button.setAttribute("aria-expanded", "false");
    }

});

// Close user menu with Escape
document.addEventListener("keydown", function(event) {

    if (event.key === "Escape") {

        const menu = document.getElementById("logoutMenu");
        const button = document.querySelector(".user-chip");

        menu.hidden = true;

        button.setAttribute("aria-expanded", "false");
    }

});


document.querySelectorAll(".device-last-updated").forEach(function(element) {

    const rawDate = element.textContent.trim();
    const date = new Date(rawDate);

    if (isNaN(date.getTime())) return;

    element.textContent = formatIndiaDateTime(date);

});

// Same display format as server-formatted dates: "24 Nov 2026, 03:03 PM" (India time).
function formatIndiaDateTime(date) {
    const parts = {};

    new Intl.DateTimeFormat("en-US", {
        day: "2-digit",
        month: "short",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
        timeZone: "Asia/Kolkata"
    }).formatToParts(date).forEach(function(part) {
        parts[part.type] = part.value;
    });

    return parts.day + " " + parts.month + " " + parts.year + ", "
        + parts.hour + ":" + parts.minute + " " + (parts.dayPeriod || "").toUpperCase();
}

</script>

</body>
</html>
