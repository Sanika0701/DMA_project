USE cyber_security;

-- simple query
SELECT * FROM employees
WHERE emp_id BETWEEN 'EMP0030' AND 'EMP0038';

-- aggregate query
SELECT dept_id, COUNT(emp_id) AS employee_count
FROM employee_departments
GROUP BY dept_id;

-- inner join
SELECT e.emp_id, e.name AS employee_name, ed.dept_id
FROM employees e 
INNER JOIN employee_departments ed ON e.emp_id = ed.emp_id
WHERE ed.dept_id = 'DEPT0001';

-- nested query
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE p.threat_id IN (SELECT t.threat_id FROM threat_identification t WHERE t.type = 'Zero-day');
select * from departments;
select * from threat_identification;

-- correlated query
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE EXISTS (
    SELECT 1
    FROM threat_identification t
    WHERE t.threat_id = p.threat_id AND t.type = 'Social Engineering'
);


-- Subqueries in Select and From
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE p.threat_id IN (SELECT threat_id FROM threat_identification WHERE type = 'SQL Injection');


-- Exists query
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE EXISTS (SELECT 1 
              FROM threat_identification t 
              WHERE t.threat_id = p.threat_id 
                AND t.type = 'Ransomware');
                
                
-- set operations (union)
SELECT s.dept_id, 'High-Cost Security' AS activity
FROM security_measures sm
JOIN services s ON sm.service_id = s.service_id
WHERE sm.cost > 7000

UNION

SELECT irt.dept_id, 'Quick Response' AS activity
FROM immediate_response_team irt
WHERE irt.response_time < 30;