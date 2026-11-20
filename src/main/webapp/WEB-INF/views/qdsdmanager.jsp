<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>QDSD Manager | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/qdsdmanager.css">

    <style>
        .multi-filter-dropdown {
            position: relative;
            min-width: 180px;
        }

        .multi-filter-button {
            cursor: pointer;
            padding: 10px 14px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            background: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            list-style: none;
        }

        .multi-filter-button::-webkit-details-marker {
            display: none;
        }

        .multi-filter-menu {
            position: absolute;
            top: calc(100% + 5px);
            left: 0;
            width: 230px;
            max-height: 350px;
            overflow-y: auto;
            background: white;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 12px;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 9px;
        }

        .filter-group strong {
            margin-bottom: 4px;
        }

        .filter-group label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .filter-group input[type="radio"] {
            cursor: pointer;
        }

        .filter-divider {
            border-top: 1px solid #e5e7eb;
            margin: 12px 0;
        }
    </style>
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

            <section class="qdsd-section">

                <!-- Page Heading -->
                <header class="page-head">
                    <div>
                        <h1>QDSD Manager</h1>
                        <p>View and manage every qualified digital signing device.</p>
                    </div>
                </header>

                <!-- Search and Filter -->
                <form class="qdsd-toolbar"
                      action="${pageContext.request.contextPath}/qdsdmanager"
                      method="get">

                    <!-- Search -->
                    <div class="qdsd-search">

                        <svg viewBox="0 0 24 24" aria-hidden="true">
                            <circle cx="10.8" cy="10.8" r="6.8"/>
                            <path d="m16 16 5 5"/>
                        </svg>

                        <input type="search"
                               name="search"
                               value="<c:out value='${searchTerm}'/>"
                               placeholder="Search by ID, user, or organization"
                               aria-label="Search QDSD records">
                    </div>

                    <!-- Status Filter -->
                    <div class="qdsd-filter">

                        <details class="multi-filter-dropdown">

                            <summary class="multi-filter-button">
                                Filter by status
                                <span>&#9662;</span>
                            </summary>

                            <div class="multi-filter-menu">

                                <!-- Pairing Status -->
                                <div class="filter-group">

                                    <strong>Pairing status</strong>

                                    <label>
                                        <input type="radio"
                                               name="pairingStatus"
                                               value=""
                                               ${empty selectedPairingStatus ? 'checked' : ''}>
                                        All
                                    </label>

                                    <c:forEach var="option" items="${pairingStatusOptions}">
                                        <label>
                                            <input type="radio"
                                                   name="pairingStatus"
                                                   value="<c:out value='${option}'/>"
                                                   ${selectedPairingStatus eq option ? 'checked' : ''}>
                                            <c:out value="${option}"/>
                                        </label>
                                    </c:forEach>

                                </div>

                                <div class="filter-divider"></div>

                                <!-- Download Status -->
                                <div class="filter-group">

                                    <strong>Download status</strong>

                                    <label>
                                        <input type="radio"
                                               name="downloadStatus"
                                               value=""
                                               ${empty selectedDownloadStatus ? 'checked' : ''}>
                                        All
                                    </label>

                                    <c:forEach var="option" items="${downloadStatusOptions}">
                                        <label>
                                            <input type="radio"
                                                   name="downloadStatus"
                                                   value="<c:out value='${option}'/>"
                                                   ${selectedDownloadStatus eq option ? 'checked' : ''}>
                                            <c:out value="${option}"/>
                                        </label>
                                    </c:forEach>

                                </div>

                                <div class="filter-divider"></div>

                                <!-- QDSD Status -->
                                <div class="filter-group">

                                    <strong>QDSD status</strong>

                                    <label>
                                        <input type="radio"
                                               name="qdsdStatus"
                                               value=""
                                               ${empty selectedQdsdStatus ? 'checked' : ''}>
                                        All
                                    </label>

                                    <c:forEach var="option" items="${qdsdStatusOptions}">
                                        <label>
                                            <input type="radio"
                                                   name="qdsdStatus"
                                                   value="<c:out value='${option}'/>"
                                                   ${selectedQdsdStatus eq option ? 'checked' : ''}>
                                            <c:out value="${option}"/>
                                        </label>
                                    </c:forEach>

                                </div>

                            </div>
                        </details>

                    </div>

                    <!-- Date Range Filter -->
                    <div class="qdsd-date-filter">
                        <label class="qdsd-date-field">
                            <span>From Date</span>
                            <input type="date" name="fromDate" class="qdsd-date-input" value="<c:out value='${fromDate}'/>" aria-label="Filter from date">
                        </label>
                        <label class="qdsd-date-field">
                            <span>To Date</span>
                            <input type="date" name="toDate" class="qdsd-date-input" value="<c:out value='${toDate}'/>" aria-label="Filter to date">
                        </label>
                        <button type="button" class="qdsd-date-clear" id="clearQdsdDates">Clear Dates</button>
                    </div>

                    <button type="submit" class="qdsd-filter-button">
                        Apply
                    </button>

                    <a href="${pageContext.request.contextPath}/qdsdmanager"
                       class="qdsd-reset-button">
                        Reset
                    </a>

                </form>

                <!-- Validation Messages -->
                <c:if test="${not empty dateError}">
                    <p class="qdsd-validation-message" role="alert">
                        <c:out value="${dateError}"/>
                    </p>
                </c:if>

                <c:if test="${param.error eq 'notFound'}">
                    <p class="qdsd-validation-message" role="alert">
                        The requested QDSD record was not found.
                    </p>
                </c:if>

                <!-- QDSD Table -->
                <div class="qdsd-table-card">

                    <div class="qdsd-table-heading">
                        <div>
                            <h2>Qualified Digital Signing Devices</h2>
                            <p>
                                <c:out value="${totalRecords}"/> devices found
                            </p>
                        </div>
                    </div>

                    <div class="qdsd-table-scroll">

                        <table class="qdsd-table">

                            <thead>
                                <tr>
                                    <th>QDSD ID</th>
                                    <th>Serial Number</th>
                                    <th>Assigned User</th>
                                    <th>Organization</th>
                                    <th>Pairing</th>
                                    <th>Download</th>
                                    <th>QDSD Status</th>
                                    <th>Last Used</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:choose>

                                    <c:when test="${not empty qdsdList}">

                                        <c:forEach var="qdsd" items="${qdsdList}">

                                            <tr>

                                                <td class="qdsd-id">
                                                    <c:out value="${qdsd.qdsdId}"/>
                                                </td>

                                                <td>
                                                    <c:out value="${qdsd.serialNumber}"
                                                           default="—"/>
                                                </td>

                                                <td>
                                                    <c:out value="${qdsd.assignedUser}"
                                                           default="—"/>
                                                </td>

                                                <td>
                                                    <c:out value="${qdsd.organization}"
                                                           default="—"/>
                                                </td>

                                                <td>
                                                    <span class="status-pill"
                                                          data-status="<c:out value='${qdsd.pairingStatus}'/>">
                                                        <c:out value="${qdsd.pairingStatus}"
                                                               default="—"/>
                                                    </span>
                                                </td>

                                                <td>
                                                    <span class="status-pill"
                                                          data-status="<c:out value='${qdsd.downloadStatus}'/>">
                                                        <c:out value="${qdsd.downloadStatus}"
                                                               default="—"/>
                                                    </span>
                                                </td>

                                                <td>
                                                    <span class="status-pill"
                                                          data-status="<c:out value='${qdsd.qdsdStatus}'/>">
                                                        <c:out value="${qdsd.qdsdStatus}"
                                                               default="—"/>
                                                    </span>
                                                </td>

                                                <td>
                                                    <c:out value="${qdsd.lastUsed}"
                                                           default="—"/>
                                                </td>

                                                <td>
                                                    <a class="qdsd-view-link"
                                                       href="${pageContext.request.contextPath}/qdsdmanager/details/${qdsd.id}">
                                                        View
                                                    </a>
                                                </td>

                                            </tr>

                                        </c:forEach>

                                    </c:when>

                                    <c:otherwise>

                                        <tr>
                                            <td colspan="9" class="qdsd-empty">
                                                No QDSD records found.
                                            </td>
                                        </tr>

                                    </c:otherwise>

                                </c:choose>

                            </tbody>

                        </table>

                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 0}">
                        <div class="qdsd-pagination">

                            <span class="qdsd-pagination-info">
                                <c:choose>
                                    <c:when test="${totalRecords > 0}">
                                        <c:out value="${(currentPage - 1) * pageSize + 1}"/> to
                                        <c:out value="${currentPage * pageSize > totalRecords ? totalRecords : currentPage * pageSize}"/> of
                                        <c:out value="${totalRecords}"/>
                                    </c:when>
                                    <c:otherwise>0 to 0 of 0</c:otherwise>
                                </c:choose>
                            </span>

                            <div class="qdsd-pagination-actions">

                                <c:url var="firstPageUrl" value="/qdsdmanager">
                                    <c:param name="page" value="1"/>
                                    <c:param name="search" value="${searchTerm}"/>
                                    <c:if test="${not empty fromDate}">
                                        <c:param name="fromDate" value="${fromDate}"/>
                                    </c:if>
                                    <c:if test="${not empty toDate}">
                                        <c:param name="toDate" value="${toDate}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedPairingStatus}">
                                        <c:param name="pairingStatus" value="${selectedPairingStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedDownloadStatus}">
                                        <c:param name="downloadStatus" value="${selectedDownloadStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedQdsdStatus}">
                                        <c:param name="qdsdStatus" value="${selectedQdsdStatus}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${currentPage <= 1}">
                                        <span class="pagination-link disabled" aria-disabled="true"
                                              aria-label="First page" title="First page">|&lt;</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="pagination-link"
                                           href="${firstPageUrl}" aria-label="First page" title="First page">|&lt;</a>
                                    </c:otherwise>
                                </c:choose>

                                <c:url var="previousUrl" value="/qdsdmanager">
                                    <c:param name="page" value="${currentPage > 1 ? currentPage - 1 : 1}"/>
                                    <c:param name="search" value="${searchTerm}"/>
                                    <c:if test="${not empty fromDate}">
                                        <c:param name="fromDate" value="${fromDate}"/>
                                    </c:if>
                                    <c:if test="${not empty toDate}">
                                        <c:param name="toDate" value="${toDate}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedPairingStatus}">
                                        <c:param name="pairingStatus" value="${selectedPairingStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedDownloadStatus}">
                                        <c:param name="downloadStatus" value="${selectedDownloadStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedQdsdStatus}">
                                        <c:param name="qdsdStatus" value="${selectedQdsdStatus}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${currentPage <= 1}">
                                        <span class="pagination-link disabled" aria-disabled="true"
                                              aria-label="Previous page" title="Previous page">&lt;</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="pagination-link"
                                           href="${previousUrl}" aria-label="Previous page" title="Previous page">&lt;</a>
                                    </c:otherwise>
                                </c:choose>

                                <span class="qdsd-current-page">
                                    Page <c:out value="${currentPage}"/> of <c:out value="${totalPages}"/>
                                </span>

                                <c:url var="nextUrl" value="/qdsdmanager">
                                    <c:param name="page" value="${currentPage < totalPages ? currentPage + 1 : totalPages}"/>
                                    <c:param name="search" value="${searchTerm}"/>
                                    <c:if test="${not empty fromDate}">
                                        <c:param name="fromDate" value="${fromDate}"/>
                                    </c:if>
                                    <c:if test="${not empty toDate}">
                                        <c:param name="toDate" value="${toDate}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedPairingStatus}">
                                        <c:param name="pairingStatus" value="${selectedPairingStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedDownloadStatus}">
                                        <c:param name="downloadStatus" value="${selectedDownloadStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedQdsdStatus}">
                                        <c:param name="qdsdStatus" value="${selectedQdsdStatus}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${currentPage >= totalPages}">
                                        <span class="pagination-link disabled" aria-disabled="true"
                                              aria-label="Next page" title="Next page">&gt;</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="pagination-link"
                                           href="${nextUrl}" aria-label="Next page" title="Next page">&gt;</a>
                                    </c:otherwise>
                                </c:choose>

                                <c:url var="lastPageUrl" value="/qdsdmanager">
                                    <c:param name="page" value="${totalPages}"/>
                                    <c:param name="search" value="${searchTerm}"/>
                                    <c:if test="${not empty fromDate}">
                                        <c:param name="fromDate" value="${fromDate}"/>
                                    </c:if>
                                    <c:if test="${not empty toDate}">
                                        <c:param name="toDate" value="${toDate}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedPairingStatus}">
                                        <c:param name="pairingStatus" value="${selectedPairingStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedDownloadStatus}">
                                        <c:param name="downloadStatus" value="${selectedDownloadStatus}"/>
                                    </c:if>
                                    <c:if test="${not empty selectedQdsdStatus}">
                                        <c:param name="qdsdStatus" value="${selectedQdsdStatus}"/>
                                    </c:if>
                                </c:url>
                                <c:choose>
                                    <c:when test="${currentPage >= totalPages}">
                                        <span class="pagination-link disabled" aria-disabled="true"
                                              aria-label="Last page" title="Last page">&gt;|</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="pagination-link"
                                           href="${lastPageUrl}" aria-label="Last page" title="Last page">&gt;|</a>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </c:if>

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

    // Close user menu when clicking outside
    document.addEventListener("click", function(event) {

        const menu = document.getElementById("logoutMenu");
        const userMenu = document.querySelector(".user-menu");

        if (!userMenu.contains(event.target)) {
            menu.hidden = true;
        }

    });

    document.getElementById("clearQdsdDates").addEventListener("click", function() {
        const form = this.closest("form");
        form.querySelector('[name="fromDate"]').value = "";
        form.querySelector('[name="toDate"]').value = "";
        form.submit();
    });

</script>

</body>
</html>