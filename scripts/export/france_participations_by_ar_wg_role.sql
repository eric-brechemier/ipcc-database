-- Number of France Participations by AR, WG, Role

SELECT
  roles.name AS `Role`,
  ar AS AR,
  wg AS WG,
  IFNULL(france_participations.total,0) AS `Total France Participations`,
  all_participations.total AS `Total Participations`,
  (
    IFNULL(france_participations.total,0) / all_participations.total
  ) * 100 AS `Percentage of France Participations` 
FROM
(
  SELECT ar, wg, role, COUNT(*) AS total
  FROM participations p
  JOIN institution_countries ic ON p.institution_country_id = ic.id
  JOIN countries c ON ic.country_id = c.id
  WHERE c.name = 'France'
  GROUP BY ar, wg, role
) france_participations
RIGHT JOIN
(
  SELECT ar, wg, role, COUNT(*) AS total
  FROM participations
  GROUP BY ar, wg, role
) all_participations
USING (ar,wg,role)
JOIN roles
ON all_participations.role = roles.symbol
ORDER BY roles.rank, ar, wg
