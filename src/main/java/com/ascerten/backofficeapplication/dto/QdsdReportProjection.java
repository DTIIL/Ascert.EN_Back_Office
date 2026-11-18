
package com.ascerten.backofficeapplication.dto;

import java.time.Instant;

public interface QdsdReportProjection {

    Long getQdsdRecordId();

    String getQdsdId();

    String getDeviceId();

    String getDeviceModel();

    String getLifecycle();

    String getQdsdStatus();

    String getLastUpdate();
}
