
package com.ascerten.backofficeapplication.dto;

public interface ReportRowProjection {

    Long getRecordId();
    String getQdsdId();
    String getDeviceId();
    String getDeviceModel();
    String getSubscriberName();
    String getOrganization();
    String getActionName();
    String getEventDate();
    String getStatus();
    String getSerialNumber();
    String getCertificateType();
    String getTransactionId();
    String getDocumentName();
    String getSigningPlatform();
    String getSignedDate();
    String getFailureReason();
}
