<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="section-container">
  <nav class="crumbs" aria-label="Breadcrumb">
    <a href="${ctx}/report">Reports</a>
    <span aria-hidden="true">/</span>
    <span><c:out value="${title}" /></span>
  </nav>
  <header class="page-head">
    <div>
      <h1><c:out value="${title}" /></h1>
      <p>Filter the records below, or return to the report catalogue.</p>
    </div>
  </header>
  <div class="toolbar">
    <input
      class="custom-input"
      type="search"
      placeholder="${fn:escapeXml(placeholder)}"
      aria-label="${fn:escapeXml(placeholder)}"
      data-grid-search="#report-grid"
    />
    <select class="select" aria-label="Filter by status" data-grid-status="#report-grid">
      <option value="">All statuses</option>
      <option value="Completed">Completed</option>
      <option value="Pending">Pending</option>
      <option value="In Progress">In Progress</option>
      <option value="Failed">Failed</option>
    </select>
  </div>
  <div class="data-grid" id="report-grid">
    <table class="data-table">
      <thead>
        <tr>
          <th>Device ID</th>
          <th>Factory ID</th>
          <th>Current Stage</th>
          <th>Status</th>
          <th>Last Update</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="row" items="${rows}">
          <tr class="data-row" data-filter="${fn:escapeXml(row.status)}">
            <td><c:out value="${row.deviceId}" /></td>
            <td><c:out value="${row.factoryId}" /></td>
            <td><c:out value="${row.currentStage}" /></td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.status}" />
              </jsp:include>
            </td>
            <td><c:out value="${row.lastUpdate}" /></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <%@ include file="/WEB-INF/jsp/includes/grid-pager.jsp" %>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
