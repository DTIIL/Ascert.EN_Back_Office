package com.ascerten.backofficeapplication.enums;

public enum SigningStatus {

    REQUESTED(19, "Requested"),
    APPROVED(20, "Approved"),
    DECLINED(21, "Declined"),
    STARTED(22, "Started"),
    SUCCESS(23, "Success"),
    FAILURE(24, "Failed"),
    EXPIRED(25, "Expired"),
    COMPLETION_UNCONFIRMED(26, "Completion Unconfirmed");

    private final int code;
    private final String description;

    SigningStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    // Display label for a stored qdsd_signing_details.status value.
    // Unknown codes are returned unchanged rather than guessed.
    public static String labelFor(String code) {

        if (code == null || code.isBlank()) {
            return code;
        }

        String trimmedCode = code.trim();

        for (SigningStatus status : values()) {
            if (String.valueOf(status.code).equals(trimmedCode)) {
                return status.description;
            }
        }

        return trimmedCode;
    }
}
