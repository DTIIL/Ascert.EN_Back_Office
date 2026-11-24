
package com.ascerten.backofficeapplication.repository;

import com.ascerten.backofficeapplication.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmailIdIgnoreCase(String emailId);

    boolean existsByEmailIdIgnoreCase(String emailId);

    boolean existsByEmailIdIgnoreCaseAndIdNot(
            String emailId,
            Long id
    );

    // Check whether an active user already exists with the given email.
    boolean existsByEmailIdIgnoreCaseAndStatus(
            String emailId,
            Short status
    );

    // Exclude the current user while checking for another active user.
    boolean existsByEmailIdIgnoreCaseAndStatusAndIdNot(
            String emailId,
            Short status,
            Long id
    );

    boolean existsByUsernameIgnoreCase(String username);

    boolean existsByUsernameIgnoreCaseAndIdNot(String username, Long id);

    // Transaction-level advisory lock. Concurrent requests for the same key
    // wait here until the other transaction commits or rolls back, so the
    // username duplicate check and the save cannot interleave.
    @Query(value = "SELECT 1 FROM (SELECT pg_advisory_xact_lock(hashtext(:key)) AS locked) AS lock_result",
            nativeQuery = true)
    Integer lockByKey(@Param("key") String key);
}
