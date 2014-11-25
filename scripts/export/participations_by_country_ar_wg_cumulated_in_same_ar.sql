-- Number of authors by Country, AR, WG Cumulated in Same AR

SELECT
  countries.name AS `Country`,
  all_participations.ar AS `AR`,
  all_participations.cumulated_wg `Cumulated WG`,
  country_participations.total AS `Total Country Participations`,
  (
    country_participations.total / all_participations.total
  ) * 100 AS `% Country Participations`,
  all_participations.total AS `Total Participations`
FROM
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
USING (ar, cumulated_wg)
JOIN
countries
ON country_participations.country_id = countries.id
ORDER BY
  countries.name,
  all_participations.ar,
  all_participations.cumulated_wg
