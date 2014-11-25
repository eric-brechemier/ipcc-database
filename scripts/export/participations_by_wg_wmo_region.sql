-- Number of participations by WG and WMO Region

SELECT
  all_participations.wg AS `WG`,
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
    participations.wg,
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
  GROUP BY participations.wg, groups.symbol
) wmo_participations
JOIN
(
  SELECT wg, COUNT(*) AS total
  FROM participations
  GROUP BY wg
) all_participations
USING (wg)
ORDER BY wmo_participations.wg, wmo_participations.total DESC
