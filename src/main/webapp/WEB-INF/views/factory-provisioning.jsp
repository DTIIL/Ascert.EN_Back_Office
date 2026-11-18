<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Factory Provisioning | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/factory-provisioning.css">
    <style>
        .factory-status-filter {
            min-width: 160px;
            height: 40px;
            padding: 0 12px;
            border: 1px solid #d7deea;
            border-radius: 8px;
            background: #ffffff;
            color: #344563;
            font: inherit;
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

            <section class="factory-list-page">

                <!-- Page Header -->
                <header class="factory-list-header">
                    <div>
                        <h1>Factory Provisioning</h1>
                        <p>Track every device from the factory floor to a locked state.</p>
                    </div>
                </header>

                <!-- Search -->
                <div class="factory-toolbar">

                    <input type="search"
                           id="searchInput"
                           class="factory-search"
                           placeholder="Search devices, factories, or stages"
                           aria-label="Search factory provisioning records">

                    <select id="statusFilter"
                            class="factory-status-filter"
                            aria-label="Filter devices by status">
                        <option value="">All Statuses</option>
                        <option value="not paired">Not Paired</option>
                        <option value="paired">Paired</option>
                        <option value="suspended">Suspended</option>
                        <option value="lost">Lost</option>
                    </select>

                </div>

                <!-- Device Table -->
                <div class="factory-table-card">

                    <div class="factory-table-wrapper">

                        <table class="factory-table" id="deviceTable">

                            <thead>
                                <tr>
                                    <th>Device ID</th>
                                    <th>Secure Element ID</th>
                                    <th>Factory ID</th>
                                    <th>Current Stage</th>
                                    <th>Status</th>
                                    <th>Last Updated</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody id="deviceTableBody">

                                <c:forEach var="device" items="${devices}">

                                    <tr class="device-row">

                                        <td>
                                            <span class="device-id">
                                                <c:out value="${device.deviceId}"/>
                                            </span>
                                        </td>

                                        <td>Not available</td>

                                        <td>Not available</td>

                                        <td>
                                            <c:out value="${device.lifecycle}"/>
                                        </td>

                                       <td>
                                           <c:choose>
                                               <c:when test="${device.status eq 'Paired'}">
                                                   <span class="grid-status status-paired">Paired</span>
                                               </c:when>

                                               <c:when test="${device.status eq 'Not Paired'}">
                                                   <span class="grid-status status-not-paired">Not Paired</span>
                                               </c:when>

                                               <c:otherwise>
                                                   <span class="grid-status">
                                                       <c:out value="${device.status}"/>
                                                   </span>
                                               </c:otherwise>
                                           </c:choose>
                                       </td>

                                        <td>
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
                                        </td>

                                        <td>
                                            <a class="view-action"
                                               href="${pageContext.request.contextPath}/factoryprovising/${device.deviceId}">
                                                View
                                            </a>
                                        </td>

                                    </tr>

                                </c:forEach>

                            </tbody>

                        </table>

                        <!-- No Records Message -->
                        <div id="emptyMessage"
                             class="factory-empty"
                             style="display:none;">

                            No devices found.

                        </div>

                    </div>

                    <!-- Pagination -->
                    <div class="factory-pagination">

                        <div class="page-size-control">

                            <label for="pageSize">Page Size:</label>

                            <select id="pageSize">
                                <option value="12" selected>12</option>
                                <option value="24">24</option>
                                <option value="36">36</option>
                            </select>

                        </div>

                        <span id="paginationInfo">0 records</span>

                        <div class="pagination-buttons">

                            <button type="button"
                                    id="firstPage"
                                    title="First page">
                                |&lt;
                            </button>

                            <button type="button"
                                    id="previousPage"
                                    title="Previous page">
                                &lt;
                            </button>

                            <span id="pageNumber">Page 0 of 0</span>

                            <button type="button"
                                    id="nextPage"
                                    title="Next page">
                                &gt;
                            </button>

                            <button type="button"
                                    id="lastPage"
                                    title="Last page">
                                &gt;|
                            </button>

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

// Search and Pagination
(function () {

    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");

    const rows = Array.from(
        document.querySelectorAll(".device-row")
    );

    const pageSizeSelect = document.getElementById("pageSize");

    const firstButton = document.getElementById("firstPage");
    const previousButton = document.getElementById("previousPage");
    const nextButton = document.getElementById("nextPage");
    const lastButton = document.getElementById("lastPage");

    const paginationInfo = document.getElementById("paginationInfo");
    const pageNumber = document.getElementById("pageNumber");

    const emptyMessage = document.getElementById("emptyMessage");

    let currentPage = 1;
    let pageSize = 12;

    let filteredRows = [...rows];

    function renderTable() {

        const totalRecords = filteredRows.length;
        const totalPages = Math.ceil(totalRecords / pageSize);

        if (totalPages === 0) {
            currentPage = 1;
        } else {
            currentPage = Math.max(
                1,
                Math.min(currentPage, totalPages)
            );
        }

        rows.forEach(function(row) {
            row.style.display = "none";
        });

        const startIndex = (currentPage - 1) * pageSize;

        const endIndex = Math.min(
            startIndex + pageSize,
            totalRecords
        );

        filteredRows.slice(startIndex, endIndex).forEach(function(row) {
            row.style.display = "";
        });

        emptyMessage.style.display =
            totalRecords === 0 ? "block" : "none";

        if (totalRecords === 0) {
            paginationInfo.textContent = "0 records";
        } else {
            paginationInfo.textContent =
                (startIndex + 1) + " to " +
                endIndex + " of " +
                totalRecords;
        }

        pageNumber.textContent =
            "Page " +
            (totalPages === 0 ? 0 : currentPage) +
            " of " +
            totalPages;

        firstButton.disabled = currentPage <= 1;
        previousButton.disabled = currentPage <= 1;
        nextButton.disabled = currentPage >= totalPages;
        lastButton.disabled = currentPage >= totalPages;
    }

    // Search and Status Filter
    function filterDevices() {

        const searchValue = searchInput.value.toLowerCase().trim();
        const selectedStatus = statusFilter.value.toLowerCase();

        filteredRows = rows.filter(function(row) {

            const matchesSearch =
                row.innerText.toLowerCase().includes(searchValue);

            const statusCell = row.cells[4];
            const rowStatus = statusCell
                ? statusCell.innerText.trim().toLowerCase()
                : "";

            const matchesStatus =
                selectedStatus === "" || rowStatus === selectedStatus;

            return matchesSearch && matchesStatus;
        });

        currentPage = 1;
        renderTable();
    }

    searchInput.addEventListener("input", filterDevices);
    statusFilter.addEventListener("change", filterDevices);

    // Page size
    pageSizeSelect.addEventListener("change", function() {

        pageSize = Number(this.value);
        currentPage = 1;

        renderTable();
    });

    // First page
    firstButton.addEventListener("click", function() {
        currentPage = 1;
        renderTable();
    });

    // Previous page
    previousButton.addEventListener("click", function() {

        if (currentPage > 1) {
            currentPage--;
            renderTable();
        }
    });

    // Next page
    nextButton.addEventListener("click", function() {

        const totalPages = Math.ceil(
            filteredRows.length / pageSize
        );

        if (currentPage < totalPages) {
            currentPage++;
            renderTable();
        }
    });

    // Last page
    lastButton.addEventListener("click", function() {

        currentPage = Math.ceil(
            filteredRows.length / pageSize
        );

        renderTable();
    });

    // Initial rendering
    renderTable();

})();


document.querySelectorAll(".device-last-updated").forEach(function(element) {

    const rawDate = element.textContent.trim();
    const date = new Date(rawDate);

    if (isNaN(date.getTime())) {
        return;
    }

    element.textContent = new Intl.DateTimeFormat("en-IN", {
        day: "2-digit",
        month: "short",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
        timeZone: "Asia/Kolkata"
    }).format(date);

});

</script>

</body>
</html>