
package com.ascerten.backofficeapplication.enums;

public enum SubscriberStatus {

    ACTIVE(1, "Active"),
    INACTIVE(2, "Inactive"),
    PENDING(3, "Pending");

    private final int code;
    private final String description;

    SubscriberStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public static SubscriberStatus fromCode(int code) {
        for (SubscriberStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException(
                "Unknown subscriber status code: " + code
        );
    }
}
