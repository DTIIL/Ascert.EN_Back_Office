<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ascert.EN | Qualified Digital Signing</title>
  <link rel="stylesheet" href="${ctx}/assets/css/fonts.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/globals.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/login.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/jsp-fixes.css" />
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet" />
</head>
<body>
  <main class="login-page">
    <section class="login-card">
      <h1>Reset password</h1>
      <p class="login-description">
        Password reset is not connected yet. Sign in with your account, or ask an administrator.
      </p>
      <a class="signin-button" href="${ctx}/login">Back to sign in</a>
    </section>
  </main>
</body>
</html>
