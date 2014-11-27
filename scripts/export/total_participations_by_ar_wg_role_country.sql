-- Number of participations by AR, WG, Role and Country
-- Sorted in decreasing order of participations (top N countries)

SELECT
  role_participations.ar AS AR,
  role_participations.wg AS WG,
  roles.name AS `Role`,
  country_participations.total AS `Total Country Participations`,
  (
    country_participations.total / role_participations.total
  ) * 100 AS `% Country Participations`,
  role_participations.total AS `Total Role Participations`,
  country_participations.country_id AS `Country Id`,
  countries.name AS `Country`
FROM
(
  SELECT ar, wg, role, country_id, COUNT(*) AS total
  FROM participations
  JOIN institution_countries
  ON participations.institution_country_id = institution_countries.id
  GROUP BY ar, wg, role, country_id
) country_participations
JOIN
(
  SELECT ar, wg, role, COUNT(*) AS total
  FROM participations
  GROUP BY ar, wg, role
) role_participations
USING (ar, wg, role)
JOIN roles
ON role_participations.role = roles.symbol
JOIN countries
ON country_participations.country_id = countries.id
ORDER BY
  ar, wg, roles.rank,
  country_participations.total DESC,
  countries.name
