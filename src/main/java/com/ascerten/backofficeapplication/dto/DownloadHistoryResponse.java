
package com.ascerten.backofficeapplication.dto;

public record DownloadHistoryResponse(

        Long id,
        String dateTime,
        String status,
        String caName,
        String downloadedBy,
        Long attempt,
        String errorDetails

) {
}
