IF EXISTS (SELECT * FROM sys.databases WHERE name = 'jobportal')
BEGIN
	USE master
    DROP DATABASE JobPortal;
END;

CREATE DATABASE JobPortal;
GO

USE JobPortal;
GO

CREATE TABLE users_type (
    user_type_id INT IDENTITY(1,1) NOT NULL,
    user_type_name NVARCHAR(255) NULL,
    PRIMARY KEY (user_type_id)
);

INSERT INTO users_type VALUES (N'Recruiter'), (N'Job Seeker');

CREATE TABLE users (
    user_id INT IDENTITY(1,1) NOT NULL,
    email NVARCHAR(255) NULL,
    is_active BIT NULL,
    password NVARCHAR(255) NULL,
    registration_date DATETIME2(7) NULL,
    user_type_id INT NULL,
    PRIMARY KEY (user_id),
    UNIQUE (email),
    FOREIGN KEY (user_type_id) REFERENCES users_type(user_type_id)
);

CREATE TABLE job_company (
    id INT IDENTITY(1,1) NOT NULL,
    logo NVARCHAR(255) NULL,
    name NVARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE job_location (
    id INT IDENTITY(1,1) NOT NULL,
    city NVARCHAR(255) NULL,
    country NVARCHAR(255) NULL,
    state NVARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE job_seeker_profile (
    user_account_id INT NOT NULL,
    city NVARCHAR(255) NULL,
    country NVARCHAR(255) NULL,
    employment_type NVARCHAR(255) NULL,
    first_name NVARCHAR(255) NULL,
    last_name NVARCHAR(255) NULL,
    profile_photo NVARCHAR(255) NULL,
    resume NVARCHAR(255) NULL,
    state NVARCHAR(255) NULL,
    work_authorization NVARCHAR(255) NULL,
    PRIMARY KEY (user_account_id),
    FOREIGN KEY (user_account_id) REFERENCES users(user_id)
);

CREATE TABLE recruiter_profile (
    user_account_id INT NOT NULL,
    city NVARCHAR(255) NULL,
    company NVARCHAR(255) NULL,
    country NVARCHAR(255) NULL,
    first_name NVARCHAR(255) NULL,
    last_name NVARCHAR(255) NULL,
    profile_photo NVARCHAR(64) NULL,
    state NVARCHAR(255) NULL,
    PRIMARY KEY (user_account_id),
    FOREIGN KEY (user_account_id) REFERENCES users(user_id)
);

CREATE TABLE job_post_activity (
    job_post_id INT IDENTITY(1,1) NOT NULL,
    description_of_job NVARCHAR(MAX) NULL,
    job_title NVARCHAR(255) NULL,
    job_type NVARCHAR(255) NULL,
    posted_date DATETIME2(7) NULL,
    remote NVARCHAR(255) NULL,
    salary NVARCHAR(255) NULL,
    job_company_id INT NULL,
    job_location_id INT NULL,
    posted_by_id INT NULL,
    PRIMARY KEY (job_post_id),
    FOREIGN KEY (job_company_id) REFERENCES job_company(id),
    FOREIGN KEY (job_location_id) REFERENCES job_location(id),
    FOREIGN KEY (posted_by_id) REFERENCES users(user_id)
);

CREATE TABLE job_seeker_save (
    id INT IDENTITY(1,1) NOT NULL,
    job INT NULL,
    user_id INT NULL,
    PRIMARY KEY (id),
    UNIQUE (user_id, job),
    FOREIGN KEY (user_id) REFERENCES job_seeker_profile(user_account_id),
    FOREIGN KEY (job) REFERENCES job_post_activity(job_post_id)
);

CREATE TABLE job_seeker_apply (
    id INT IDENTITY(1,1) NOT NULL,
    apply_date DATETIME2(7) NULL,
    cover_letter NVARCHAR(255) NULL,
    job INT NULL,
    user_id INT NULL,
    PRIMARY KEY (id),
    UNIQUE (user_id, job),
    FOREIGN KEY (job) REFERENCES job_post_activity(job_post_id),
    FOREIGN KEY (user_id) REFERENCES job_seeker_profile(user_account_id)
);

CREATE TABLE skills (
    id INT IDENTITY(1,1) NOT NULL,
    experience_level NVARCHAR(255) NULL,
    name NVARCHAR(255) NULL,
    years_of_experience NVARCHAR(255) NULL,
    job_seeker_profile INT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (job_seeker_profile) REFERENCES job_seeker_profile(user_account_id)
);
