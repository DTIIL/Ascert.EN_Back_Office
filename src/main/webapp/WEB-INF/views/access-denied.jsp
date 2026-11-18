<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Access denied | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
</head>

<body>

<div class="app-shell">

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

        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <main class="app-content">

            <section class="dashboard-section">

                <header class="page-head">

                    <div>
                        <h1>Access denied</h1>

                        <p>
                            Your role does not include that page.
                            Use the menu to open a page you can access.
                        </p>
                    </div>

                </header>

            </section>

        </main>

    </div>

</div>

<script>
    function toggleUserMenu() {
        const menu = document.getElementById("logoutMenu");
        const button = document.querySelector(".user-chip");
        const open = menu.hasAttribute("hidden");

        if (open) {
            menu.removeAttribute("hidden");
            button.setAttribute("aria-expanded", "true");
        } else {
            menu.setAttribute("hidden", "");
            button.setAttribute("aria-expanded", "false");
        }
    }
</script>

</body>
</html>
