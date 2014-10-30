SELECT
  chairman_offices.id,
  chairman_offices.ar,
  chairman_offices.wg,
  chairman_offices.role,
  chairman_offices.rank,
  chairman_offices.author_id,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`,
  chairman_offices.institution_id,
  institutions.name AS `Institution (INFO)`,
  countries.name AS `Country (INFO)`,
  chairman_offices.department_id,
  departments.name AS `Department (INFO)`
FROM chairman_offices
JOIN authors
ON chairman_offices.author_id = authors.id
JOIN institution_countries
ON chairman_offices.institution_id = institution_countries.id
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
JOIN departments
ON chairman_offices.department_id = departments.id
ORDER BY chairman_offices.id
;
