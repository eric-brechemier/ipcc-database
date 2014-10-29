SELECT
  groupings.id,
  groupings.symbol,
  groups.name AS `Country Group (INFO)`,
  groupings.country_id,
  countries.name AS `Country (INFO)`
FROM groupings
JOIN groups
ON groupings.symbol = groups.symbol
JOIN countries
ON groupings.country_id = countries.id
;
