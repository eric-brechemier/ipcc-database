SELECT
  institution_country_aliases.alias,
  institution_country_aliases.institution_id,
  institutions.name AS `Institution (INFO)`,
  institution_country_aliases.country_id,
  countries.name AS `Country (INFO)`
FROM institution_country_aliases
LEFT JOIN institutions
ON institution_country_aliases.institution_id = institutions.id
LEFT JOIN countries
ON institution_country_aliases.country_id = countries.id
ORDER BY
  institutions.name,
  countries.name
;
