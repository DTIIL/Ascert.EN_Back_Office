package com.ascerten.backofficeapplication.dto;

public record ActivityHistoryResponse(
        Long id,
        String dateTime,
        String activity,
        String ipAddress,
        String hostDetails
) {
}