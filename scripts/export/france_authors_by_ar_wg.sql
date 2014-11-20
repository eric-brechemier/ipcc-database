-- Number of distinct authors in France Participations by AR and by WG

SELECT
  ar AS AR,
  wg AS WG,
  france_authors.total AS `Total France Authors`,
  all_authors.total AS `Total Authors`,
  (
    france_authors.total / all_authors.total
  ) * 100 AS `Percentage of Authors in France`
FROM
(
  SELECT ar, wg, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, wg, author_id
    FROM participations p
    JOIN institution_countries ic ON p.institution_country_id = ic.id
    JOIN countries c ON ic.country_id = c.id
    WHERE c.name = 'France'
  ) france_authors
  GROUP BY ar, wg
) france_authors
JOIN
(
  SELECT ar, wg, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, wg, author_id
    FROM participations
  ) all_authors
  GROUP BY ar, wg
) all_authors
USING (ar,wg)
ORDER BY ar, wg
