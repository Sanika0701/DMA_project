CREATE DATABASE cyber_security;
USE cyber_security;

SET foreign_key_checks = 1;

-- 1. Department Table
CREATE TABLE departments (
    dept_id VARCHAR(10) PRIMARY KEY,
    dept_head VARCHAR(100)
);

-- 2. Employee Table
CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    ssn CHAR(9) UNIQUE,
    name VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE employee_departments (
    emp_id VARCHAR(10),
    dept_id VARCHAR(10),
    PRIMARY KEY (emp_id, dept_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
drop table solves;
CREATE TABLE employee_managers (
    emp_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- 3. Client Table
CREATE TABLE clients (
    client_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255)
);

CREATE TABLE client_employees (
    client_id VARCHAR(10),
    emp_id VARCHAR(10),
    PRIMARY KEY (client_id, emp_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Threat Identification Table
CREATE TABLE threat_identification (
    threat_id VARCHAR(10) PRIMARY KEY,
    type ENUM('Malware', 'Phishing', 'DDoS', 'SQL Injection', 'Zero-day', 'Ransomware', 'Social Engineering', 'Man-in-the-middle'),
    security_level ENUM('LOW', 'MEDIUM', 'HIGH')
);

-- Problems Table (without threat_id foreign key for now)
CREATE TABLE problems (
    problem_id VARCHAR(10) PRIMARY KEY
);

-- Services Table (without problem_id foreign key for now)
CREATE TABLE services (
    service_id VARCHAR(10) PRIMARY KEY,
    dept_id VARCHAR(10),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Alter Problems Table to Add Foreign Key
ALTER TABLE problems
ADD COLUMN threat_id VARCHAR(10),
ADD CONSTRAINT fk_threat_id FOREIGN KEY (threat_id) REFERENCES threat_identification(threat_id);

-- Alter Services Table to Add Foreign Key
ALTER TABLE services
ADD COLUMN problem_id VARCHAR(10),
ADD CONSTRAINT fk_problem_id FOREIGN KEY (problem_id) REFERENCES problems(problem_id);

-- Alter Threat Identification Table to Add Foreign Keys
ALTER TABLE threat_identification
ADD COLUMN problem_id VARCHAR(10),
ADD COLUMN service_id VARCHAR(10),
ADD CONSTRAINT fk_problem_id_in_threat FOREIGN KEY (problem_id) REFERENCES problems(problem_id),
ADD CONSTRAINT fk_service_id FOREIGN KEY (service_id) REFERENCES services(service_id);


-- 10. Security Measures Table
CREATE TABLE security_measures (
    service_id VARCHAR(10),
    sec_type ENUM('Firewall', 'Encryption', 'Authentication', 'Access Control', 'Monitoring', 'Backup', 'Patch Management', 'Training'),
    cost DECIMAL(10, 2),
    complexity ENUM('LOW', 'MEDIUM', 'HIGH'),
    PRIMARY KEY (service_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- 11. Immediate Response Team Table
CREATE TABLE immediate_response_team (
    dept_id VARCHAR(10) PRIMARY KEY,
    response_time INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 12. Skill Level Table
CREATE TABLE skill_level (
    dept_id VARCHAR(10) PRIMARY KEY,
    skill_level ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert'),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 13. Threat Analysis Table
CREATE TABLE threat_analysis (
    dept_id VARCHAR(10) PRIMARY KEY,
    methodology ENUM('Qualitative', 'Quantitative', 'Hybrid'),
    technology ENUM('AI', 'Machine Learning', 'Behavioral Analysis', 'Heuristics'),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 14. Threat Solutions Table
CREATE TABLE threat_solutions (
    dept_id VARCHAR(10) PRIMARY KEY,
    solution_type ENUM('Patch Management', 'Threat Intelligence', 'Vulnerability Assessment'),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 6. Solves Table
CREATE TABLE solves (
    problem_id VARCHAR(10),
    service_id VARCHAR(10),
    PRIMARY KEY (problem_id, service_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- 7. Faces Table
CREATE TABLE faces (
    client_id VARCHAR(10),
    problem_id VARCHAR(10),
    status ENUM('OPEN', 'IN_PROGRESS', 'PENDING', 'RESOLVED', 'CLOSED'),
    PRIMARY KEY (client_id, problem_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

-- 8. Handles Table
CREATE TABLE handles (
    dept_id VARCHAR(10),
    problem_id VARCHAR(10),
    level ENUM('LOW', 'MEDIUM', 'HIGH'),
    PRIMARY KEY (dept_id, problem_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);



select * from departments;
select * from employees;
select * from employee_departments; 
select * from employee_managers;
select * from clients;
select * from client_employees;
select * from problems; 
select * from services;
select * from solves; --
select * from faces; --
select * from handles; --
select * from threat_identification; 
select * from security_measures; --
select * from immediate_response_team;
select * from skill_level;
select * from threat_analysis;
select * from threat_solutions;

select count(*)
from solves;
SET foreign_key_checks = 1;
drop table services; --
drop table problems; --
drop table threat_identification; --
drop table security_measures;
drop table faces;
drop table handles;
drop table solves;

    

create table services (
	service_id VARCHAR(10) PRIMARY KEY,
    dept_id VARCHAR(10),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE threat_identification (
    threat_id VARCHAR(10) PRIMARY KEY,
    type ENUM('Malware', 'Phishing', 'DDoS', 'SQL Injection', 'Zero-day', 'Ransomware', 'Social Engineering', 'Man-in-the-middle'),
    security_level ENUM('LOW', 'MEDIUM', 'HIGH'),
    service_id VARCHAR(10),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE problems (
    problem_id VARCHAR(10) PRIMARY KEY,
    threat_id VARCHAR(10),
    FOREIGN KEY (threat_id) REFERENCES threat_identification(threat_id)
);

-- simple query
SELECT * FROM employees
WHERE emp_id BETWEEN 'EMP0030' AND 'EMP0038';

-- aggregate query
SELECT dept_id, COUNT(emp_id) AS employee_count
FROM employee_departments
GROUP BY dept_id;

SELECT dept_id, COUNT(emp_id) AS employee_count
FROM employee_departments
GROUP BY dept_id;


SELECT * FROM clients
ORDER BY name ASC;

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
SELECT DISTINCT d.Dept_head
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Employees e
    JOIN threat_identification t ON e.ThreatID = t.ThreatID
    WHERE e.dept_ID = d.dept_ID
      -- AND t.Severity > 7
);

-- Subqueries in Select and From
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE p.threat_id IN (SELECT threat_id FROM threat_identification WHERE type = 'Zero-day');


-- Exists query
SELECT p.problem_id, p.threat_id
FROM problems p
WHERE EXISTS (SELECT 1 
              FROM threat_identification t 
              WHERE t.threat_id = p.threat_id 
                AND t.type = 'Zero-day');


-- set operations (union)
SELECT s.dept_id, 'High-Cost Security' AS activity
FROM security_measures sm
JOIN services s ON sm.service_id = s.service_id
WHERE sm.cost > 7000

UNION

SELECT irt.dept_id, 'Quick Response' AS activity
FROM immediate_response_team irt
WHERE irt.response_time < 30;
