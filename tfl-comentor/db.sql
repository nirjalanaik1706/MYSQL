-- nirjala---


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    enrollment_date DATE,
    career_goal VARCHAR(100),
    current_job_role_id INT,
    FOREIGN KEY (current_job_role_id) REFERENCES job_roles(job_role_id)
);

CREATE TABLE mentors (
    mentor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    specialization VARCHAR(100)
);

CREATE TABLE job_roles (
    job_role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100),
    level ENUM('Entry', 'Intermediate', 'Senior')
);

CREATE TABLE employers (
    employer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    type ENUM('Startup', 'ProductCompany', 'ServiceCompany', 'Enterprise'),
    industry VARCHAR(100)
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100),
    category VARCHAR(50),
    level_required ENUM('Foundation', 'Intermediate', 'Advanced')
);

CREATE TABLE student_skills (
    student_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    skill_id INT,
    score DECIMAL(5,2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE daily_learning_plans (
    daily_plan_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    plan_date DATE,
    task_description TEXT,
    task_type ENUM('Learn','Practice','Assessment','Reflection','Project'),
    expected_duration_minutes INT,
    completion_status ENUM('Pending','Completed','Skipped') DEFAULT 'Pending',
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE weekly_learning_plans (
    weekly_plan_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    week_start_date DATE,
    week_end_date DATE,
    primary_focus VARCHAR(100),
    secondary_focus VARCHAR(100),
    expected_outcome TEXT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE monthly_milestones (
    milestone_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    milestone_month DATE NOT NULL,
    primary_job_role_id INT NOT NULL,
    milestone_title VARCHAR(150),
    milestone_description TEXT,
    expected_employability_level ENUM('Foundation','Intermediate','JobReady','InterviewReady') NOT NULL,
    milestone_type ENUM('SkillConsolidation','ProjectDelivery','InterviewReadiness','EmployerDriven') NOT NULL,
    generated_by ENUM('System','Mentor') DEFAULT 'System',
    generation_reason VARCHAR(255),
    status ENUM('Planned','InProgress','Achieved','PartiallyAchieved') DEFAULT 'Planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (student_id, milestone_month),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (primary_job_role_id) REFERENCES job_roles(job_role_id)
);

CREATE TABLE milestone_skill_outcomes (
    outcome_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,
    skill_id INT NOT NULL,
    starting_score DECIMAL(5,2),
    expected_score DECIMAL(5,2),
    criticality ENUM('Critical','Important','Supporting') DEFAULT 'Important',
    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE milestone_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,
    project_title VARCHAR(150),
    project_description TEXT,
    tech_stack VARCHAR(255),
    evaluation_type ENUM('MentorReview','AutoAssessment','EmployerReview') DEFAULT 'MentorReview',
    completion_status ENUM('NotStarted','InProgress','Completed') DEFAULT 'NotStarted',
    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);


CREATE TABLE milestone_interview_checkpoints (
    checkpoint_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,
    checkpoint_type ENUM('Technical','HR','SystemDesign','Behavioral'),
    expected_confidence_level INT CHECK (expected_confidence_level BETWEEN 1 AND 5),
    passed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);


CREATE TABLE milestone_evidence (
    evidence_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,
    evidence_type ENUM('AssessmentScore','ProjectLink','MentorRating','EmployerFeedback'),
    evidence_reference VARCHAR(255),
    score DECIMAL(5,2),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);

CREATE TABLE quarterly_career_roadmaps (
    roadmap_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    quarter_label VARCHAR(20),
    quarter_start DATE NOT NULL,
    quarter_end DATE NOT NULL,
    target_job_role_id INT NOT NULL,
    target_employer_type ENUM('Startup','ProductCompany','ServiceCompany','Enterprise'),
    career_theme VARCHAR(150),
    positioning_statement VARCHAR(255),
    expected_employability_status ENUM('Exploration','SkillBuilding','JobReady','InterviewPipeline','Placed') NOT NULL,
    generated_by ENUM('System','Mentor') DEFAULT 'System',
    generation_reason VARCHAR(255),
    status ENUM('Planned','Active','Completed','Revised') DEFAULT 'Planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (student_id, quarter_label),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (target_job_role_id) REFERENCES job_roles(job_role_id)
);

CREATE TABLE roadmap_skill_strategy (
    strategy_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,
    skill_id INT NOT NULL,
    current_level DECIMAL(5,2),
    target_level DECIMAL(5,2),
    investment_priority ENUM('MustWin','StrongSupport','Maintain') NOT NULL,
    rationale VARCHAR(255),
    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE roadmap_project_portfolio (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,
    project_title VARCHAR(150),
    project_type ENUM('Capstone','EmployerSimulation','OpenSource','StartupPrototype'),
    core_skills VARCHAR(255),
    expected_business_value VARCHAR(255),
    completion_status ENUM('Planned','InProgress','Delivered') DEFAULT 'Planned',
    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);

CREATE TABLE roadmap_interview_pipeline (
    pipeline_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,
    interview_type ENUM('DSA','Backend','Frontend','SystemDesign','HR','Behavioral'),
    readiness_level ENUM('NotReady','Practicing','MockCleared','EmployerCleared') DEFAULT 'NotReady',
    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);

CREATE TABLE roadmap_risk_flags (
    risk_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,
    risk_type ENUM('LowConsistency','SkillPlateau','ConfidenceGap','ProjectDelay','InterviewAvoidance'),
    severity ENUM('Low','Medium','High'),
    mitigation_plan TEXT,
    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);

CREATE TABLE placement_probability_scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    prediction_window ENUM('30Days','60Days','90Days') NOT NULL,
    probability_score DECIMAL(5,2),
    confidence_level ENUM('Low','Medium','High'),
    dominant_factors VARCHAR(255),
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE placement_model_features (
    feature_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    avg_skill_score DECIMAL(5,2),
    critical_skill_coverage DECIMAL(5,2),
    skill_growth_velocity DECIMAL(5,2),
    project_score DECIMAL(5,2),
    evidence_ratio DECIMAL(5,2),
    consistency_score DECIMAL(5,2),
    streak_days INT,
    interview_readiness_score DECIMAL(5,2),
    mentor_confidence_score DECIMAL(5,2),
    employer_fit_score DECIMAL(5,2),
    label_placed BOOLEAN,
    snapshot_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE mentor_interventions (
    intervention_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    milestone_id INT,
    roadmap_id INT,
    action_type ENUM('MockInterview','ProjectReview','ConfidenceCoaching','SkillFocus','Other'),
    description TEXT,
    expected_impact DECIMAL(5,2), -- % probability gain
    actual_impact DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id),
    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);

CREATE TABLE employer_matching (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    employer_id INT NOT NULL,
    job_role_id INT NOT NULL,
    fit_score DECIMAL(5,2),
    placement_probability DECIMAL(5,2),
    status ENUM('Shortlisted','InterviewScheduled','Placed','Rejected') DEFAULT 'Shortlisted',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (employer_id) REFERENCES employers(employer_id),
    FOREIGN KEY (job_role_id) REFERENCES job_roles(job_role_id)
);











CREATE TABLE employers (
    employer_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_name VARCHAR(150) NOT NULL,
    industry VARCHAR(100),
    company_size ENUM('Startup','SME','Enterprise'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE job_roles (
    job_role_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT NOT NULL,
    role_name VARCHAR(150) NOT NULL,
    experience_level ENUM('Fresher','Junior','Mid','Senior'),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES employers(employer_id)
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE job_role_skills (
    job_role_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    job_role_id INT NOT NULL,
    skill_id INT NOT NULL,
    min_proficiency_level ENUM('Beginner','Intermediate','Strong','Advanced'),
    weight DECIMAL(5,2),        -- % contribution
    is_mandatory BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (job_role_id) REFERENCES job_roles(job_role_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(150),
    email VARCHAR(150),
    graduation_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE student_skills (
    student_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_score DECIMAL(5,2),          -- 0–100
    proficiency_level ENUM('Beginner','Intermediate','Strong','Advanced'),
    consistency_index DECIMAL(5,2),    -- stability over time
    last_updated TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_id INT NOT NULL,
    assessment_type ENUM('MCQ','Coding','CaseStudy','Debugging'),
    max_score INT,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE student_assessment_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    assessment_id INT NOT NULL,
    score DECIMAL(5,2),
    attempted_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(150),
    complexity_level ENUM('Low','Medium','High'),
    skill_id INT NOT NULL,
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE student_projects (
    student_project_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    mentor_rating DECIMAL(5,2),
    completed_on DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE matching_runs (
    run_id INT AUTO_INCREMENT PRIMARY KEY,
    job_role_id INT NOT NULL,
    simulation_mode ENUM('Practice','PrePlacement','HiringDay'),
    executed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_role_id) REFERENCES job_roles(job_role_id)
);

CREATE TABLE employer_matching_results (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    run_id INT NOT NULL,
    student_id INT NOT NULL,
    mandatory_pass BOOLEAN,
    match_score DECIMAL(5,2),
    final_score DECIMAL(5,2),
    readiness_status ENUM('Employable','Trainable','NotReady'),
    rank_position INT,
    FOREIGN KEY (run_id) REFERENCES matching_runs(run_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE skill_gap_analysis (
    gap_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT NOT NULL,
    skill_id INT NOT NULL,
    required_level ENUM('Beginner','Intermediate','Strong','Advanced'),
    student_level ENUM('Beginner','Intermediate','Strong','Advanced'),
    gap_severity ENUM('Low','Medium','High'),
    FOREIGN KEY (match_id) REFERENCES employer_matching_results(match_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE recovery_recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    gap_id INT NOT NULL,
    recommendation_text TEXT,
    expected_days INT,
    FOREIGN KEY (gap_id) REFERENCES skill_gap_analysis(gap_id)
);


-- sahil ---


CREATE TABLE monthly_milestones (
    milestone_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,

    milestone_month DATE NOT NULL, -- e.g. 2025-03-01

    primary_job_role_id INT NOT NULL,

    milestone_title VARCHAR(150),
    milestone_description TEXT,

    expected_employability_level ENUM(
        'Foundation',
        'Intermediate',
        'JobReady',
        'InterviewReady'
    ) NOT NULL,

    milestone_type ENUM(
        'SkillConsolidation',
        'ProjectDelivery',
        'InterviewReadiness',
        'EmployerDriven'
    ) NOT NULL,

    generated_by ENUM(
        'System',
        'Mentor'
    ) DEFAULT 'System',

    generation_reason VARCHAR(255),

    status ENUM(
        'Planned',
        'InProgress',
        'Achieved',
        'PartiallyAchieved'
    ) DEFAULT 'Planned',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (student_id, milestone_month),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (primary_job_role_id) REFERENCES job_roles(job_role_id)
);



CREATE TABLE milestone_skill_outcomes (
    outcome_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,
    skill_id INT NOT NULL,

    starting_score DECIMAL(5,2),
    expected_score DECIMAL(5,2),

    criticality ENUM(
        'Critical',
        'Important',
        'Supporting'
    ) DEFAULT 'Important',

    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);



CREATE TABLE milestone_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,

    project_title VARCHAR(150),
    project_description TEXT,

    tech_stack VARCHAR(255),

    evaluation_type ENUM(
        'MentorReview',
        'AutoAssessment',
        'EmployerReview'
    ) DEFAULT 'MentorReview',

    completion_status ENUM(
        'NotStarted',
        'InProgress',
        'Completed'
    ) DEFAULT 'NotStarted',

    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);



CREATE TABLE milestone_interview_checkpoints (
    checkpoint_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,

    checkpoint_type ENUM(
        'Technical',
        'HR',
        'SystemDesign',
        'Behavioral'
    ),

    expected_confidence_level INT CHECK (expected_confidence_level BETWEEN 1 AND 5),

    passed BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);




CREATE TABLE milestone_evidence (
    evidence_id INT AUTO_INCREMENT PRIMARY KEY,
    milestone_id INT NOT NULL,

    evidence_type ENUM(
        'AssessmentScore',
        'ProjectLink',
        'MentorRating',
        'EmployerFeedback'
    ),

    evidence_reference VARCHAR(255),
    score DECIMAL(5,2),

    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (milestone_id) REFERENCES monthly_milestones(milestone_id)
);


CREATE TABLE quarterly_career_roadmaps (
    roadmap_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,

    quarter_label VARCHAR(20), -- e.g. Q2-2025
    quarter_start DATE NOT NULL,
    quarter_end DATE NOT NULL,

    target_job_role_id INT NOT NULL,
    target_employer_type ENUM(
        'Startup',
        'ProductCompany',
        'ServiceCompany',
        'Enterprise'
    ),

    career_theme VARCHAR(150),
    positioning_statement VARCHAR(255),

    expected_employability_status ENUM(
        'Exploration',
        'SkillBuilding',
        'JobReady',
        'InterviewPipeline',
        'Placed'
    ) NOT NULL,

    generated_by ENUM(
        'System',
        'Mentor'
    ) DEFAULT 'System',

    generation_reason VARCHAR(255),

    status ENUM(
        'Planned',
        'Active',
        'Completed',
        'Revised'
    ) DEFAULT 'Planned',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (student_id, quarter_label),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (target_job_role_id) REFERENCES job_roles(job_role_id)
);


CREATE TABLE roadmap_skill_strategy (
    strategy_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,
    skill_id INT NOT NULL,

    current_level DECIMAL(5,2),
    target_level DECIMAL(5,2),

    investment_priority ENUM(
        'MustWin',
        'StrongSupport',
        'Maintain'
    ) NOT NULL,

    rationale VARCHAR(255),

    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);



CREATE TABLE roadmap_project_portfolio (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,

    project_title VARCHAR(150),
    project_type ENUM(
        'Capstone',
        'EmployerSimulation',
        'OpenSource',
        'StartupPrototype'
    ),

    core_skills VARCHAR(255),
    expected_business_value VARCHAR(255),

    completion_status ENUM(
        'Planned',
        'InProgress',
        'Delivered'
    ) DEFAULT 'Planned',

    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);



CREATE TABLE roadmap_interview_pipeline (
    pipeline_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,

    interview_type ENUM(
        'DSA',
        'Backend',
        'Frontend',
        'SystemDesign',
        'HR',
        'Behavioral'
    ),

    readiness_level ENUM(
        'NotReady',
        'Practicing',
        'MockCleared',
        'EmployerCleared'
    ) DEFAULT 'NotReady',

    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);



CREATE TABLE roadmap_risk_flags (
    risk_id INT AUTO_INCREMENT PRIMARY KEY,
    roadmap_id INT NOT NULL,

    risk_type ENUM(
        'LowConsistency',
        'SkillPlateau',
        'ConfidenceGap',
        'ProjectDelay',
        'InterviewAvoidance'
    ),

    severity ENUM(
        'Low',
        'Medium',
        'High'
    ),

    mitigation_plan TEXT,

    FOREIGN KEY (roadmap_id) REFERENCES quarterly_career_roadmaps(roadmap_id)
);

-- sanika---

CREATE TABLE daily_learning_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    plan_date DATE NOT NULL,

    target_job_role_id INT,
    focus_skill_id INT NOT NULL,

    plan_type ENUM(
        'Recovery',
        'Growth',
        'Reinforcement'
    ) NOT NULL,

    estimated_minutes INT DEFAULT 45,

    generated_by ENUM(
        'System',
        'Mentor'
    ) DEFAULT 'System',

    generation_reason VARCHAR(255),

    status ENUM(
        'Planned',
        'InProgress',
        'Completed',
        'Missed'
    ) DEFAULT 'Planned',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (student_id, plan_date),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (focus_skill_id) REFERENCES skills(skill_id),
    FOREIGN KEY (target_job_role_id) REFERENCES job_roles(job_role_id)
);



CREATE TABLE daily_plan_tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,

    task_type ENUM(
        'Learn',
        'Practice',
        'Project',
        'Assessment',
        'Confidence'
    ) NOT NULL,

    task_title VARCHAR(150),
    task_description TEXT,

    estimated_minutes INT,
    task_order INT,

    completion_status ENUM(
        'Pending',
        'Done',
        'Skipped'
    ) DEFAULT 'Pending',

    completed_at TIMESTAMP NULL,

    FOREIGN KEY (plan_id) REFERENCES daily_learning_plans(plan_id)
);


CREATE TABLE daily_plan_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,

    started_at TIMESTAMP,
    finished_at TIMESTAMP,

    completion_percentage DECIMAL(5,2),
    student_feedback VARCHAR(255),

    FOREIGN KEY (plan_id) REFERENCES daily_learning_plans(plan_id)
);



CREATE TABLE learning_streaks (
    student_id INT PRIMARY KEY,
    current_streak INT DEFAULT 0,
    longest_streak INT DEFAULT 0,
    last_completed_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE mentor_plan_overrides (
    override_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    mentor_id INT,
    override_reason TEXT,
    overridden_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES daily_learning_plans(plan_id)
);


CREATE TABLE mentor_plan_overrides (
    override_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    mentor_id INT,
    override_reason TEXT,
    overridden_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES daily_learning_plans(plan_id)
);


CREATE TABLE placement_probability_scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,

    prediction_window ENUM(
        '30Days',
        '60Days',
        '90Days'
    ) NOT NULL,

    probability_score DECIMAL(5,2), -- 0 to 100

    confidence_level ENUM(
        'Low',
        'Medium',
        'High'
    ),

    dominant_factors VARCHAR(255),

    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


CREATE TABLE placement_model_features (
    feature_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,

    avg_skill_score DECIMAL(5,2),
    critical_skill_coverage DECIMAL(5,2),
    skill_growth_velocity DECIMAL(5,2),

    project_score DECIMAL(5,2),
    evidence_ratio DECIMAL(5,2),

    consistency_score DECIMAL(5,2),
    streak_days INT,

    interview_readiness_score DECIMAL(5,2),

    mentor_confidence_score DECIMAL(5,2),

    employer_fit_score DECIMAL(5,2),

    label_placed BOOLEAN, -- for ML training

    snapshot_date DATE,

    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


CREATE TABLE weekly_learning_plans (
    weekly_plan_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,

    week_start_date DATE NOT NULL,
    week_end_date DATE NOT NULL,

    primary_focus_skill_id INT NOT NULL,
    secondary_focus_skill_id INT,

    target_job_role_id INT,

    weekly_goal VARCHAR(255),

    total_estimated_minutes INT DEFAULT 300,

    adaptation_type ENUM(
        'Recovery',
        'Acceleration',
        'Stabilization',
        'EmployerDriven'
    ) NOT NULL,

    generated_by ENUM(
        'System',
        'Mentor'
    ) DEFAULT 'System',

    adaptation_reason VARCHAR(255),

    status ENUM(
        'Planned',
        'Active',
        'Completed',
        'PartiallyCompleted'
    ) DEFAULT 'Planned',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (student_id, week_start_date),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (primary_focus_skill_id) REFERENCES skills(skill_id),
    FOREIGN KEY (secondary_focus_skill_id) REFERENCES skills(skill_id),
    FOREIGN KEY (target_job_role_id) REFERENCES job_roles(job_role_id)
);



CREATE TABLE weekly_plan_skill_targets (
    target_id INT AUTO_INCREMENT PRIMARY KEY,
    weekly_plan_id INT NOT NULL,
    skill_id INT NOT NULL,

    starting_score DECIMAL(5,2),
    expected_score DECIMAL(5,2),

    priority ENUM(
        'High',
        'Medium',
        'Low'
    ) DEFAULT 'Medium',

    FOREIGN KEY (weekly_plan_id) REFERENCES weekly_learning_plans(weekly_plan_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);


CREATE TABLE weekly_plan_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    weekly_plan_id INT NOT NULL,

    project_title VARCHAR(150),
    project_description TEXT,

    related_skills VARCHAR(255),

    expected_outcome VARCHAR(255),

    completion_status ENUM(
        'NotStarted',
        'InProgress',
        'Completed'
    ) DEFAULT 'NotStarted',

    FOREIGN KEY (weekly_plan_id) REFERENCES weekly_learning_plans(weekly_plan_id)
);


CREATE TABLE weekly_plan_assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    weekly_plan_id INT NOT NULL,

    assessment_type ENUM(
        'Quiz',
        'Coding',
        'SystemDesign',
        'MockInterview'
    ),

    focus_skill_id INT,
    scheduled_day ENUM(
        'Mon','Tue','Wed','Thu','Fri','Sat'
    ),

    FOREIGN KEY (weekly_plan_id) REFERENCES weekly_learning_plans(weekly_plan_id)
);


CREATE TABLE weekly_plan_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    weekly_plan_id INT NOT NULL,

    student_reflection TEXT,
    mentor_feedback TEXT,

    confidence_level INT CHECK (confidence_level BETWEEN 1 AND 5),

    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (weekly_plan_id) REFERENCES weekly_learning_plans(weekly_plan_id)
);








