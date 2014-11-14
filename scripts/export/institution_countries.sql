SELECT
  institution_countries.id,
  institution_countries.country_id,
  countries.name AS `Country (INFO)`,
  institution_countries.institution_id,
  institutions.name AS `Institution (INFO)`
FROM institution_countries
LEFT JOIN institutions
ON institution_countries.institution_id = institutions.id
LEFT JOIN countries
ON institution_countries.country_id = countries.id
ORDER BY
  countries.name,
  institutions.name
;
