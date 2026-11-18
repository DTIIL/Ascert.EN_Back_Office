package com.ascerten.backofficeapplication.enums;

public enum SigningStatus {

    SUCCESS(23, "Success"),
    FAILURE(24, "Failure");

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
}