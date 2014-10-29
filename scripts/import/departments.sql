SELECT
  departments.*,
  institutions.name AS `Institution (INFO)`,
  countries.name AS `Country (INFO)`
FROM departments
JOIN institution_countries
ON departments.institution_id = institution_countries.id
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
;
