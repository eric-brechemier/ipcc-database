-- List of Bridge Authors by AR, WG, Chapter

SELECT
  participations.ar AS AR,
  participations.wg AS WG,
  participations.chapter AS Chapter,
  chapters.title AS `Chapter Title`,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Bridge Author`,
  authors.id AS `Bridge Author Id`
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
JOIN authors
ON participations.author_id = authors.id
ORDER BY ar, wg, chapter, authors.last_name, authors.first_name
;
