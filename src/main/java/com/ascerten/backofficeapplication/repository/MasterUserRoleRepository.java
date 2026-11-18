
package com.ascerten.backofficeapplication.repository;

import com.ascerten.backofficeapplication.entity.MasterUserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MasterUserRoleRepository
        extends JpaRepository<MasterUserRole, Integer> {

    List<MasterUserRole> findByActiveOrderById(Short active);
}
