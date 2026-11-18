<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="section-container">
  <header class="page-head">
    <div>
      <h1>QDSD Manager</h1>
      <p>View and manage every qualified digital signing device.</p>
    </div>
  </header>

  <div class="toolbar">
    <input
      class="custom-input"
      type="search"
      placeholder="Search by ID, user, or organization"
      aria-label="Search QDSD records"
      data-grid-search="#qdsd-grid"
    />
    <select class="select" aria-label="Filter by status" data-grid-status="#qdsd-grid">
      <option value="">All statuses</option>
      <optgroup label="Pairing status">
        <option value="Paired">Paired</option>
        <option value="Not Paired">Not Paired</option>
      </optgroup>
      <optgroup label="Download status">
        <option value="Downloaded">Downloaded</option>
        <option value="Pending">Pending</option>
        <option value="Download Failed">Download Failed</option>
      </optgroup>
      <optgroup label="QDSD status">
        <option value="Waiting for DSC">Waiting for DSC</option>
        <option value="Suspended">Suspended</option>
        <option value="Inactive">Inactive</option>
        <option value="Ready">Ready</option>
        <option value="Error">Error</option>
      </optgroup>
    </select>
  </div>

  <div class="data-grid" id="qdsd-grid">
    <table class="data-table">
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
          <th data-nosort>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="row" items="${devices}">
          <tr class="data-row"
              data-href="${ctx}/qdsdmanager/qdsdDetails"
              data-filter="${fn:escapeXml(row.pairingStatus)}|${fn:escapeXml(row.downloadStatus)}|${fn:escapeXml(row.qdsdStatus)}">
            <td><c:out value="${row.qdsdId}" /></td>
            <td><c:out value="${row.serialNumber}" /></td>
            <td><c:out value="${row.assignedUser}" /></td>
            <td><c:out value="${row.organization}" /></td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.pairingStatus}" />
              </jsp:include>
            </td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.downloadStatus}" />
              </jsp:include>
            </td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.qdsdStatus}" />
              </jsp:include>
            </td>
            <td><c:out value="${row.lastUsed}" /></td>
            <td data-search-ignore><span class="view-action">View</span></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <%@ include file="/WEB-INF/jsp/includes/grid-pager.jsp" %>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
