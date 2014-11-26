-- List of authors by Country, AR, WG Cumulated in Same AR

SELECT
  countries.name AS `Country`,
  author_participations.ar AS `AR`,
  author_participations.cumulated_wg `Cumulated WG`,
  author_participations.author_id AS `Author Id`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author`
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
) author_participations
JOIN countries
ON author_participations.country_id = countries.id
JOIN authors
ON author_participations.author_id = authors.id
ORDER BY
  countries.name,
  author_participations.ar,
  author_participations.cumulated_wg,
  authors.last_name,
  authors.first_name
