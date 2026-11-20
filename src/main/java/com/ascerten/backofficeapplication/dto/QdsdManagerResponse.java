package com.ascerten.backofficeapplication.dto;


import java.time.LocalDate;

public class QdsdManagerResponse {

    private Long id;
    private String qdsdId;
    private String serialNumber;
    private String assignedUser;
    private String organization;
    private String pairingStatus;
    private String downloadStatus;
    private String qdsdStatus;
    private String lastUsed;
    private LocalDate lastUsedDate;

    public QdsdManagerResponse() {
    }

    public QdsdManagerResponse(
            Long id,
            String qdsdId,
            String serialNumber,
            String assignedUser,
            String organization,
            String pairingStatus,
            String downloadStatus,
            String qdsdStatus,
            String lastUsed) {

        this.id = id;
        this.qdsdId = qdsdId;
        this.serialNumber = serialNumber;
        this.assignedUser = assignedUser;
        this.organization = organization;
        this.pairingStatus = pairingStatus;
        this.downloadStatus = downloadStatus;
        this.qdsdStatus = qdsdStatus;
        this.lastUsed = lastUsed;
    }


    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getQdsdId() { return qdsdId; }
    public void setQdsdId(String qdsdId) { this.qdsdId = qdsdId; }

    public String getSerialNumber() { return serialNumber; }
    public void setSerialNumber(String serialNumber) { this.serialNumber = serialNumber; }

    public String getAssignedUser() { return assignedUser; }
    public void setAssignedUser(String assignedUser) { this.assignedUser = assignedUser; }

    public String getOrganization() { return organization; }
    public void setOrganization(String organization) { this.organization = organization; }

    public String getPairingStatus() { return pairingStatus; }
    public void setPairingStatus(String pairingStatus) { this.pairingStatus = pairingStatus; }

    public String getDownloadStatus() { return downloadStatus; }
    public void setDownloadStatus(String downloadStatus) { this.downloadStatus = downloadStatus; }

    public String getQdsdStatus() { return qdsdStatus; }
    public void setQdsdStatus(String qdsdStatus) { this.qdsdStatus = qdsdStatus; }

    public String getLastUsed() { return lastUsed; }
    public void setLastUsed(String lastUsed) { this.lastUsed = lastUsed; }

    public LocalDate getLastUsedDate() { return lastUsedDate; }
    public void setLastUsedDate(LocalDate lastUsedDate) { this.lastUsedDate = lastUsedDate; }
}
