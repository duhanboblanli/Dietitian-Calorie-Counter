package com.tez.dieticianpatientapp.repository;

import com.tez.dieticianpatientapp.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepository extends JpaRepository<User,Long> {
    Optional<User> findByTckn(String tckn);
}
