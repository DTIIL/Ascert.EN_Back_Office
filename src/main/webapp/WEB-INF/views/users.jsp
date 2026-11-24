
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/sessionValidation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Users | Ascert.EN</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/users.css">
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

        </div>
    </header>

    <div class="app-body">

        <!-- Sidebar -->
        <%@ include file="/WEB-INF/views/common/sidenav.jsp" %>

        <!-- Main Content -->
        <main class="app-content">

            <section class="users-section">

                <!-- Success and Error Messages -->
                <c:if test="${not empty success}">
                    <div class="users-message success">
                        <c:out value="${success}"/>
                    </div>
                </c:if>

                <c:if test="${not empty generatedPassword}">
                    <div class="users-message success">
                        <strong>Generated Password:</strong>
                        <c:out value="${generatedPassword}"/>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="users-message error">
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <!-- Add / Update User Form -->
                <div id="addUserFormContainer"
                     class="add-user-form-container"
                     <c:if test="${not showForm}">hidden</c:if>>

                    <h2 id="userFormHeading">
                        <c:choose>
                            <c:when test="${editMode}">Update User</c:when>
                            <c:otherwise>Add User</c:otherwise>
                        </c:choose>
                    </h2>

                    <p id="userFormDescription">
                        <c:choose>
                            <c:when test="${editMode}">
                                Update the selected user details
                            </c:when>
                            <c:otherwise>
                                Enter the details to add a new user
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <form id="addUserForm"
                          action="${pageContext.request.contextPath}${editMode ? '/user/update' : '/user/add'}"
                          method="post">

                          <input type="hidden"
                                 name="${_csrf.parameterName}"
                                 value="${_csrf.token}">

                        <c:if test="${editMode}">
                            <input type="hidden"
                                   name="id"
                                   value="${editingUser.id}">
                        </c:if>

                        <div class="add-user-form-grid">

                            <div class="form-group">
                                <label for="fullName">Full Name</label>

                                <input type="text"
                                       id="fullName"
                                       name="name"
                                       placeholder="Enter full name"
                                       maxlength="100"
                                       value="<c:out value='${editingUser.name}'/>"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="username">Username</label>

                                <input type="text"
                                       id="username"
                                       name="username"
                                       placeholder="Enter username"
                                       maxlength="25"
                                       pattern="[A-Za-z0-9._-]{1,25}"
                                       title="Letters, numbers, dots, underscores, and hyphens, up to 25 characters"
                                       value="<c:out value='${editingUser.username}'/>"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="emailId">Email Address</label>

                                <input type="email"
                                       id="emailId"
                                       name="emailId"
                                       placeholder="Enter email address"
                                       maxlength="150"
                                       value="<c:out value='${editingUser.emailId}'/>"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="mobileNumber">Mobile Number</label>

                                <input type="tel"
                                       id="mobileNumber"
                                       name="mobileNumber"
                                       placeholder="Enter mobile number"
                                       pattern="[0-9]{10}"
                                       minlength="10"
                                       maxlength="10"
                                       value="${editingUser.mobileNumber}"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="userRole">Role</label>

                                <select id="userRole"
                                        name="userRole"
                                        required>

                                    <option value="">Select role</option>

                                    <c:forEach var="role" items="${roles}">
                                        <option value="${role.id}"
                                            <c:if test="${role.active != 1}">
                                                data-inactive-role="true"
                                            </c:if>
                                            <c:if test="${editMode && editingUser.userRole == role.id}">
                                                selected
                                            </c:if>>
                                            <c:out value="${role.userRole}"/><c:if test="${role.active != 1}"> (inactive)</c:if>
                                        </option>
                                    </c:forEach>

                                </select>
                            </div>

                            <div class="form-group">
                                <label for="status">Status</label>

                                <select id="status" name="status" required>

                                    <option value="1"
                                        <c:if test="${not editMode || editingUser.status == 1}">
                                            selected
                                        </c:if>>
                                        Active
                                    </option>

                                    <option value="2"
                                        <c:if test="${editMode && editingUser.status == 2}">
                                            selected
                                        </c:if>>
                                        Inactive
                                    </option>

                                    <option value="3"
                                        <c:if test="${editMode && editingUser.status == 3}">
                                            selected
                                        </c:if>>
                                        Pending
                                    </option>

                                </select>
                            </div>

                        </div>

                        <div class="add-user-form-actions">

                            <button type="button"
                                    id="cancelAddUser"
                                    class="users-cancel-btn">
                                Cancel
                            </button>

                            <button type="submit"
                                    class="users-primary-btn"
                                    id="submitUserButton">
                                <c:choose>
                                    <c:when test="${editMode}">Update user</c:when>
                                    <c:otherwise>Create user</c:otherwise>
                                </c:choose>
                            </button>

                        </div>

                    </form>
                </div>

                <!-- Users Heading -->
                <header class="users-header">

                    <div>
                        <h1>Users</h1>
                        <p>Manage people, roles, and access.</p>
                    </div>

                    <!-- Always clickable -->
                    <button class="users-primary-btn"
                            type="button"
                            id="addUserButton">
                        Add user
                    </button>

                </header>

                <!-- Search -->
                <div class="users-toolbar">

                    <input type="search"
                           id="userSearch"
                           class="users-search"
                           placeholder="Search by name, username, email, or role"
                           aria-label="Search users">

                </div>

                <!-- Users Table -->
                <div class="users-table-container">

                    <div class="users-table-scroll">

                        <table class="users-table" id="usersTable">

                            <thead>
                                <tr>
                                    <th>Full Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Mobile</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody id="usersTableBody">

                                <c:forEach var="user" items="${users}">
                                    <tr>

                                        <td>
                                            <c:out value="${user.name}"
                                                   default="—"/>
                                        </td>

                                        <td>
                                            <c:out value="${user.username}"
                                                   default="—"/>
                                        </td>

                                        <td>
                                            <c:out value="${user.emailId}"
                                                   default="—"/>
                                        </td>

                                        <td>
                                            <c:out value="${user.mobileNumber}"
                                                   default="—"/>
                                        </td>

                                        <td>
                                            <c:set var="assignedRole" value="${rolesById[user.userRole]}"/>
                                            <c:out value="${assignedRole.userRole}" default="—"/><c:if test="${not empty assignedRole && assignedRole.active != 1}"> (inactive)</c:if>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${user.status == 1}">
                                                    <span class="user-status active">Active</span>
                                                </c:when>

                                                <c:when test="${user.status == 2}">
                                                    <span class="user-status inactive">Inactive</span>
                                                </c:when>

                                                <c:when test="${user.status == 3}">
                                                    <span class="user-status pending">Pending</span>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="user-status unknown">Unknown</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <a class="user-edit-link"
                                               href="${pageContext.request.contextPath}/user?editId=${user.id}">
                                                Edit
                                            </a>
                                        </td>

                                    </tr>
                                </c:forEach>

                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="7" class="users-empty">
                                            No users found.
                                        </td>
                                    </tr>
                                </c:if>

                            </tbody>

                        </table>

                    </div>

                    <!-- Pagination -->
                    <div class="users-pagination">

                        <div class="pagination-left">

                            <label for="pageSize">Page Size:</label>

                            <select id="pageSize">
                                <option value="10" selected>10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                            </select>

                            <span id="recordInfo">0 to 0 of 0</span>

                        </div>

                        <div class="pagination-right">

                            <button type="button"
                                    id="firstPage"
                                    aria-label="First page">|‹</button>

                            <button type="button"
                                    id="previousPage"
                                    aria-label="Previous page">‹</button>

                            <span>Page</span>

                            <input type="number"
                                   id="currentPage"
                                   min="1"
                                   value="1">

                            <span id="totalPages">of 1</span>

                            <button type="button"
                                    id="nextPage"
                                    aria-label="Next page">›</button>

                            <button type="button"
                                    id="lastPage"
                                    aria-label="Last page">›|</button>

                        </div>

                    </div>

                </div>

            </section>

        </main>

    </div>
</div>

<script>

    const contextPath = "${pageContext.request.contextPath}";

    // This value can change when switching from Edit to Add.
    let formMode = ${editMode ? 'true' : 'false'};

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

    // Add / Edit form
    const addUserButton = document.getElementById("addUserButton");
    const formContainer = document.getElementById("addUserFormContainer");
    const cancelButton = document.getElementById("cancelAddUser");
    const userForm = document.getElementById("addUserForm");

    const formHeading = document.getElementById("userFormHeading");
    const formDescription = document.getElementById("userFormDescription");
    const submitButton = document.getElementById("submitUserButton");

    // Open Add User form.
    // This button remains enabled even when the form is already visible.
    addUserButton.addEventListener("click", function() {

        formMode = false;

        // Clear all previous form values.
        userForm.reset();

        // Remove the Edit User ID when switching to Add mode.
        const existingId = userForm.querySelector('input[name="id"]');

        if (existingId) {
            existingId.remove();
        }

        // Inactive roles are only shown for a user who already has one.
        userForm.querySelectorAll('option[data-inactive-role]').forEach(option => {
            option.remove();
        });

        // Change the form heading and description.
        formHeading.textContent = "Add User";

        formDescription.textContent =
            "Enter the details to add a new user";

        // Change the submit button.
        submitButton.textContent = "Create user";

        // Change the form submission URL.
        userForm.action = contextPath + "/user/add";

        // Display the form.
        formContainer.hidden = false;

        // Scroll to the form.
        formContainer.scrollIntoView({
            behavior: "smooth",
            block: "start"
        });
    });

    // Cancel Add / Edit form.
    cancelButton.addEventListener("click", function() {

        userForm.reset();

        // If still in Edit mode, return to the Users list.
        if (formMode) {
            window.location.href = contextPath + "/user";
            return;
        }

        // If in Add mode, simply close the form.
        formContainer.hidden = true;
    });

    // Search and pagination
    const tableBody = document.getElementById("usersTableBody");
    const searchInput = document.getElementById("userSearch");
    const pageSizeSelect = document.getElementById("pageSize");
    const currentPageInput = document.getElementById("currentPage");

    const recordInfo = document.getElementById("recordInfo");
    const totalPagesText = document.getElementById("totalPages");

    const firstPageButton = document.getElementById("firstPage");
    const previousPageButton = document.getElementById("previousPage");
    const nextPageButton = document.getElementById("nextPage");
    const lastPageButton = document.getElementById("lastPage");

    const allRows = Array.from(tableBody.querySelectorAll("tr"))
        .filter(row => row.cells.length === 7);

    let currentPage = 1;

    function getFilteredRows() {
        const searchValue = searchInput.value.trim().toLowerCase();

        return allRows.filter(row =>
            row.textContent.toLowerCase().includes(searchValue)
        );
    }

    function renderUsers() {

        const filteredRows = getFilteredRows();
        const pageSize = Number(pageSizeSelect.value);
        const totalRecords = filteredRows.length;

        const totalPages = Math.max(
            1,
            Math.ceil(totalRecords / pageSize)
        );

        currentPage = Math.min(currentPage, totalPages);
        currentPage = Math.max(currentPage, 1);

        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalRecords);

        allRows.forEach(row => {
            row.style.display = "none";
        });

        filteredRows.slice(startIndex, endIndex).forEach(row => {
            row.style.display = "";
        });

        recordInfo.textContent = totalRecords === 0
            ? "0 to 0 of 0"
            : (startIndex + 1) + " to " + endIndex +
              " of " + totalRecords;

        currentPageInput.value = currentPage;
        currentPageInput.max = totalPages;

        totalPagesText.textContent = "of " + totalPages;

        firstPageButton.disabled = currentPage === 1;
        previousPageButton.disabled = currentPage === 1;
        nextPageButton.disabled = currentPage === totalPages;
        lastPageButton.disabled = currentPage === totalPages;
    }

    searchInput.addEventListener("input", function() {
        currentPage = 1;
        renderUsers();
    });

    pageSizeSelect.addEventListener("change", function() {
        currentPage = 1;
        renderUsers();
    });

    firstPageButton.addEventListener("click", function() {
        currentPage = 1;
        renderUsers();
    });

    previousPageButton.addEventListener("click", function() {
        currentPage--;
        renderUsers();
    });

    nextPageButton.addEventListener("click", function() {
        currentPage++;
        renderUsers();
    });

    lastPageButton.addEventListener("click", function() {
        currentPage = Math.ceil(
            getFilteredRows().length / Number(pageSizeSelect.value)
        ) || 1;

        renderUsers();
    });

    currentPageInput.addEventListener("change", function() {
        const requestedPage = Number(currentPageInput.value);

        if (Number.isInteger(requestedPage)) {
            currentPage = requestedPage;
        }

        renderUsers();
    });

    renderUsers();

</script>

</body>
</html>
