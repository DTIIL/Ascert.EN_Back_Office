<%@ include file="/WEB-INF/jsp/includes/shell-open.jsp" %>
<section class="settings-page">
  <header class="page-head">
    <div>
      <h1>Settings</h1>
      <p>Account details and how this workspace notifies you.</p>
    </div>
  </header>

  <div class="settings-grid">
    <article class="settings-card">
      <h2>Profile</h2>
      <dl>
        <div>
          <dt>Name</dt>
          <dd>John Doe</dd>
        </div>
        <div>
          <dt>Role</dt>
          <dd>Admin</dd>
        </div>
        <div>
          <dt>Workspace</dt>
          <dd>Ascert.en Back Office</dd>
        </div>
      </dl>
    </article>

    <article class="settings-card">
      <h2>Preferences</h2>
      <form method="post" action="${ctx}/settings">
        <ul>
          <li>
            <div>
              <strong>Email alerts</strong>
              <span>Provisioning failures and DSC download errors</span>
            </div>
            <button type="button" class="switch${prefs.email ? ' on' : ''}" data-pref="pref-email" aria-pressed="${prefs.email}">
              <span></span>
            </button>
            <input type="hidden" id="pref-email" name="email" value="${prefs.email}" />
          </li>
          <li>
            <div>
              <strong>Daily digest</strong>
              <span>A morning summary of signing activity</span>
            </div>
            <button type="button" class="switch${prefs.digest ? ' on' : ''}" data-pref="pref-digest" aria-pressed="${prefs.digest}">
              <span></span>
            </button>
            <input type="hidden" id="pref-digest" name="digest" value="${prefs.digest}" />
          </li>
          <li>
            <div>
              <strong>Session lock</strong>
              <span>Ask for a password again after 15 minutes idle</span>
            </div>
            <button type="button" class="switch${prefs.sessionLock ? ' on' : ''}" data-pref="pref-session" aria-pressed="${prefs.sessionLock}">
              <span></span>
            </button>
            <input type="hidden" id="pref-session" name="sessionLock" value="${prefs.sessionLock}" />
          </li>
        </ul>
        <button type="submit" class="btn btn-primary" id="save-prefs">
          <c:choose>
            <c:when test="${param.saved == '1'}">Saved</c:when>
            <c:otherwise>Save preferences</c:otherwise>
          </c:choose>
        </button>
      </form>
    </article>
  </div>
</section>
<%@ include file="/WEB-INF/jsp/includes/shell-close.jsp" %>
