SELECT
  groupings.id,
  groupings.symbol,
  groups.name AS `Country Group (INFO)`,
  groupings.country_id,
  countries.name AS `Country (INFO)`
FROM groupings
LEFT JOIN groups
ON groupings.symbol = groups.symbol
LEFT JOIN countries
ON groupings.country_id = countries.id
ORDER BY
  groupings.id,
  groupings.country_id
;
