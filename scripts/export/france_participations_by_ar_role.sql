-- Number of France Participations by AR and by Role

SELECT
  ar AS AR,
  roles.name AS Role,
  IFNULL(france_participations.total,0) AS `Total France Participations`,
  all_participations.total AS `Total Participations`,
  (
    IFNULL(france_participations.total,0) / all_participations.total
  ) * 100 AS `Percentage of France Participations`
FROM
(
  SELECT ar, role, COUNT(*) total
  FROM participations p
  JOIN institution_countries ic ON p.institution_country_id = ic.id
  JOIN countries c ON ic.country_id = c.id
  WHERE c.name = 'France'
  GROUP BY ar, role
) france_participations
RIGHT JOIN
(
  SELECT ar, role, COUNT(*) total
  FROM participations
  GROUP BY ar, role
) all_participations
USING (ar,role)
JOIN
roles
ON all_participations.role = roles.symbol
ORDER BY ar, roles.rank
