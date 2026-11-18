package com.ascert.backoffice.support;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class StatusTone {

    private static final Map<String, String> TONES = tones();

    public String tone(Object value) {
        if (value == null) {
            return "";
        }
        String tone = TONES.get(String.valueOf(value));
        return tone == null ? "" : tone;
    }

    private static Map<String, String> tones() {
        Map<String, String> tones = new HashMap<String, String>();
        put(tones, "success",
                "Paired", "Downloaded", "Ready", "Active", "Completed", "Complete", "Success", "Valid");
        put(tones, "warning", "Pending", "Suspended", "In Progress");
        put(tones, "neutral", "Waiting for DSC", "Inactive");
        put(tones, "danger", "Not Paired", "Not Downloaded", "Download Failed", "Error", "Failed");
        return Collections.unmodifiableMap(tones);
    }

    private static void put(Map<String, String> tones, String tone, String... statuses) {
        for (String status : statuses) {
            tones.put(status, tone);
        }
    }
}
