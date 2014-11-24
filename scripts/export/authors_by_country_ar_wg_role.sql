-- Number of distinct authors by Country, AR, WG and Role

SELECT
  participating_countries.name AS Country,
  roles.name AS `Role`,
  all_authors.ar AS AR,
  all_authors.wg AS WG,
  IFNULL(country_authors.total,0) AS `Total Country Authors`,
  all_authors.total AS `Total Authors`,
  (
    IFNULL(country_authors.total,0) / all_authors.total
  ) * 100 AS `Percentage of Authors in Country` 
FROM
(
  SELECT *
  FROM countries
  WHERE EXISTS (
    SELECT *
    FROM participations
    JOIN institution_countries
    ON participations.institution_country_id = institution_countries.id
    WHERE institution_countries.country_id = countries.id
  )
) participating_countries
JOIN
(
  SELECT ar, wg, role, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, wg, role, author_id
    FROM participations
  ) all_authors
  GROUP BY ar, wg, role
) all_authors
LEFT JOIN
(
  SELECT country_id, ar, wg, role, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT country_id, ar, wg, role, author_id
    FROM participations p
    JOIN institution_countries ic ON p.institution_country_id = ic.id
    JOIN countries c ON ic.country_id = c.id
  ) country_authors
  GROUP BY country_id, ar, wg, role
) country_authors
ON participating_countries.id = country_authors.country_id
AND all_authors.ar = country_authors.ar
AND all_authors.wg = country_authors.wg
AND all_authors.role = country_authors.role
JOIN roles
ON all_authors.role = roles.symbol
ORDER BY Country, roles.rank, ar, wg
