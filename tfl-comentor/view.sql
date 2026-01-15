CREATE VIEW vw_employer_kpi_summary AS
SELECT
    mr.run_id,
    jr.role_name,
    COUNT(emr.student_id) AS total_candidates,
    SUM(emr.readiness_status = 'Employable') AS employable_count,
    SUM(emr.readiness_status = 'Trainable') AS trainable_count,
    SUM(emr.readiness_status = 'NotReady') AS not_ready_count,
    ROUND(AVG(emr.final_score),2) AS avg_final_score
FROM employer_matching_results emr
JOIN matching_runs mr ON emr.run_id = mr.run_id
JOIN job_roles jr ON mr.job_role_id = jr.job_role_id
GROUP BY mr.run_id, jr.role_name;

CREATE VIEW vw_employer_candidate_ranking AS
SELECT
    emr.run_id,
    s.student_name,
    emr.rank_position,
    emr.match_score,
    emr.final_score,
    emr.readiness_status,
    emr.mandatory_pass
FROM employer_matching_results emr
JOIN students s ON emr.student_id = s.student_id
ORDER BY emr.run_id, emr.rank_position;

CREATE VIEW vw_skill_gap_heatmap AS
SELECT
    emr.run_id,
    sk.skill_name,
    COUNT(*) AS affected_students,
    SUM(sga.gap_severity = 'High') AS high_severity,
    SUM(sga.gap_severity = 'Medium') AS medium_severity,
    SUM(sga.gap_severity = 'Low') AS low_severity
FROM skill_gap_analysis sga
JOIN employer_matching_results emr ON sga.match_id = emr.match_id
JOIN skills sk ON sga.skill_id = sk.skill_id
GROUP BY emr.run_id, sk.skill_name;

CREATE VIEW vw_skill_demand_vs_supply AS
SELECT
    jr.role_name,
    sk.skill_name,
    jrs.min_proficiency_level AS employer_expectation,
    ROUND(AVG(ss.skill_score),2) AS avg_student_score
FROM job_role_skills jrs
JOIN job_roles jr ON jrs.job_role_id = jr.job_role_id
JOIN skills sk ON jrs.skill_id = sk.skill_id
LEFT JOIN student_skills ss ON ss.skill_id = sk.skill_id
GROUP BY jr.role_name, sk.skill_name, jrs.min_proficiency_level;

CREATE VIEW vw_employer_hiring_recommendation AS
SELECT
    emr.run_id,
    s.student_name,
    emr.final_score,
    emr.readiness_status,
    CASE
        WHEN emr.readiness_status = 'Employable' THEN 'Hire'
        WHEN emr.readiness_status = 'Trainable' THEN 'Train'
        ELSE 'Reject'
    END AS employer_action
FROM employer_matching_results emr
JOIN students s ON emr.student_id = s.student_id;

