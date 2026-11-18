
package com.ascerten.backofficeapplication.exception;

import jakarta.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger =
            LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(ResourceNotFoundException.class)
    public String handleNotFound(
            ResourceNotFoundException exception,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        redirectAttributes.addFlashAttribute(
                "error",
                exception.getMessage()
        );

        String path = request.getRequestURI()
                .substring(request.getContextPath().length());

        if (path.startsWith("/factoryprovising/")) {
            return "redirect:/factoryprovising";
        }

        if (path.startsWith("/qdsdmanager/")) {
            return "redirect:/qdsdmanager?error=notFound";
        }

        return "redirect:/dashboard";
    }

    @ExceptionHandler(Exception.class)
    public String handleUnexpected(Exception exception, Model model) {

        logger.error("Unexpected application error occurred.", exception);

        model.addAttribute(
                "errorMessage",
                "Something went wrong. Please try again later."
        );

        return "error";
    }
}
