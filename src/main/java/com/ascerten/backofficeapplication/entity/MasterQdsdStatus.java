package com.ascerten.backofficeapplication.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "master_qdsd_status", schema = "public")
public class MasterQdsdStatus {

    @Id
    private Short id;

    @Column(nullable = false, length = 50)
    private String status;

    @Column(nullable = false)
    private Short active;

    public Short getId() {
        return id;
    }

    public String getStatus() {
        return status;
    }

    public Short getActive() {
        return active;
    }

    public void setId(Short id) {
        this.id = id;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setActive(Short active) {
        this.active = active;
    }
}