
package com.ascerten.backofficeapplication.repository;

import com.ascerten.backofficeapplication.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
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
}
