-- Deliverable 1: 
-- Create a retirement table
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
-- INTO retirement_titles
FROM employees as e
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
-- INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- The number of employees by their most recent job title who are about to retire
SELECT DISTINCT COUNT(title) as ct,
title
-- INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY ct DESC;


-- Deliverable 2:
-- Create a mentorship eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
-- INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = ('9999-01-01'))
ORDER BY e.emp_no;


-- Deliverable 3:
-- query for retiring employees by department.
SELECT COUNT(ce.emp_no), de.dept_no, d.dept_name
-- INTO emp_per_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
LEFT JOIN employees as e
ON ce.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (de.to_date = ('9999-01-01'))
GROUP BY de.dept_no, d.dept_name
ORDER BY de.dept_no;

--  query for all employees by department
SELECT COUNT(e.emp_no), de.dept_no, d.dept_name
-- INTO emp_per_dept
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN departments as d
ON de.dept_no = d.dept_no
WHERE (de.to_date = ('9999-01-01'))
GROUP BY de.dept_no, d.dept_name
ORDER BY de.dept_no;

-- query for total number of managers
SELECT COUNT(dm.emp_no) as managers, d.dept_name
-- INTO total_managers
FROM dept_manager as dm
LEFT JOIN departments as d
ON dm.dept_no = d.dept_no
GROUP BY d.dept_no
ORDER BY d.dept_no
