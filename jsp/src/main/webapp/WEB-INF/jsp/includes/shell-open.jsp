<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Ascert.EN | Qualified Digital Signing</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="${ctx}/assets/css/fonts.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/globals.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/grid.css" />
  <link rel="stylesheet" href="${ctx}/assets/css/jsp-fixes.css" />
  <c:forEach var="sheet" items="${stylesheets}">
    <link rel="stylesheet" href="${ctx}/assets/css/${fn:escapeXml(sheet)}" />
  </c:forEach>
</head>
<body>
  <section class="app-shell">
    <%@ include file="/WEB-INF/jsp/includes/header.jsp" %>
    <div class="app-body">
      <%@ include file="/WEB-INF/jsp/includes/sidenav.jsp" %>
      <div class="app-content">
