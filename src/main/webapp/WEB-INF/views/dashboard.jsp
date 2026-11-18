
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Validate user session before displaying dashboard --%>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <script src="${pageContext.request.contextPath}/js/chart.umd.min.js"></script>
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

            <section class="dashboard-section">

                <header class="page-head">

                    <div>
                        <h1>Dashboard</h1>

                        <p>
                            Welcome back,
                            <c:out value="${userName}"/>.
                            Here is what needs attention today.
                        </p>
                    </div>

                </header>

                <!-- Subscriber Statistics -->
                <div class="stats">

                    <article class="stat">
                        <div class="label">
                            <span class="dot blue"></span>
                            Total users
                        </div>

                        <b><c:out value="${dashboardData.totalUsers}"/></b>

                        <p class="stat-hint">
                            Every account on the platform
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot green"></span>
                            Active users
                        </div>

                        <b><c:out value="${dashboardData.activeUsers}"/></b>

                        <p class="stat-hint">
                            Accounts currently active
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot orange"></span>
                            Inactive users
                        </div>

                        <b><c:out value="${dashboardData.inactiveUsers}"/></b>

                        <p class="stat-hint">
                            Accounts currently inactive
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot red"></span>
                            Pending users
                        </div>

                        <b><c:out value="${dashboardData.pendingUsers}"/></b>

                        <p class="stat-hint">
                            Waiting for approval
                        </p>
                    </article>

                </div>

                <!-- Charts -->
                <div class="chart-grid">

                    <article class="chart-card">
                        <h2>QDSD activity</h2>

                        <div class="chart-canvas">
                            <canvas id="activityChart"></canvas>
                        </div>
                    </article>

                    <article class="chart-card">
                        <h2>Signatures</h2>

                        <div class="chart-canvas">
                            <canvas id="signatureChart"></canvas>
                        </div>
                    </article>

                    <article class="chart-card">
                        <h2>Failures</h2>

                        <div class="chart-canvas">
                            <canvas id="failureChart"></canvas>
                        </div>
                    </article>

                </div>

                <!-- QDSD Pipeline -->
                <h2 class="section-label">QDSD pipeline</h2>

                <div class="stats">

                    <article class="stat">
                        <div class="label">
                            <span class="dot blue"></span>
                            Paired QDSD
                        </div>

                        <b><c:out value="${dashboardData.pairedQdsd}"/></b>

                        <p class="stat-hint">
                            Devices linked to a user
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot green"></span>
                            Waiting for DSC
                        </div>

                        <b><c:out value="${dashboardData.waitingForDsc}"/></b>

                        <p class="stat-hint">
                            Certificate still pending
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot orange"></span>
                            Download failed
                        </div>

                        <b><c:out value="${dashboardData.downloadFailed}"/></b>

                        <p class="stat-hint">
                            Needs a retry or support
                        </p>
                    </article>

                    <article class="stat">
                        <div class="label">
                            <span class="dot red"></span>
                            Ready
                        </div>

                        <b><c:out value="${dashboardData.ready}"/></b>

                        <p class="stat-hint">
                            Available for signing
                        </p>
                    </article>

                </div>

            </section>

        </main>

    </div>

</div>

<!-- Chart Data from Spring Boot -->
<div id="chartData"
     data-labels="<c:out value='${dashboardData.chartLabels}'/>"
     data-activity="<c:out value='${dashboardData.qdsdActivity}'/>"
     data-signatures="<c:out value='${dashboardData.signatures}'/>"
     data-failures="<c:out value='${dashboardData.failures}'/>">
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

    // Close user menu when pressing Escape
    document.addEventListener("keydown", function(event) {

        if (event.key === "Escape") {

            const menu = document.getElementById("logoutMenu");
            const button = document.querySelector(".user-chip");

            menu.hidden = true;

            button.setAttribute("aria-expanded", "false");
        }

    });

    // Read chart data from backend
    const chartData = document.getElementById("chartData");

    function parseList(value, convertToNumber = false) {

        if (!value || value.trim() === "" || value.trim() === "[]") {
            return [];
        }

        const result = value
            .replace(/^\[|\]$/g, "")
            .split(",")
            .map(item => item.trim());

        return convertToNumber
            ? result.map(Number)
            : result;
    }

    const labels = parseList(chartData.dataset.labels);

    const activity = parseList(
        chartData.dataset.activity,
        true
    );

    const signatures = parseList(
        chartData.dataset.signatures,
        true
    );

    const failures = parseList(
        chartData.dataset.failures,
        true
    );

    // Common bar chart configuration
    function createBarChart(canvasId, label, values, color) {

        const canvas = document.getElementById(canvasId);

        if (!canvas || typeof Chart === "undefined") {

            console.error(
                "Chart.js or chart canvas is unavailable:",
                canvasId
            );

            return;
        }

        if (labels.length === 0 || values.length === 0) {
            return;
        }

        // Validate chart data lengths
        if (labels.length !== values.length) {

            console.error(
                "Chart labels and values have different lengths:",
                canvasId
            );

            return;
        }

        new Chart(canvas, {

            type: "bar",

            data: {

                labels: labels,

                datasets: [{

                    label: label,
                    data: values,
                    backgroundColor: color,
                    borderRadius: 5,
                    barThickness: 18

                }]

            },

            options: {

                responsive: true,
                maintainAspectRatio: false,

                plugins: {

                    legend: {
                        display: false
                    }

                },

                scales: {

                    y: {

                        beginAtZero: true,

                        ticks: {
                            precision: 0
                        }

                    }

                }

            }

        });

    }

    // Create dashboard charts
    createBarChart(
        "activityChart",
        "QDSD activity",
        activity,
        "#0860E8"
    );

    createBarChart(
        "signatureChart",
        "Signatures",
        signatures,
        "#EFA337"
    );

    createBarChart(
        "failureChart",
        "Failures",
        failures,
        "#BD251B"
    );

</script>

</body>
</html>
