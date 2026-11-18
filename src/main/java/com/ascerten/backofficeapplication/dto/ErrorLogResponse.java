package com.ascerten.backofficeapplication.dto;

public record ErrorLogResponse(
        Long id,
        String dateTime,
        String status,
        String ipAddress,
        String hostDetails
) {
}