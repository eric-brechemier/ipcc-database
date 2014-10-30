SELECT
  country_aliases.*,
  countries.name AS `Country (INFO)`
FROM country_aliases
LEFT JOIN countries
ON country_aliases.country_id = countries.id
ORDER BY
  country_aliases.country_id,
  country_aliases.alias
;
