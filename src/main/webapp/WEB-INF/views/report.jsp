
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reports | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reports.css">
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
                    <span class="user-name">${userName}</span>
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
        </div>

    </header>

    <div class="app-body">

        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <!-- Main Content -->
        <main class="app-content">

            <section class="reports-section">

                <header class="reports-page-heading">
                    <div>
                        <h1>Reports</h1>
                        <p>View and access reports across the Ascert.EN platform.</p>
                    </div>
                </header>

                <div class="reports-grid">

                    <!-- Provisioning Report -->
                    <a href="${pageContext.request.contextPath}/report/provisioning"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <path d="M4 4h16v16H4z"/>
                                <path d="M8 8h8M8 12h8M8 16h5"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>Provisioning Report</h2>
                            <p>View device provisioning and QDSD status information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                    <!-- QDSD Usage Report -->
                    <a href="${pageContext.request.contextPath}/report/qdsd-usage"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <rect x="5" y="3" width="14" height="18" rx="2"/>
                                <path d="M9 7h6M9 11h6M9 15h3"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>QDSD Usage Report</h2>
                            <p>View QDSD usage and activity information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                    <!-- Device Report -->
                    <a href="${pageContext.request.contextPath}/report/device"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <rect x="7" y="2" width="10" height="20" rx="2"/>
                                <path d="M10 5h4M11 18h2"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>Device Report</h2>
                            <p>View registered device information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                    <!-- Failure Report -->
                    <a href="${pageContext.request.contextPath}/report/failure"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <path d="M12 3 22 20H2L12 3z"/>
                                <path d="M12 9v5M12 17h.01"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>Failure Report</h2>
                            <p>View failure and error information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                    <!-- DSC Download Report -->
                    <a href="${pageContext.request.contextPath}/report/dsc-download"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <path d="M12 3v12M7 10l5 5 5-5"/>
                                <path d="M5 18v3h14v-3"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>DSC Download Report</h2>
                            <p>View DSC download information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                    <!-- Signing Report -->
                    <a href="${pageContext.request.contextPath}/report/signing"
                       class="report-card">

                        <div class="report-card-icon">
                            <svg viewBox="0 0 24 24">
                                <path d="m4 16 4-1 9-9a2.1 2.1 0 0 0-3-3l-9 9-1 4z"/>
                                <path d="M12 4l3 3M4 20h16"/>
                            </svg>
                        </div>

                        <div class="report-card-content">
                            <h2>Signing Report</h2>
                            <p>View document signing information.</p>
                        </div>

                        <span class="report-card-arrow">→</span>
                    </a>

                </div>

            </section>

        </main>

    </div>

</div>

<script>
    function toggleUserMenu() {
        const menu = document.getElementById("logoutMenu");
        menu.hidden = !menu.hidden;
    }
</script>

</body>
</html>
