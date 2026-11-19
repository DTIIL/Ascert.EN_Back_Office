
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ascert.en | Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="image/svg+xml"
          href="${pageContext.request.contextPath}/assets/Icon_logo.svg">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>

<main class="login-page">

    <div class="circle circle-top-right"></div>
    <div class="circle circle-bottom-left"></div>

    <section class="login-card">

        <div class="brand">
            <span class="brand-icon">
                <img src="${pageContext.request.contextPath}/assets/Icon_logo.svg"
                     alt="Ascert.en logo">
            </span>

            <span class="brand-name">Ascert<span>.en</span></span>
        </div>

        <h1>Sign in to your account</h1>

        <p class="login-description">
            Access the back office to manage devices, users, and reports.
        </p>

        <!-- Microsoft SSO Error Messages -->
        <c:if test="${param.error == 'sso_rejected'}">
            <div class="login-error" role="alert">
                Your Microsoft account is not authorized to access this application.
                Please contact your administrator.
            </div>
        </c:if>

        <c:if test="${param.error != null && param.error != 'sso_rejected'}">
            <div class="login-error" role="alert">
                Microsoft sign-in failed. Please try again.
            </div>
        </c:if>

        <!-- Microsoft SSO -->
        <button class="sso-button"
                type="button"
                onclick="window.location.href='${pageContext.request.contextPath}/oauth2/authorization/sso'">
            Continue with SSO
        </button>

        <div class="divider">
            <span></span>
            <p>or</p>
            <span></span>
        </div>

        <form class="login-form"
              id="loginForm"
              action="${pageContext.request.contextPath}/login"
              method="post"
              novalidate>

            <!-- Email field -->
            <label class="login-field">
                <input type="email"
                       id="emailId"
                       name="emailId"
                       placeholder="Email address"
                       autocomplete="email"
                       value="<c:out value='${enteredEmail}'/>"
                       aria-describedby="emailError"
                       required>
            </label>

            <p class="error-message" id="emailError">
                <c:out value="${emailError}"/>
            </p>

            <!-- Password field -->
            <label class="login-field">
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Password"
                       autocomplete="current-password"
                       aria-describedby="passwordError"
                       required>

                <button class="password-toggle"
                        type="button"
                        onclick="togglePassword()">
                    Show
                </button>
            </label>

            <p class="error-message" id="passwordError">
                <c:out value="${passwordError}"/>
            </p>

            <!-- General login error -->
            <p class="error-message" id="loginError">
                <c:out value="${loginError}"/>
            </p>

            <div class="form-options">
                <label class="remember-me">
                    <input type="checkbox" name="rememberMe">
                    <span>Remember me</span>
                </label>

                <a href="#" onclick="return false;">
                    Forgot password?
                </a>
            </div>

            <!-- CSRF token -->
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">

            <button class="signin-button" type="submit">
                Sign in
            </button>

        </form>
    </section>
</main>

<script>

    const loginForm = document.getElementById("loginForm");

    const emailInput = document.getElementById("emailId");
    const passwordInput = document.getElementById("password");

    const emailError = document.getElementById("emailError");
    const passwordError = document.getElementById("passwordError");
    const loginError = document.getElementById("loginError");

    // Show or remove invalid field styling
    function setFieldError(input, errorElement, message) {

        errorElement.textContent = message;

        if (message !== "") {
            input.classList.add("input-invalid");
            input.setAttribute("aria-invalid", "true");
        } else {
            input.classList.remove("input-invalid");
            input.setAttribute("aria-invalid", "false");
        }
    }

    // Email validation
    function validateEmail() {

        const email = emailInput.value.trim();

        if (email === "") {
            setFieldError(
                emailInput,
                emailError,
                "Please enter your email address."
            );
            return false;
        }

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {
            setFieldError(
                emailInput,
                emailError,
                "Please enter a valid email address."
            );
            return false;
        }

        setFieldError(emailInput, emailError, "");
        return true;
    }

    // Password validation
    function validatePassword() {

        const password = passwordInput.value;

        if (password.trim() === "") {
            setFieldError(
                passwordInput,
                passwordError,
                "Please enter your password."
            );
            return false;
        }

        setFieldError(passwordInput, passwordError, "");
        return true;
    }

    // Validate while typing
    emailInput.addEventListener("input", function() {
        validateEmail();
        loginError.textContent = "";
    });

    passwordInput.addEventListener("input", function() {
        validatePassword();
        loginError.textContent = "";
    });

    // Validate before submitting
    loginForm.addEventListener("submit", function(event) {

        const isEmailValid = validateEmail();
        const isPasswordValid = validatePassword();

        if (!isEmailValid || !isPasswordValid) {
            event.preventDefault();
        }
    });

    // Display red borders for backend validation errors
    if (emailError.textContent.trim() !== "") {
        emailInput.classList.add("input-invalid");
        emailInput.setAttribute("aria-invalid", "true");
    }

    if (passwordError.textContent.trim() !== "") {
        passwordInput.classList.add("input-invalid");
        passwordInput.setAttribute("aria-invalid", "true");
    }

    // Show or hide password
    function togglePassword() {

        const toggleButton = document.querySelector(".password-toggle");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleButton.textContent = "Hide";
        } else {
            passwordInput.type = "password";
            toggleButton.textContent = "Show";
        }
    }

</script>

</body>
</html>
