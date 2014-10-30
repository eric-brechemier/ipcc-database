SELECT
  departments.*,
  institutions.name AS `Institution (INFO)`,
  countries.name AS `Country (INFO)`
FROM departments
LEFT JOIN institution_countries
ON departments.institution_id = institution_countries.id
LEFT JOIN institutions
ON institution_countries.institution_id = institutions.id
LEFT JOIN countries
ON institution_countries.country_id = countries.id
ORDER BY departments.id
;
