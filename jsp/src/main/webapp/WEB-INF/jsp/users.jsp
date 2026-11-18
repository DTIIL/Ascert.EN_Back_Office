<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="section-container">
  <c:if test="${showForm}">
    <section class="add-user-component">
      <div>
        <h1><c:out value="${not empty editing and editing.id > 0 ? 'Update User' : 'Add User'}" /></h1>
        <span>
          <c:out value="${not empty editing and editing.id > 0 ? 'Update the selected user details' : 'Create new user with basic details'}" />
        </span>
      </div>
      <c:set var="isEdit" value="${not empty editing and editing.id > 0}" />
      <form class="width-100" id="userForm" method="post" action="${ctx}${isEdit ? '/user/update' : '/user'}" novalidate>
        <c:if test="${isEdit}">
          <input type="hidden" name="id" value="${editing.id}" />
        </c:if>
        <div class="flex-space-between">
          <div class="grid width-50">
            <label for="fullName">Full Name</label>
            <input id="fullName" name="fullName" type="text" placeholder="Enter full name" value="${fn:escapeXml(editing.fullName)}" class="${empty fieldErrors.fullName ? '' : 'is-invalid'}" aria-describedby="fullName-error" />
            <span class="field-error" id="fullName-error" aria-live="polite"><c:out value="${fieldErrors.fullName}" /></span>
          </div>
          <div class="grid width-50">
            <label for="email">Email Address</label>
            <input id="email" name="email" type="email" placeholder="Enter email address" value="${fn:escapeXml(editing.email)}" class="${empty fieldErrors.email ? '' : 'is-invalid'}" aria-describedby="email-error" />
            <span class="field-error" id="email-error" aria-live="polite"><c:out value="${fieldErrors.email}" /></span>
          </div>
        </div>
        <div class="flex-space-between">
          <div class="grid">
            <label for="mobile">Mobile Number</label>
            <input id="mobile" name="mobile" type="tel" placeholder="Enter mobile number" value="${fn:escapeXml(editing.mobile)}" class="${empty fieldErrors.mobile ? '' : 'is-invalid'}" aria-describedby="mobile-error" />
            <span class="field-error" id="mobile-error" aria-live="polite"><c:out value="${fieldErrors.mobile}" /></span>
          </div>
          <div class="grid">
            <label for="role">Role</label>
            <select id="role" name="role" class="${empty fieldErrors.role ? '' : 'is-invalid'}" aria-describedby="role-error">
              <option value="" ${empty editing.role ? 'selected' : ''}>Select role</option>
              <option value="Admin" ${editing.role == 'Admin' ? 'selected' : ''}>Admin</option>
              <option value="Manager" ${editing.role == 'Manager' ? 'selected' : ''}>Manager</option>
              <option value="Editor" ${editing.role == 'Editor' ? 'selected' : ''}>Editor</option>
              <option value="User" ${editing.role == 'User' ? 'selected' : ''}>User</option>
            </select>
            <span class="field-error" id="role-error" aria-live="polite"><c:out value="${fieldErrors.role}" /></span>
          </div>
          <div class="grid">
            <label for="status">Status</label>
            <select id="status" name="status" class="${empty fieldErrors.status ? '' : 'is-invalid'}" aria-describedby="status-error">
              <option value="" ${empty editing.status ? 'selected' : ''}>Select status</option>
              <option value="Active" ${editing.status == 'Active' ? 'selected' : ''}>Active</option>
              <option value="Inactive" ${editing.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
              <option value="Pending" ${editing.status == 'Pending' ? 'selected' : ''}>Pending</option>
            </select>
            <span class="field-error" id="status-error" aria-live="polite"><c:out value="${fieldErrors.status}" /></span>
          </div>
        </div>
        <div class="btn-container">
          <a class="btn btn-secondary" href="${ctx}/user">Cancel</a>
          <button type="submit" class="btn btn-primary">
            <c:out value="${isEdit ? 'Update user' : 'Create user'}" />
          </button>
        </div>
      </form>
    </section>
  </c:if>

  <div class="header-component">
    <div>
      <h1>Users</h1>
      <p class="page-subtitle">Manage people, roles, and access.</p>
    </div>
    <c:choose>
      <c:when test="${param.form == 'new'}">
        <a class="btn btn-primary" href="${ctx}/user">Close</a>
      </c:when>
      <c:otherwise>
        <a class="btn btn-primary" href="${ctx}/user?form=new">Add user</a>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="toolbar">
    <input
      class="custom-input"
      type="search"
      placeholder="Search by name, email, or role"
      aria-label="Search users"
      data-grid-search="#user-grid"
    />
  </div>

  <div class="data-grid" id="user-grid">
    <table class="data-table">
      <thead>
        <tr>
          <th>Full Name</th>
          <th>Email</th>
          <th>Mobile</th>
          <th>Role</th>
          <th>Status</th>
          <th data-nosort>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="row" items="${users}">
          <tr class="data-row">
            <td><c:out value="${row.fullName}" /></td>
            <td><c:out value="${row.email}" /></td>
            <td><c:out value="${row.mobile}" /></td>
            <td><c:out value="${row.role}" /></td>
            <td>
              <jsp:include page="/WEB-INF/jsp/includes/status.jsp">
                <jsp:param name="value" value="${row.status}" />
              </jsp:include>
            </td>
            <td data-search-ignore>
              <a class="text-action" href="${ctx}/user?edit=${row.id}">Edit</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
    <%@ include file="/WEB-INF/jsp/includes/grid-pager.jsp" %>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
