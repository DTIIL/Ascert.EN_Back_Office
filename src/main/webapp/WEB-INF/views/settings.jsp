
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Settings | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/settings.css">
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

    </header>

    <div class="app-body">

        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <!-- Main Content -->
        <main class="app-content">

            <section class="settings-page">

                <header class="page-head">
                    <div>
                        <h1>Settings</h1>
                        <p>Account details and how this workspace notifies you.</p>
                    </div>
                </header>

                <div class="settings-grid">

                    <!-- Profile -->
                    <article class="settings-card">

                        <h2>Profile</h2>

                        <dl>
                            <div>
                                <dt>Name</dt>
                                <dd>${userName}</dd>
                            </div>

                            <div>
                                <dt>Role</dt>
                                <dd><c:out value="${userRole}"/></dd>
                            </div>

                            <div>
                                <dt>Workspace</dt>
                                <dd>Ascert.en Back Office</dd>
                            </div>
                        </dl>

                    </article>

                    <!-- Preferences -->
                    <article class="settings-card">

                        <h2>Preferences</h2>

                        <form action="${pageContext.request.contextPath}/settings/preferences"
                              method="post">

                              <input type="hidden"
                                     name="${_csrf.parameterName}"
                                     value="${_csrf.token}">

                            <ul>

                                <li>
                                    <div class="preference-info">
                                        <strong>Email alerts</strong>
                                        <span>Provisioning failures and DSC download errors</span>
                                    </div>

                                    <label class="switch">
                                        <input type="checkbox"
                                               name="emailAlerts"
                                               value="true"
                                               <c:if test="${emailAlerts}">checked</c:if>>
                                        <span class="switch-slider"></span>
                                    </label>
                                </li>

                                <li>
                                    <div class="preference-info">
                                        <strong>Daily digest</strong>
                                        <span>A morning summary of signing activity</span>
                                    </div>

                                    <label class="switch">
                                        <input type="checkbox"
                                               name="dailyDigest"
                                               value="true"
                                               <c:if test="${dailyDigest}">checked</c:if>>
                                        <span class="switch-slider"></span>
                                    </label>
                                </li>

                                <li>
                                    <div class="preference-info">
                                        <strong>Session lock</strong>
                                        <span>Ask for a password again after 15 minutes idle</span>
                                    </div>

                                    <label class="switch">
                                        <input type="checkbox"
                                               name="sessionLockEnabled"
                                               value="true"
                                               <c:if test="${sessionLockEnabled}">checked</c:if>>
                                        <span class="switch-slider"></span>
                                    </label>
                                </li>

                            </ul>

                            <button type="submit" class="btn btn-primary">
                                Save preferences
                            </button>

                            <c:if test="${not empty successMessage}">
                                <p class="settings-success">${successMessage}</p>
                            </c:if>

                            <c:if test="${not empty errorMessage}">
                                <p class="settings-error">${errorMessage}</p>
                            </c:if>

                        </form>

                    </article>

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

    document.addEventListener("click", function(event) {
        const menu = document.getElementById("logoutMenu");
        const userMenu = document.querySelector(".user-menu");

        if (!userMenu.contains(event.target)) {
            menu.hidden = true;
        }
    });
</script>

</body>
</html>
