package com.ascerten.backofficeapplication.entity;

import java.time.OffsetDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "qdsd_details", schema = "public")
public class QdsdDetails {

    @Id
    private Long id;

    @Column(name = "qdsd_id")
    private String qdsdId;

    @Column(name = "public_key")
    private byte[] publicKey;

    @Column(name = "vendor_attestation")
    private byte[] vendorAttestation;

    @Column(name = "qc_data")
    private String qcData;

    @Column(name = "created_date")
    private OffsetDateTime createdDate;

    @Column(name = "updated_date")
    private OffsetDateTime updatedDate;

    @Column(name = "firmware_version")
    private Integer firmwareVersion;

    @Column(name = "lifecycle")
    private String lifecycle;

    @Column(name = "binding_no")
    private Integer bindingNo;

    @Column(name = "keygen_counter")
    private Integer keygenCounter;

    @Column(name = "sign_counter")
    private Integer signCounter;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status", referencedColumnName = "id")
    private MasterQdsdStatus status;

    public Long getId() {
        return id;
    }

    public String getQdsdId() {
        return qdsdId;
    }

    public byte[] getPublicKey() {
        return publicKey;
    }

    public byte[] getVendorAttestation() {
        return vendorAttestation;
    }

    public String getQcData() {
        return qcData;
    }

    public OffsetDateTime getCreatedDate() {
        return createdDate;
    }

    public OffsetDateTime getUpdatedDate() {
        return updatedDate;
    }

    public Integer getFirmwareVersion() {
        return firmwareVersion;
    }

    public String getLifecycle() {
        return lifecycle;
    }

    public Integer getBindingNo() {
        return bindingNo;
    }

    public Integer getKeygenCounter() {
        return keygenCounter;
    }

    public Integer getSignCounter() {
        return signCounter;
    }

    public MasterQdsdStatus getStatus() {
        return status;
    }
}