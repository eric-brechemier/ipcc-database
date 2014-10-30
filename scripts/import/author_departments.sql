SELECT
  author_departments.author_id,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`,
  author_departments.department_id,
  departments.name AS `Department (INFO)`
FROM author_departments
JOIN authors
ON author_departments.author_id = authors.id
JOIN departments
ON author_departments.department_id = departments.id
ORDER BY
  author_departments.author_id,
  author_departments.department_id
;
