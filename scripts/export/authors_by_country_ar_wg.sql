-- Number of distinct authors by Country, by AR and by WG

SELECT
  Country,
  all_authors.ar AS AR,
  all_authors.wg AS WG,
  IFNULL(country_authors.total,0) AS `Total Country Authors`,
  all_authors.total AS `Total Authors`,
  (
    IFNULL(country_authors.total,0) / all_authors.total
  ) * 100 AS `Percentage of Authors in Country`
FROM
(
  SELECT
    countries.id AS country_id,
    countries.name AS Country,
    working_groups.assessment_report_id AS AR,
    working_groups.number AS WG
  FROM countries, working_groups
) groups
LEFT JOIN
(
  SELECT country_id, ar, wg, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT country_id, ar, wg, author_id
    FROM participations p
    JOIN institution_countries ic ON p.institution_country_id = ic.id
    JOIN countries c ON ic.country_id = c.id
  ) country_authors
  GROUP BY country_id, ar, wg
) country_authors
USING (country_id,ar,wg)
RIGHT JOIN
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
ORDER BY Country, ar, wg
