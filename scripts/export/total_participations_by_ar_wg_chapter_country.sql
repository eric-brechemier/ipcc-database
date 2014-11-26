-- Number of participations by AR, WG, Chapter and Country
-- Sorted in decreasing order of participations (top N countries)

SELECT
  chapters.ar AS AR,
  chapters.wg AS WG,
  chapters.number AS Chapter,
  country_participations.total AS `Total Country Participations`,
  (
    country_participations.total / chapter_participations.total
  ) * 100 AS `% Country Participations`,
  chapter_participations.total AS `Total Chapter Participations`,
  country_participations.country_id AS `Country Id`,
  countries.name AS `Country`
FROM
(
  SELECT ar, wg, chapter, country_id, COUNT(*) AS total
  FROM participations
  JOIN institution_countries
  ON participations.institution_country_id = institution_countries.id
  GROUP BY ar, wg, chapter, country_id
) country_participations
JOIN
(
  SELECT ar, wg, chapter, COUNT(*) AS total
  FROM participations
  GROUP BY ar, wg, chapter
) chapter_participations
USING (ar, wg, chapter)
JOIN chapters
ON chapter_participations.ar = chapters.ar
AND chapter_participations.wg = chapters.wg
AND chapter_participations.chapter = chapters.number
JOIN countries
ON country_participations.country_id = countries.id
ORDER BY
  ar, wg, chapters.id,
  country_participations.total DESC,
  countries.name
