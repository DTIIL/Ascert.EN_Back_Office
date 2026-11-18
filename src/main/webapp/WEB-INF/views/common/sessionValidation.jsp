<%@ page session="false" %>
<%
    jakarta.servlet.http.HttpSession currentSession =
            request.getSession(false);

    if (currentSession == null ||
        currentSession.getAttribute("loggedInUserId") == null) {

        if (currentSession != null) {
            currentSession.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>