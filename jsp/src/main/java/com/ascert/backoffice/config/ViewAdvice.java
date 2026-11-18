package com.ascert.backoffice.config;

import com.ascert.backoffice.support.StatusTone;
import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class ViewAdvice {

    private final StatusTone statusTone = new StatusTone();

    @ModelAttribute("statusTone")
    public StatusTone statusTone() {
        return statusTone;
    }

    @ModelAttribute("stylesheets")
    public List<String> stylesheets() {
        return Collections.emptyList();
    }

    @ModelAttribute("currentPath")
    public String currentPath(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        if (contextPath != null && !contextPath.isEmpty() && uri.startsWith(contextPath)) {
            uri = uri.substring(contextPath.length());
        }
        return uri.isEmpty() ? "/" : uri;
    }
}
