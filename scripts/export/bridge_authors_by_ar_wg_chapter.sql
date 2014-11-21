-- List of Bridge Authors by AR, WG, Chapter

SELECT
  authors.id AS `Bridge Author Id`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Bridge Author`,
  participations.ar AS AR,
  bridge_wg_ratios.bridge123 * 100 AS '% WG I+II+III',
  bridge_wg_ratios.bridge12 * 100 AS '% WG I+II',
  bridge_wg_ratios.bridge13 * 100 AS '% WG I+III',
  bridge_wg_ratios.bridge23 * 100 AS '% WG II+III',
  CASE participations.wg
    WHEN 1 THEN 'WG I'
    WHEN 2 THEN 'WG II'
    WHEN 3 THEN 'WG III'
  END AS WG,
  bridge_wg_ratios.wg1 * 100 AS '% WG I',
  bridge_wg_ratios.wg2 * 100 AS '% WG II',
  bridge_wg_ratios.wg3 * 100 AS '% WG III',
  participations.chapter AS Chapter,
  chapters.title AS `Chapter Title`,
  institutions.name AS `Institution`,
  countries.name AS `Country`
FROM participations
JOIN chapters
ON participations.ar = chapters.ar
AND participations.wg = chapters.wg
AND participations.chapter = chapters.number
JOIN
(
  SELECT DISTINCT p1.author_id
  FROM participations p1
  JOIN participations p2
  ON p1.author_id = p2.author_id
  AND p1.wg < p2.wg
) bridge_authors
ON participations.author_id = bridge_authors.author_id
JOIN
(
  SELECT
    author_id,
    total,
    WG1 / total AS wg1,
    WG2 / total AS wg2,
    WG3 / total AS wg3,
    2 * least(WG1, WG2) / total AS bridge12,
    2 * least(WG2, WG3) / total AS bridge23,
    2 * least(WG1, WG3) / total AS bridge13,
    3 * least(WG1, WG2, WG3) / total AS bridge123
  FROM
    (
      SELECT
        total_participations.author_id,
        IFNULL(WG1,0) AS WG1,
        IFNULL(WG2,0) AS WG2,
        IFNULL(WG3,0) AS WG3,
        total
      FROM
        (
          SELECT author_id, COUNT(id) as total
          FROM participations
          GROUP BY author_id
        ) AS total_participations

        LEFT JOIN
        (
          SELECT author_id, COUNT(id) AS WG1
          FROM participations
          WHERE wg = 1
          GROUP BY author_id
        ) AS wg1_participations
        ON total_participations.author_id = wg1_participations.author_id

        LEFT JOIN
        (
          SELECT author_id, COUNT(id) AS WG2
          FROM participations
          WHERE wg = 2
          GROUP BY author_id
        ) AS wg2_participations
        ON total_participations.author_id = wg2_participations.author_id

        LEFT JOIN
        (
          SELECT author_id, COUNT(id) AS WG3
          FROM participations
          WHERE wg = 3
          GROUP BY author_id
        ) AS wg3_participations
        ON total_participations.author_id = wg3_participations.author_id
    ) AS wg_participations
) AS bridge_wg_ratios
ON participations.author_id = bridge_wg_ratios.author_id
JOIN authors
ON participations.author_id = authors.id
JOIN institution_countries
ON participations.institution_country_id = institution_countries.id
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
ORDER BY authors.last_name, authors.first_name, ar, wg, chapter
;
