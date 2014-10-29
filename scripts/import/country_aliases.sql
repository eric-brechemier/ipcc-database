SELECT
  country_aliases.*,
  countries.name AS `Country (INFO)`
FROM country_aliases
JOIN countries
ON country_aliases.country_id = countries.id
;
