INSERT INTO employers (employer_name, industry, company_size) VALUES
('TechNova Solutions', 'Software Services', 'SME'),
('CloudVerse Pvt Ltd', 'Cloud & DevOps', 'Startup');

INSERT INTO employers (employer_name, industry, company_size) VALUES
('TechNova Solutions', 'Software Services', 'SME'),
('CloudVerse Pvt Ltd', 'Cloud & DevOps', 'Startup');

INSERT INTO skills (skill_name, category) VALUES
('C# Programming', 'Backend'),
('Java Programming', 'Backend'),
('OOP Concepts', 'Core Programming'),
('REST API', 'Backend'),
('SQL', 'Database'),
('Git', 'Tools'),
('HTML/CSS', 'Frontend'),
('Cloud Basics', 'Cloud'),
('Linux Fundamentals', 'OS'),
('Problem Solving', 'Core Skill');

INSERT INTO job_role_skills 
(job_role_id, skill_id, min_proficiency_level, weight, is_mandatory) VALUES
(1, 1, 'Intermediate', 20, TRUE),   -- C#
(1, 3, 'Strong', 15, TRUE),         -- OOP
(1, 4, 'Intermediate', 15, TRUE),   -- REST
(1, 5, 'Intermediate', 15, TRUE),   -- SQL
(1, 6, 'Beginner', 10, TRUE),       -- Git
(1, 7, 'Beginner', 10, FALSE),      -- HTML/CSS
(1, 10,'Strong', 15, TRUE);         -- Problem Solving

INSERT INTO job_role_skills 
(job_role_id, skill_id, min_proficiency_level, weight, is_mandatory) VALUES
(2, 8, 'Intermediate', 30, TRUE),   -- Cloud Basics
(2, 9, 'Intermediate', 25, TRUE),   -- Linux
(2, 6, 'Beginner', 15, TRUE),       -- Git
(2, 10,'Strong', 30, TRUE);         -- Problem Solving

INSERT INTO students (student_name, email, graduation_year) VALUES
('Amit Patil', 'amit@tfl.com', 2025),
('Sneha Kulkarni', 'sneha@tfl.com', 2025),
('Rahul Deshmukh', 'rahul@tfl.com', 2024);

INSERT INTO student_skills 
(student_id, skill_id, skill_score, proficiency_level, consistency_index, last_updated) VALUES

-- Amit
(1, 1, 78, 'Intermediate', 82, NOW()),
(1, 3, 85, 'Strong', 80, NOW()),
(1, 4, 72, 'Intermediate', 75, NOW()),
(1, 5, 60, 'Intermediate', 65, NOW()),
(1, 6, 70, 'Beginner', 78, NOW()),
(1, 10,88, 'Strong', 85, NOW()),

-- Sneha
(2, 1, 65, 'Intermediate', 70, NOW()),
(2, 3, 75, 'Strong', 72, NOW()),
(2, 4, 68, 'Intermediate', 70, NOW()),
(2, 5, 55, 'Beginner', 60, NOW()),
(2, 7, 80, 'Strong', 85, NOW()),
(2, 10,70, 'Intermediate', 68, NOW()),

-- Rahul (Cloud)
(3, 8, 82, 'Intermediate', 80, NOW()),
(3, 9, 78, 'Intermediate', 75, NOW()),
(3, 6, 65, 'Beginner', 70, NOW()),
(3, 10,85, 'Strong', 88, NOW());

INSERT INTO assessments (skill_id, assessment_type, max_score) VALUES
(1, 'Coding', 100),
(3, 'MCQ', 50),
(4, 'CaseStudy', 100),
(5, 'SQL', 100),
(10,'ProblemSolving', 100);

INSERT INTO student_assessment_results 
(student_id, assessment_id, score) VALUES
(1, 1, 78),
(1, 3, 40),
(2, 1, 65),
(2, 3, 38),
(3, 5, 85);

INSERT INTO projects (project_name, complexity_level, skill_id) VALUES
('RESTful API Service', 'Medium', 4),
('SQL Optimization Project', 'High', 5),
('Cloud VM Setup', 'Medium', 8);

INSERT INTO student_projects 
(student_id, project_id, mentor_rating, completed_on) VALUES
(1, 1, 8.5, '2025-01-10'),
(1, 2, 7.0, '2025-01-20'),
(3, 3, 9.0, '2024-12-15');

INSERT INTO matching_runs (job_role_id, simulation_mode) VALUES
(1, 'PrePlacement'),
(2, 'Practice');

INSERT INTO employer_matching_results 
(run_id, student_id, mandatory_pass, match_score, final_score, readiness_status, rank_position) VALUES

-- Full-Stack Role
(1, 1, TRUE, 78.5, 82.0, 'Employable', 1),
(1, 2, FALSE, 65.0, 60.0, 'Trainable', 2),

-- Cloud Role
(2, 3, TRUE, 85.0, 88.0, 'Employable', 1);

INSERT INTO skill_gap_analysis 
(match_id, skill_id, required_level, student_level, gap_severity) VALUES
(2, 5, 'Intermediate', 'Beginner', 'High'),
(2, 4, 'Intermediate', 'Beginner', 'Medium');

INSERT INTO recovery_recommendations 
(gap_id, recommendation_text, expected_days) VALUES
(1, 'Complete SQL joins and indexing mini-projects', 14),
(2, 'Build REST API with pagination & filters', 10);

