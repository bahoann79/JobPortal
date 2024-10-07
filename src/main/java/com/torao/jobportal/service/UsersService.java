package com.torao.jobportal.service;

import com.torao.jobportal.entity.JobSeekerProfile;
import com.torao.jobportal.entity.RecruiterProfile;
import com.torao.jobportal.entity.Users;
import com.torao.jobportal.repository.JobSeekerProfileRepository;
import com.torao.jobportal.repository.RecruiterProfileRepository;
import com.torao.jobportal.repository.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
public class UsersService {

    private final UsersRepository usersRepository;
    private final JobSeekerProfileRepository jobSeekerProfileRepository;
    private final RecruiterProfileRepository recruiterProfileRepository;

    @Autowired
    public UsersService(UsersRepository usersRepository, JobSeekerProfileRepository jobSeekerProfileRepository,
                        RecruiterProfileRepository recruiterProfileRepository) {
        this.usersRepository = usersRepository;
        this.jobSeekerProfileRepository = jobSeekerProfileRepository;
        this.recruiterProfileRepository = recruiterProfileRepository;
    }

    public Users addNew(Users users){
        users.setActive(true);
        users.setRegistrationDate(new Date(System.currentTimeMillis()));
        Users savedUser = usersRepository.save(users);
        int userTypeId = users.getUsersTypeId().getUserTypeId();
        if(userTypeId == 1){
            recruiterProfileRepository.save(new RecruiterProfile(savedUser));
        }else {
            jobSeekerProfileRepository.save(new JobSeekerProfile(savedUser));
        }

        return savedUser;
    }

    public Optional<Users> getUserByEmail(String email){
        return usersRepository.findByEmail(email);
    }

}
