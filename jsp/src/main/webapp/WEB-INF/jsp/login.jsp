
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <title>Ascert.EN | Qualified Digital Signing</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link
        href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600;700&display=swap"
        rel="stylesheet"
    />

    <!-- CSS -->
    <link rel="stylesheet" href="${ctx}/assets/css/fonts.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/globals.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/login.css" />
    <link rel="stylesheet" href="${ctx}/assets/css/jsp-fixes.css" />

</head>

<body>

<main class="login-page">

    <section class="login-card">

        <!-- Brand -->
        <div class="brand">

            <span class="brand-icon">
                <img
                    src="${ctx}/assets/Icon_logo.svg"
                    width="28"
                    height="28"
                    alt="Ascert logo"
                />
            </span>

            <span class="brand-name">
                Ascert<span>.en</span>
            </span>

        </div>

        <!-- Heading -->
        <h1>Sign in to your account</h1>

        <p class="login-description">
            Access the back office to manage devices, users, and reports.
        </p>

        <!-- SSO Login -->
        <form method="post" action="${ctx}/login">

            <button class="sso-button" type="submit">

                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M4 20V10l8-6 8 6v10" />
                    <path d="M9 20v-6h6v6" />
                </svg>

                Continue with SSO

            </button>

        </form>

        <!-- Divider -->
        <div class="divider">

            <span></span>
            <p>or</p>
            <span></span>

        </div>

        <!-- Login Form -->
        <form
            class="login-form"
            id="loginForm"
            method="post"
            action="${ctx}/login"
            novalidate
        >

            <!-- Email -->
            <div class="form-group">

                <label class="login-field${empty emailError ? '' : ' is-invalid'}" for="email">

                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <rect x="3" y="5" width="18" height="14" rx="2" />
                        <path d="m4 7 8 6 8-6" />
                    </svg>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Email address"
                        aria-label="Email address"
                        autocomplete="email"
                        value="<c:out value='${loginEmail}' />"
                    />

                </label>

                <span class="field-error" id="email-error" aria-live="polite"><c:out value="${emailError}" /></span>

            </div>

            <!-- Password -->
            <div class="form-group">

                <label class="login-field${empty passwordError ? '' : ' is-invalid'}" for="password">

                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <rect x="5" y="10" width="14" height="11" rx="2" />
                        <path d="M8 10V7a4 4 0 0 1 8 0v3" />
                    </svg>

                    <input
                        id="password"
                        type="password"
                        name="password"
                        placeholder="Password"
                        aria-label="Password"
                        autocomplete="current-password"
                    />

                    <!-- Password Toggle -->
                    <button
                        class="password-toggle"
                        type="button"
                        id="passwordToggle"
                        aria-label="Show password"
                    >

                        <svg
                            id="eyeOpen"
                            viewBox="0 0 24 24"
                            aria-hidden="true"
                        >
                            <path d="M2 12.5C3.7 8.1 8 5 12 5s8.3 3.1 10 7.5C20.3 16.9 16 20 12 20S3.7 16.9 2 12.5z" />
                            <circle cx="12" cy="12.5" r="2.5" />
                        </svg>

                        <svg
                            id="eyeShut"
                            viewBox="0 0 24 24"
                            aria-hidden="true"
                            hidden
                        >
                            <path d="M3 3l18 18" />
                            <path d="M10.6 10.6A2 2 0 0 0 12 14a2 2 0 0 0 1.4-.6" />
                            <path d="M9.9 5.2A10.8 10.8 0 0 1 12 5c5 0 9.3 3.1 11 7.5a11.6 11.6 0 0 1-4.1 5.2" />
                            <path d="M6.1 6.1C3.8 7.6 2.1 9.8 1 12.5 2.7 16.9 7 20 12 20c1.2 0 2.3-.2 3.4-.5" />
                        </svg>

                    </button>

                </label>

                <span class="field-error" id="password-error" aria-live="polite"><c:out value="${passwordError}" /></span>

            </div>

            <!-- Form Options -->
            <div class="form-options">

                <label class="remember-me">

                    <input type="checkbox" name="remember" />

                    <span>Remember me</span>

                </label>

                <a href="${ctx}/forgot-password">
                    Forgot password?
                </a>

            </div>

            <!-- Submit -->
            <button class="signin-button" type="submit">
                Sign in
            </button>

        </form>

    </section>

</main>

<!-- JavaScript -->
<script src="${ctx}/assets/js/app.js"></script>

</body>
</html>
