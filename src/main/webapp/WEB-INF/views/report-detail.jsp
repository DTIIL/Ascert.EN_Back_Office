<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title><c:out value="${reportTitle}"/> | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reports.css">

    <style>
        .report-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
            background: #e8f5ed;
            color: #168044;
        }

        .report-status.warning {
            background: #fff4df;
            color: #a66b00;
        }

        .report-status.danger {
            background: #fdeaea;
            color: #c0392b;
        }

        .report-status.neutral {
            background: #eef0f3;
            color: #596579;
        }

        .report-data-table th[data-sortable="true"] {
            cursor: pointer;
            user-select: none;
            white-space: nowrap;
        }

        .report-data-table th[data-sortable="true"]:hover {
            background: #edf2fa;
        }

        .sort-indicator {
            margin-left: 5px;
            color: #64748b;
            font-size: 11px;
        }

        .report-filters select {
            min-width: 150px;
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
                    <span class="user-name"><c:out value="${userName}"/></span>
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

            <section class="reports-section">

                <!-- Breadcrumb -->
                <nav class="report-breadcrumb" aria-label="Breadcrumb">

                    <a href="${pageContext.request.contextPath}/report">
                        Reports
                    </a>

                    <span>/</span>

                    <span><c:out value="${reportTitle}"/></span>

                </nav>

                <!-- Page Heading -->
                <header class="reports-page-heading">
                    <div>
                        <h1><c:out value="${reportTitle}"/></h1>
                        <p><c:out value="${reportDescription}"/></p>
                    </div>

                    <span class="report-record-count">
                        Total records:
                        <strong id="totalRecords">
                            <c:out value="${reportRows.size()}"/>
                        </strong>
                    </span>
                </header>

                <!-- Search and Filters -->
                <div class="report-toolbar">

                    <div class="report-filters">

                        <input type="search"
                               id="reportSearch"
                               class="report-search"
                               placeholder="Search report records..."
                               aria-label="Search report records">

                        <!-- Provisioning filter -->
                        <c:if test="${reportType == 'provisioning'}">

                            <select id="statusFilter"
                                    class="report-status-filter"
                                    aria-label="Filter by status">

                                <option value="">All Statuses</option>
                                <option value="not paired">Not Paired</option>
                                <option value="paired">Paired</option>
                                <option value="suspended">Suspended</option>
                                <option value="lost">Lost</option>

                            </select>

                        </c:if>

                        <!-- QDSD Usage filter -->
                        <c:if test="${reportType == 'usage'}">

                            <select id="actionFilter"
                                    class="report-status-filter"
                                    aria-label="Filter by action">

                                <option value="">All Actions</option>

                                <option value="__dynamic__">
                                    Select an action
                                </option>

                            </select>

                        </c:if>

                        <!-- Failure filter -->
                        <c:if test="${reportType == 'failure'}">

                            <select id="actionFilter"
                                    class="report-status-filter"
                                    aria-label="Filter by failure event">

                                <option value="">All Failure Events</option>

                                <option value="__dynamic__">
                                    Select an event
                                </option>

                            </select>

                        </c:if>

                        <!-- DSC Download status filter -->
                        <c:if test="${reportType == 'download'}">

                            <select id="statusFilter"
                                    class="report-status-filter"
                                    aria-label="Filter by download status">

                                <option value="">All Statuses</option>
                                <option value="downloaded">Downloaded</option>
                                <option value="download failed">Download Failed</option>

                            </select>

                        </c:if>

                        <!-- Signing filter -->
                        <c:if test="${reportType == 'signing'}">

                            <select id="statusFilter"
                                    class="report-status-filter"
                                    aria-label="Filter by signing status">

                                <option value="">All Statuses</option>
                                <c:forEach var="statusEntry" items="${signingStatusLabels}">
                                    <option value="${fn:toLowerCase(statusEntry.value)}">
                                        <c:out value="${statusEntry.value}"/>
                                    </option>
                                </c:forEach>

                            </select>

                        </c:if>

                    </div>

                    <!-- Date Range Filter -->
                    <div class="report-date-filters">
                        <label class="report-date-group" for="fromDate">
                            <span>From</span>
                            <input type="date"
                                   id="fromDate"
                                   class="report-date-input"
                                   aria-label="Filter from date">
                        </label>

                        <label class="report-date-group" for="toDate">
                            <span>To</span>
                            <input type="date"
                                   id="toDate"
                                   class="report-date-input"
                                   aria-label="Filter to date">
                        </label>

                        <button type="button" id="clearDates" class="report-clear-dates">
                            Clear Dates
                        </button>
                    </div>

                </div>

                <p id="dateRangeError" class="date-range-error" role="alert" hidden>
                    From Date cannot be later than To Date.
                </p>

                <!-- Report Table -->
                <div class="report-table-wrapper">

                    <table class="report-data-table">

                        <thead>
                        <tr>

                            <!-- Provisioning Columns -->
                            <c:if test="${reportType == 'provisioning'}">

                                <th data-sortable="true">QDSD ID</th>
                                <th data-sortable="true">Device ID</th>
                                <th data-sortable="true">Device Model</th>
                                <th data-sortable="true">Current Stage</th>
                                <th data-sortable="true">Status</th>
                                <th data-sortable="true">Last Update</th>

                            </c:if>

                            <!-- Other Report Columns -->
                            <c:if test="${reportType != 'provisioning'}">

                                <th data-sortable="true">Record ID</th>

                                <c:if test="${reportType == 'usage' or reportType == 'failure' or reportType == 'device' or reportType == 'download' or reportType == 'signing'}">
                                    <th data-sortable="true">QDSD ID</th>
                                </c:if>

                                <c:if test="${reportType != 'usage'}">
                                    <th data-sortable="true">Device ID</th>
                                    <th data-sortable="true">Device Model</th>
                                </c:if>

                                <c:choose>

                                    <c:when test="${reportType == 'usage'}">
                                        <th data-sortable="true">Action</th>
                                        <th data-sortable="true">Event Date</th>
                                    </c:when>

                                    <c:when test="${reportType == 'device'}">
                                        <th data-sortable="true">Subscriber</th>
                                        <th data-sortable="true">Organization</th>
                                        <th data-sortable="true">Status</th>
                                        <th data-sortable="true">Created Date</th>
                                    </c:when>

                                    <c:when test="${reportType == 'failure'}">
                                        <th data-sortable="true">Failure Event</th>
                                        <th data-sortable="true">Event Date</th>
                                        <th data-sortable="true">Failure Reason</th>
                                    </c:when>

                                    <c:when test="${reportType == 'download'}">
                                        <th data-sortable="true">Serial Number</th>
                                        <th data-sortable="true">Certificate Type</th>
                                        <th data-sortable="true">Status</th>
                                        <th data-sortable="true">Downloaded Date</th>
                                    </c:when>

                                    <c:when test="${reportType == 'signing'}">
                                        <th data-sortable="true">Transaction ID</th>
                                        <th data-sortable="true">Document Name</th>
                                        <th data-sortable="true">Platform</th>
                                        <th data-sortable="true">Status</th>
                                        <th data-sortable="true">Signed Date</th>
                                        <th data-sortable="true">Failure Reason</th>
                                    </c:when>

                                </c:choose>

                            </c:if>

                        </tr>
                        </thead>

                        <tbody id="reportTableBody">

                        <c:forEach var="item" items="${reportRows}">

                            <c:set var="filterDate"
                                   value="${reportType eq 'signing' ? (empty item.signedDate ? item.eventDate : item.signedDate) : ''}"/>

                            <tr data-filter-date="${fn:escapeXml(filterDate)}">

                                <!-- Provisioning Rows -->
                                <c:if test="${reportType == 'provisioning'}">

                                    <td><c:out value="${item.qdsdId}" default="-"/></td>
                                    <td><c:out value="${item.deviceId}" default="-"/></td>
                                    <td><c:out value="${item.deviceModel}" default="-"/></td>
                                    <td><c:out value="${item.lifecycle}" default="-"/></td>

                                    <td>
                                        <c:choose>

                                            <c:when test="${item.qdsdStatus eq 'Paired'}">
                                                <span class="report-status">Paired</span>
                                            </c:when>

                                            <c:when test="${item.qdsdStatus eq 'Not Paired'}">
                                                <span class="report-status warning">Not Paired</span>
                                            </c:when>

                                            <c:when test="${item.qdsdStatus eq 'Suspended'}">
                                                <span class="report-status danger">Suspended</span>
                                            </c:when>

                                            <c:when test="${item.qdsdStatus eq 'Lost'}">
                                                <span class="report-status neutral">Lost</span>
                                            </c:when>

                                            <c:otherwise>
                                                <c:out value="${item.qdsdStatus}" default="-"/>
                                            </c:otherwise>

                                        </c:choose>
                                    </td>

                                    <td><c:out value="${item.lastUpdate}" default="-"/></td>

                                </c:if>

                                <!-- Other Report Rows -->
                                <c:if test="${reportType != 'provisioning'}">

                                    <td><c:out value="${item.recordId}" default="—"/></td>

                                    <c:if test="${reportType == 'usage' or reportType == 'failure' or reportType == 'device' or reportType == 'download' or reportType == 'signing'}">
                                        <td><c:out value="${item.qdsdId}" default="—"/></td>
                                    </c:if>

                                    <c:if test="${reportType != 'usage'}">
                                        <td><c:out value="${item.deviceId}" default="—"/></td>
                                        <td><c:out value="${item.deviceModel}" default="—"/></td>
                                    </c:if>

                                    <c:choose>


                                        <c:when test="${reportType == 'usage'}">

                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.actionName eq 'Document Signed'}">
                                                        <span class="action-badge action-success">
                                                            <c:out value="${item.actionName}"/>
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${item.actionName eq 'DSC Download Approval Requested'}">
                                                        <span class="action-badge action-pending">
                                                            <c:out value="${item.actionName}"/>
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${item.actionName eq 'DSC Download Failed' or item.actionName eq 'Signing Failed'}">
                                                        <span class="action-badge action-failed">
                                                            <c:out value="${item.actionName}"/>
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${item.actionName eq 'QDSD Paired'}">
                                                        <span class="action-badge action-paired">
                                                            <c:out value="${item.actionName}"/>
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="action-badge action-default">
                                                            <c:out value="${item.actionName}" default="—"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><c:out value="${item.eventDate}" default="—"/></td>

                                        </c:when>


                                        <c:when test="${reportType == 'device'}">

                                            <td><c:out value="${item.subscriberName}" default="—"/></td>
                                            <td><c:out value="${item.organization}" default="—"/></td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.status eq 'Active'}">
                                                        <span class="report-status">Active</span>
                                                    </c:when>
                                                    <c:when test="${item.status eq 'Revoked'}">
                                                        <span class="report-status danger">Revoked</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="report-status neutral">
                                                            <c:out value="${item.status}" default="—"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td><c:out value="${item.eventDate}" default="—"/></td>

                                        </c:when>


                                        <c:when test="${reportType == 'failure'}">

                                            <td>
                                                <span class="report-status danger">
                                                    <c:out value="${item.actionName}" default="Failure event"/>
                                                </span>
                                            </td>

                                            <td><c:out value="${item.eventDate}" default="—"/></td>
                                            <td><c:out value="${item.failureReason}" default="—"/></td>

                                        </c:when>


                                        <c:when test="${reportType == 'download'}">

                                            <td><c:out value="${item.serialNumber}" default="—"/></td>
                                            <td><c:out value="${item.certificateType}" default="—"/></td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.status eq 'Downloaded'}">
                                                        <span class="report-status">Downloaded</span>
                                                    </c:when>
                                                    <c:when test="${item.status eq 'Download Failed'}">
                                                        <span class="report-status danger">Download Failed</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="report-status neutral">
                                                            <c:out value="${item.status}" default="—"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td><c:out value="${item.eventDate}" default="—"/></td>

                                        </c:when>


                                        <c:when test="${reportType == 'signing'}">

                                            <td><c:out value="${item.transactionId}" default="—"/></td>
                                            <td><c:out value="${item.documentName}" default="—"/></td>
                                            <td><c:out value="${item.signingPlatform}" default="—"/></td>

                                            <td>
                                                <c:set var="signingLabel"
                                                       value="${empty item.status ? '' : signingStatusLabels[item.status]}"/>

                                                <c:choose>

                                                    <%-- Success --%>
                                                    <c:when test="${item.status eq '23'}">
                                                        <span class="report-status"><c:out value="${signingLabel}"/></span>
                                                    </c:when>

                                                    <%-- Failed, Declined --%>
                                                    <c:when test="${item.status eq '24' or item.status eq '21'}">
                                                        <span class="report-status danger"><c:out value="${signingLabel}"/></span>
                                                    </c:when>

                                                    <%-- Expired, Completion Unconfirmed --%>
                                                    <c:when test="${item.status eq '25' or item.status eq '26'}">
                                                        <span class="report-status warning"><c:out value="${signingLabel}"/></span>
                                                    </c:when>

                                                    <%-- Requested, Approved, Started, or an unknown code --%>
                                                    <c:otherwise>
                                                        <span class="report-status neutral">
                                                            <c:out value="${empty signingLabel ? item.status : signingLabel}" default="—"/>
                                                        </span>
                                                    </c:otherwise>

                                                </c:choose>
                                            </td>

                                            <td><c:out value="${item.signedDate}" default="—"/></td>
                                            <td><c:out value="${item.failureReason}" default="—"/></td>

                                        </c:when>

                                    </c:choose>

                                </c:if>

                            </tr>

                        </c:forEach>

                        <tr id="noRecordsRow"
                            style="${empty reportRows ? '' : 'display:none;'}">

                            <td colspan="10" class="no-report-records">
                                No report records found.
                            </td>

                        </tr>

                        </tbody>

                    </table>

                </div>

                <!-- Pagination -->
                <div class="report-pagination" id="reportPagination">

                    <div class="pagination-size">
                        <label for="pageSize">Page Size:</label>

                        <select id="pageSize">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                    </div>

                    <span id="recordRange">0 to 0 of 0</span>

                    <div class="pagination-controls">

                        <button type="button" id="firstPage"
                                title="First page" aria-label="First page">
                            &laquo;
                        </button>

                        <button type="button" id="previousPage"
                                title="Previous page" aria-label="Previous page">
                            &lsaquo;
                        </button>

                        <div class="pagination-page">
                            <span id="currentPage">1</span>
                            <span style="border:none;">of</span>
                            <span id="totalPages">1</span>
                        </div>

                        <button type="button" id="nextPage"
                                title="Next page" aria-label="Next page">
                            &rsaquo;
                        </button>

                        <button type="button" id="lastPage"
                                title="Last page" aria-label="Last page">
                            &raquo;
                        </button>

                    </div>

                </div>

            </section>

        </main>

    </div>

</div>

<script src="${pageContext.request.contextPath}/js/report-dates.js"></script>

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


    // Report configuration
    const reportType = "${reportType}";

    const searchInput = document.getElementById("reportSearch");
    const reportTableBody = document.getElementById("reportTableBody");
    const totalRecordsDisplay = document.getElementById("totalRecords");
    const noRecordsRow = document.getElementById("noRecordsRow");

    const pageSizeSelect = document.getElementById("pageSize");
    const recordRange = document.getElementById("recordRange");
    const currentPageDisplay = document.getElementById("currentPage");
    const totalPagesDisplay = document.getElementById("totalPages");

    const firstPageButton = document.getElementById("firstPage");
    const previousPageButton = document.getElementById("previousPage");
    const nextPageButton = document.getElementById("nextPage");
    const lastPageButton = document.getElementById("lastPage");

    const pagination = document.getElementById("reportPagination");

    const statusFilter = document.getElementById("statusFilter");
    const actionFilter = document.getElementById("actionFilter");
    const fromDateInput = document.getElementById("fromDate");
    const toDateInput = document.getElementById("toDate");
    const clearDatesButton = document.getElementById("clearDates");
    const dateRangeError = document.getElementById("dateRangeError");

    const allRows = Array.from(
        reportTableBody.querySelectorAll("tr:not(#noRecordsRow)")
    );

    let filteredRows = [...allRows];
    let currentPage = 1;
    let pageSize = 10;

    let sortColumn = -1;
    let sortDirection = "asc";


    // Populate Action filters from actual table values
    function populateActionFilter() {

        if (!actionFilter) {
            return;
        }

        const actions = [
            ...new Set(
                allRows.map(row => {
                    const actionCell = reportType === "usage"
                        ? row.cells[2]
                        : row.cells[4];

                    return actionCell
                        ? actionCell.innerText.trim()
                        : "";
                }).filter(Boolean)
            )
        ].sort((a, b) => a.localeCompare(b));

        actionFilter.innerHTML = '<option value="">All Actions</option>';

        actions.forEach(action => {
            const option = document.createElement("option");
            option.value = action.toLowerCase();
            option.textContent = action;
            actionFilter.appendChild(option);
        });
    }


    // Get the date column index for the current report type
    function getDateCellIndex() {
        switch (reportType) {
            case "provisioning": return 5;
            case "usage": return 3;
            case "device": return 7;
            case "failure": return 5;
            case "download": return 7;
            case "signing": return 8;
            default: return -1;
        }
    }

    // Date used for range filtering; signing rows fall back to the created date
    function getRowFilterDate(row, dateCellIndex) {
        const fallbackDate = row.dataset.filterDate || "";

        if (fallbackDate !== "") {
            return ReportDates.toDateKey(fallbackDate);
        }

        return dateCellIndex >= 0 && row.cells[dateCellIndex]
            ? ReportDates.toDateKey(row.cells[dateCellIndex].innerText)
            : "";
    }

    // Filter records
    function filterReport() {

        const searchValue = searchInput.value.toLowerCase().trim();
        let selectedFromDate = fromDateInput.value;
        let selectedToDate = toDateInput.value;
        const dateCellIndex = getDateCellIndex();

        const invalidRange = selectedFromDate !== ""
            && selectedToDate !== ""
            && selectedFromDate > selectedToDate;

        dateRangeError.hidden = !invalidRange;

        if (invalidRange) {
            selectedFromDate = "";
            selectedToDate = "";
        }

        const selectedStatus = statusFilter
            ? statusFilter.value.toLowerCase()
            : "";

        const selectedAction = actionFilter
            ? actionFilter.value.toLowerCase()
            : "";

        filteredRows = allRows.filter(row => {

            const rowText = row.innerText.toLowerCase();

            const matchesSearch = rowText.includes(searchValue);

            let matchesStatus = true;
            let matchesAction = true;
            let matchesDate = true;

            if (selectedFromDate !== "" || selectedToDate !== "") {
                const rowDate = getRowFilterDate(row, dateCellIndex);

                // Exclude rows with missing/unparseable dates when a date range is set.
                if (!rowDate) {
                    matchesDate = false;
                } else {
                    if (selectedFromDate !== "" && rowDate < selectedFromDate) {
                        matchesDate = false;
                    }
                    if (selectedToDate !== "" && rowDate > selectedToDate) {
                        matchesDate = false;
                    }
                }
            }

            if (selectedStatus !== "") {

                const statusCellIndex = reportType === "provisioning"
                    ? 4
                    : reportType === "signing"
                        ? 7
                        : reportType === "download"
                            ? 6
                            : -1;

                if (statusCellIndex >= 0 && row.cells[statusCellIndex]) {
                    const statusText =
                        row.cells[statusCellIndex].innerText.trim().toLowerCase();

                    matchesStatus = statusText === selectedStatus;
                }
            }

            if (selectedAction !== "") {

                const actionCellIndex = reportType === "usage" ? 2 : 4;

                const actionText = row.cells[actionCellIndex]
                    ? row.cells[actionCellIndex].innerText.trim().toLowerCase()
                    : "";

                matchesAction = actionText === selectedAction;
            }

            return matchesSearch && matchesStatus && matchesAction && matchesDate;

        });

        currentPage = 1;
        renderTable();
    }


    // Sort records
    function sortTable(columnIndex) {

        if (sortColumn === columnIndex) {
            sortDirection = sortDirection === "asc" ? "desc" : "asc";
        } else {
            sortColumn = columnIndex;
            sortDirection = "asc";
        }

        filteredRows.sort((rowA, rowB) => {

            const valueA = rowA.cells[columnIndex]?.innerText.trim() || "";
            const valueB = rowB.cells[columnIndex]?.innerText.trim() || "";

            const numberA = Number(valueA);
            const numberB = Number(valueB);

            const dateA = ReportDates.toSortValue(valueA);
            const dateB = ReportDates.toSortValue(valueB);

            let comparison;

            if (dateA !== null || dateB !== null) {

                // Rows without a date always sort after dated rows.
                if (dateA === null) {
                    return 1;
                }
                if (dateB === null) {
                    return -1;
                }

                comparison = dateA - dateB;

            } else if (valueA !== "" && valueB !== ""
                && !Number.isNaN(numberA)
                && !Number.isNaN(numberB)) {

                comparison = numberA - numberB;

            } else {

                comparison = valueA.localeCompare(valueB, undefined, {
                    numeric: true,
                    sensitivity: "base"
                });

            }

            return sortDirection === "asc"
                ? comparison
                : -comparison;

        });

        document.querySelectorAll(".report-data-table th").forEach(th => {
            const oldIndicator = th.querySelector(".sort-indicator");
            if (oldIndicator) {
                oldIndicator.remove();
            }
        });

        const heading = document.querySelectorAll(".report-data-table th")[columnIndex];

        if (heading) {
            const indicator = document.createElement("span");
            indicator.className = "sort-indicator";
            indicator.textContent = sortDirection === "asc" ? "▲" : "▼";
            heading.appendChild(indicator);
        }

        currentPage = 1;
        renderTable();
    }


    // Attach sorting to all column headings
    document.querySelectorAll(
        ".report-data-table th[data-sortable='true']"
    ).forEach((heading, index) => {

        heading.addEventListener("click", function() {
            sortTable(index);
        });

    });


    // Render table and pagination
    function renderTable() {

        const totalRecords = filteredRows.length;
        const totalPages = Math.ceil(totalRecords / pageSize);

        currentPage = totalPages === 0
            ? 1
            : Math.min(currentPage, totalPages);

        const startIndex = (currentPage - 1) * pageSize;

        const endIndex = Math.min(
            startIndex + pageSize,
            totalRecords
        );

        allRows.forEach(row => {
            row.style.display = "none";
        });

        filteredRows.slice(startIndex, endIndex).forEach(row => {
            row.style.display = "";
        });

        totalRecordsDisplay.textContent = totalRecords;

        recordRange.textContent = totalRecords === 0
            ? "0 to 0 of 0"
            : (startIndex + 1) + " to " + endIndex + " of " + totalRecords;

        currentPageDisplay.textContent = currentPage;
        totalPagesDisplay.textContent = totalPages;

        noRecordsRow.style.display =
            totalRecords === 0 ? "" : "none";

        firstPageButton.disabled =
            currentPage === 1 || totalRecords === 0;

        previousPageButton.disabled =
            currentPage === 1 || totalRecords === 0;

        nextPageButton.disabled =
            currentPage === totalPages || totalRecords === 0;

        lastPageButton.disabled =
            currentPage === totalPages || totalRecords === 0;

        pagination.style.display =
            totalRecords === 0 ? "none" : "flex";
    }


    // Pagination events
    firstPageButton.addEventListener("click", function() {
        currentPage = 1;
        renderTable();
    });

    previousPageButton.addEventListener("click", function() {
        if (currentPage > 1) {
            currentPage--;
            renderTable();
        }
    });

    nextPageButton.addEventListener("click", function() {

        const totalPages = Math.ceil(filteredRows.length / pageSize);

        if (currentPage < totalPages) {
            currentPage++;
            renderTable();
        }
    });

    lastPageButton.addEventListener("click", function() {

        const totalPages = Math.ceil(filteredRows.length / pageSize);

        currentPage = Math.max(1, totalPages);
        renderTable();
    });

    pageSizeSelect.addEventListener("change", function() {
        pageSize = Number(this.value);
        currentPage = 1;
        renderTable();
    });

    searchInput.addEventListener("input", filterReport);

    if (statusFilter) {
        statusFilter.addEventListener("change", filterReport);
    }

    if (actionFilter) {
        actionFilter.addEventListener("change", filterReport);
    }

    fromDateInput.addEventListener("change", filterReport);
    toDateInput.addEventListener("change", filterReport);

    clearDatesButton.addEventListener("click", function() {
        fromDateInput.value = "";
        toDateInput.value = "";
        filterReport();
    });

    // Initial setup
    populateActionFilter();
    renderTable();

</script>

</body>
</html>