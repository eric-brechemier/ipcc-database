-- Number of participations by AR and WMO Region

SELECT
  participations.ar AS `AR`,
  groups.symbol AS `WMO Symbol`,
  groups.name AS `WMO Group`,
  COUNT(*) AS `Total`
FROM participations
JOIN institution_countries
ON participations.institution_country_id = institution_countries.id
JOIN countries
ON institution_countries.country_id = countries.id
JOIN groupings
ON groupings.country_id = countries.id
JOIN groups
ON groupings.symbol = groups.symbol
WHERE groups.type = 'WMO'
GROUP BY participations.ar, groups.symbol
ORDER BY participations.ar, `Total` DESC
