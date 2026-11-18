<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="section-container">
  <header class="page-head">
    <div>
      <h1>Factory Provisioning</h1>
      <p>Track every device from the factory floor to a locked state.</p>
    </div>
  </header>
  <div class="toolbar">
    <input
      type="search"
      class="custom-input"
      placeholder="Search devices, factories, or stages"
      aria-label="Search factory provisioning records"
      data-grid-search="#factory-grid"
    />
  </div>
  <div class="data-grid" id="factory-grid">
    <table class="data-table">
      <thead>
        <tr>
          <th>Device ID</th>
          <th>Secure Element ID</th>
          <th>Factory ID</th>
          <th>Current Stage</th>
          <th>Status</th>
          <th>Last Updated</th>
          <th data-nosort>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="row" items="${devices}">
          <tr class="data-row" data-href="${ctx}/factoryprovising/detail" data-filter="${fn:escapeXml(row.provisioningStatus)}">
            <td><c:out value="${row.deviceId}" /></td>
            <td><c:out value="${row.secureElementId}" /></td>
            <td><c:out value="${row.factoryId}" /></td>
            <td><c:out value="${row.currentStage}" /></td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.provisioningStatus}" />
              </jsp:include>
            </td>
            <td><c:out value="${row.lastUpdated}" /></td>
            <td data-search-ignore><span class="view-action">View</span></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <%@ include file="/WEB-INF/jsp/includes/grid-pager.jsp" %>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
