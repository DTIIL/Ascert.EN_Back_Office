
package com.ascerten.backofficeapplication.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnTransformer;
import jakarta.validation.constraints.Size;

import java.time.OffsetDateTime;

@Entity
@Table(name = "users_details", schema = "public")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 100, message = "Name cannot exceed 100 characters")
    @Column(name = "name", length = 100)
    private String name;

    @Size(max = 150, message = "Email ID cannot exceed 150 characters")
    @Column(name = "email_id", length = 150)
    private String emailId;

    @Column(name = "mobile_number")
    private Long mobileNumber;

    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "designation")
    private String designation;

    @Column(name = "status", nullable = false)
    private Short status;

    @Column(name = "user_role", nullable = false)
    private Integer userRole;

    @Column(name = "created_date", nullable = false)
    private OffsetDateTime createdDate;

    @Column(name = "created_ip", nullable = false)
    @ColumnTransformer(
            read = "CAST(created_ip AS varchar)",
            write = "?::inet"
    )
    private String createdIp;

    @Column(name = "updated_date")
    private OffsetDateTime updatedDate;

    @Column(name = "updated_ip")
    @ColumnTransformer(
            read = "CAST(updated_ip AS varchar)",
            write = "?::inet"
    )
    private String updatedIp;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public Long getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(Long mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public Short getStatus() {
        return status;
    }

    public void setStatus(Short status) {
        this.status = status;
    }

    public Integer getUserRole() {
        return userRole;
    }

    public void setUserRole(Integer userRole) {
        this.userRole = userRole;
    }

    public OffsetDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(OffsetDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedIp() {
        return createdIp;
    }

    public void setCreatedIp(String createdIp) {
        this.createdIp = createdIp;
    }

    public OffsetDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(OffsetDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getUpdatedIp() {
        return updatedIp;
    }

    public void setUpdatedIp(String updatedIp) {
        this.updatedIp = updatedIp;
    }
}
