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

        /* Date filter styles */
        .factory-date-filter {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .factory-date-filter label {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #344563;
            font-size: 13px;
        }
        .factory-date-filter input[type="date"] {
            width: 148px;
            height: 40px;
            padding: 0 8px;
            border: 1px solid #d7deea;
            border-radius: 8px;
            background: #ffffff;
            color: #344563;
            font: inherit;
            box-sizing: border-box;
        }
        .factory-date-clear {
            height: 40px;
            padding: 0 12px;
            border: 1px solid #d7deea;
            border-radius: 8px;
            background: #ffffff;
            color: #344563;
            cursor: pointer;
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
                           placeholder="Search devices, stages, or statuses"
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

                    <!-- Date Range Filter -->
                    <div class="factory-date-filter">
                        <label>
                            <span>From</span>
                            <input type="date" id="dateFrom" aria-label="Filter from date">
                        </label>
                        <label>
                            <span>To</span>
                            <input type="date" id="dateTo" aria-label="Filter to date">
                        </label>
                        <button type="button" id="clearDates" class="factory-date-clear" hidden>Clear dates</button>
                    </div>

                    <p id="dateRangeError" class="date-range-error" role="alert" hidden>
                        From date cannot be later than To date.
                    </p>

                </div>

                <!-- Device Table -->
                <div class="factory-table-card">

                    <div class="factory-table-wrapper">

                        <table class="factory-table" id="deviceTable">

                            <colgroup>
                                <col class="col-device">
                                <col class="col-secure">
                                <col class="col-factory">
                                <col class="col-stage">
                                <col class="col-status">
                                <col class="col-updated">
                                <col class="col-action">
                            </colgroup>

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

                                        <td class="factory-unavailable">Not available</td>

                                        <td class="factory-unavailable">Not available</td>

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

                                               <c:when test="${device.status eq 'Suspended'}">
                                                   <span class="grid-status status-suspended">Suspended</span>
                                               </c:when>

                                               <c:when test="${device.status eq 'Lost'}">
                                                   <span class="grid-status status-lost">Lost</span>
                                               </c:when>

                                               <c:otherwise>
                                                   <span class="grid-status">
                                                       <c:out value="${device.status}"/>
                                                   </span>
                                               </c:otherwise>
                                           </c:choose>
                                       </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty device.updatedAt}">
                                                    <c:set var="lastUpdated" value="${device.updatedAt}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="lastUpdated" value="${device.createdAt}"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="device-last-updated"
                                                  data-date="${empty lastUpdated ? '' : lastUpdated.toInstant().toEpochMilli()}">
                                                <c:out value="${lastUpdated}" default="—"/>
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
                                <option value="10" selected>10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
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

// Parse a data-date value written as epoch milliseconds.
function parseEpochDate(rawDate) {
    const text = (rawDate || "").trim();
    if (!/^\d+$/.test(text)) return null;
    const date = new Date(Number(text));
    return isNaN(date.getTime()) ? null : date;
}

// Search and Pagination
(function () {

    const searchInput = document.getElementById("searchInput");
    const statusFilter = document.getElementById("statusFilter");
    const dateFromInput = document.getElementById("dateFrom");
    const dateToInput = document.getElementById("dateTo");
    const clearDatesButton = document.getElementById("clearDates");
    const dateRangeError = document.getElementById("dateRangeError");

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
    let pageSize = 10;

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

    // Convert the record timestamp (epoch milliseconds) to YYYY-MM-DD in India time.
    function getIndiaDateKey(rawDate) {
        const date = parseEpochDate(rawDate);
        if (!date) return "";
        const parts = new Intl.DateTimeFormat("en-CA", {
            year: "numeric", month: "2-digit", day: "2-digit",
            timeZone: "Asia/Kolkata"
        }).formatToParts(date);
        const year = parts.find(part => part.type === "year").value;
        const month = parts.find(part => part.type === "month").value;
        const day = parts.find(part => part.type === "day").value;
        return year + "-" + month + "-" + day;
    }

    // Search, Status, and Date Filters
    function filterDevices() {

        const searchValue = searchInput.value.toLowerCase().trim();
        const selectedStatus = statusFilter.value.toLowerCase();
        let fromDate = dateFromInput.value;
        let toDate = dateToInput.value;

        const invalidRange = fromDate !== "" && toDate !== "" && fromDate > toDate;
        dateRangeError.hidden = !invalidRange;

        if (invalidRange) {
            fromDate = "";
            toDate = "";
        }

        filteredRows = rows.filter(function(row) {

            const searchText = Array.from(row.cells)
                .filter(cell => !cell.classList.contains("factory-unavailable"))
                .map(cell => cell.innerText)
                .join(" ")
                .toLowerCase();

            const matchesSearch = searchText.includes(searchValue);

            const statusCell = row.cells[4];
            const rowStatus = statusCell
                ? statusCell.innerText.trim().toLowerCase()
                : "";

            const matchesStatus =
                selectedStatus === "" || rowStatus === selectedStatus;

            const dateElement = row.querySelector(".device-last-updated");
            const rowDate = getIndiaDateKey(dateElement ? dateElement.getAttribute("data-date") : "");
            const matchesFromDate = fromDate === "" || (rowDate !== "" && rowDate >= fromDate);
            const matchesToDate = toDate === "" || (rowDate !== "" && rowDate <= toDate);

            return matchesSearch && matchesStatus && matchesFromDate && matchesToDate;
        });

        currentPage = 1;
        renderTable();
    }

    searchInput.addEventListener("input", filterDevices);
    statusFilter.addEventListener("change", filterDevices);
    dateFromInput.addEventListener("change", filterDevices);
    dateToInput.addEventListener("change", filterDevices);

    function updateClearDatesButton() {
        clearDatesButton.hidden = dateFromInput.value === "" && dateToInput.value === "";
    }

    dateFromInput.addEventListener("change", updateClearDatesButton);
    dateToInput.addEventListener("change", updateClearDatesButton);
    clearDatesButton.addEventListener("click", function() {
        dateFromInput.value = "";
        dateToInput.value = "";
        updateClearDatesButton();
        filterDevices();
    });

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

    const date = parseEpochDate(element.getAttribute("data-date"));

    if (!date) {
        return;
    }

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
