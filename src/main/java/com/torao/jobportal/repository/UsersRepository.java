package com.torao.jobportal.repository;

import com.torao.jobportal.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<Users, Integer> {
}
