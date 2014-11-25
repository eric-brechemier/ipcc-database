-- Number of authors by Country, AR, WG Cumulated in Same AR

SELECT
  countries.name AS `Country`,
  all_participations.ar AS `AR`,
  all_participations.cumulated_wg `Cumulated WG`,
  IFNULL(country_participations.total,0) AS `Total Country Authors`,
  (
    IFNULL(country_participations.total,0) / all_participations.total
  ) * 100 AS `% Country Authors`,
  all_participations.total AS `Total Authors`
FROM
countries
JOIN
(
  SELECT ar, cumulated_wg, COUNT(*) AS total
  FROM
  (
    SELECT
      ar,
      CONCAT(
        'WG',
        GROUP_CONCAT(
          DISTINCT wg
          ORDER BY wg
          SEPARATOR '+'
        )
      ) cumulated_wg,
      author_id
    FROM participations
    GROUP BY ar, author_id
  ) all_participations
  GROUP BY ar, cumulated_wg
) all_participations
LEFT JOIN
(
  SELECT country_id, ar, cumulated_wg, COUNT(*) AS total
  FROM
  (
    SELECT
      country_id,
      ar,
      CONCAT(
        'WG',
        GROUP_CONCAT(
          DISTINCT wg
          ORDER BY wg
          SEPARATOR '+'
        )
      ) cumulated_wg,
      author_id
    FROM participations
    JOIN institution_countries
    ON participations.institution_country_id = institution_countries.id
    GROUP BY country_id, ar, author_id
  ) country_participations
  GROUP BY country_id, ar, cumulated_wg
) country_participations
ON countries.id = country_participations.country_id
AND all_participations.ar = country_participations.ar
AND all_participations.cumulated_wg = country_participations.cumulated_wg
ORDER BY
  countries.name,
  all_participations.ar,
  all_participations.cumulated_wg
