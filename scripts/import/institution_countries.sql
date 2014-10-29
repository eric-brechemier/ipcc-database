SELECT
  institution_countries.id,
  institution_countries.institution_id,
  institutions.name AS `Institution (INFO)`,
  institution_countries.country_id,
  countries.name AS `Country (INFO)`
FROM institution_countries
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
;
