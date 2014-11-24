-- Number of distinct authors in France Participations by AR and by Role

SELECT
  ar AS AR,
  roles.name AS Role,
  IFNULL(france_authors.total,0) AS `Total France Authors`,
  all_authors.total AS `Total Authors`,
  (
    IFNULL(france_authors.total,0) / all_authors.total
  ) * 100 AS `Percentage of Authors in France`
FROM
(
  SELECT ar, role, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, role, author_id
    FROM participations p
    JOIN institution_countries ic ON p.institution_country_id = ic.id
    JOIN countries c ON ic.country_id = c.id
    WHERE c.name = 'France'
  ) france_authors
  GROUP BY ar, role
) france_authors
RIGHT JOIN
(
  SELECT ar, role, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, role, author_id
    FROM participations
  ) all_authors
  GROUP BY ar, role
) all_authors
USING (ar,role)
JOIN
roles
ON all_authors.role = roles.symbol
ORDER BY ar, roles.rank
