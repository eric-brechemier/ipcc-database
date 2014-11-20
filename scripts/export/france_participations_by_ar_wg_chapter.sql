-- Number of France Participations by AR, WG, Chapter

SELECT
  chapters.ar AS AR,
  chapters.wg AS WG,
  chapters.number AS `Chapter`,
  france_participations.total AS `Total France Participations`,
  all_participations.total AS `Total Participations`,
  (
    france_participations.total / all_participations.total
  ) * 100 AS `Percentage of France Participations` 
FROM
(
  SELECT ar, wg, chapter, COUNT(*) AS total
  FROM participations p
  JOIN institution_countries ic ON p.institution_country_id = ic.id
  JOIN countries c ON ic.country_id = c.id
  WHERE c.name = 'France'
  GROUP BY ar, wg, chapter
) france_participations
JOIN
(
  SELECT ar, wg, chapter, COUNT(*) AS total
  FROM participations
  GROUP BY ar, wg, chapter
) all_participations
USING (ar,wg,chapter)
JOIN chapters
ON all_participations.ar = chapters.ar
AND all_participations.wg = chapters.wg
AND all_participations.chapter = chapters.number
ORDER BY ar, wg, chapters.id
