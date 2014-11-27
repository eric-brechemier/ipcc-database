-- Number of participations by AR, Role and WMO Region

SELECT
  all_participations.ar AS `AR`,
  roles.symbol AS `Role Symbol`,
  roles.name AS `Role`,
  wmo_participations.symbol AS `WMO Symbol`,
  wmo_participations.name AS `WMO Region`,
  wmo_participations.total AS `Total WMO Region Participations`,
  (
    wmo_participations.total / all_participations.total
  ) * 100 AS `% WMO Region Participations`,
  all_participations.total AS `Total Participations`
FROM
(
  SELECT
    participations.ar,
    participations.role,
    groups.symbol,
    groups.name,
    COUNT(*) AS total
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
  GROUP BY participations.ar, participations.role, groups.symbol
) wmo_participations
JOIN
(
  SELECT ar, role, COUNT(*) AS total
  FROM participations
  GROUP BY ar, role
) all_participations
USING (ar)
JOIN roles
ON all_participations.role = roles.symbol
ORDER BY
  wmo_participations.ar,
  roles.rank,
  wmo_participations.total DESC
