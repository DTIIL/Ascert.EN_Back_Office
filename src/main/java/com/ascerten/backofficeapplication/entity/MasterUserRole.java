
package com.ascerten.backofficeapplication.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "master_user_role", schema = "public")
public class MasterUserRole {

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "user_role")
    private String userRole;

    @Column(name = "active")
    private Short active;

    public Integer getId() {
        return id;
    }

    public String getUserRole() {
        return userRole;
    }

    public Short getActive() {
        return active;
    }
}
