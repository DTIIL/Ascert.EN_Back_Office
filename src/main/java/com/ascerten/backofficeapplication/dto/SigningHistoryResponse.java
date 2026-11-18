package com.ascerten.backofficeapplication.dto;

public record SigningHistoryResponse(
        Long id,
        String signedAt,
        String document,
        String status,
        String signedBy,
        String errorDetails
) {
}