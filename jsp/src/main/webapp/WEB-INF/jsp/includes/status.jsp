<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="tone" value="${statusTone.tone(param.value)}" />
<c:choose>
  <c:when test="${not empty tone}">
    <span class="status-pill tone-${tone}"><c:out value="${param.value}" /></span>
  </c:when>
  <c:otherwise>
    <c:out value="${param.value}" />
  </c:otherwise>
</c:choose>
