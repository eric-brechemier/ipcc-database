SELECT
  chapter_chapter_types.chapter_id,
  chapters.ar AS `AR (INFO)`,
  chapters.wg AS `WG (INFO)`,
  chapters.number AS `Chapter (INFO)`,
  chapter_chapter_types.chapter_type_id,
  chapter_types.name AS `Chapter Type (INFO)`
FROM chapter_chapter_types
JOIN chapters
ON chapter_chapter_types.chapter_id = chapters.id
JOIN chapter_types
ON chapter_chapter_types.chapter_type_id = chapter_types.id
ORDER BY
  chapter_chapter_types.chapter_id,
  chapter_chapter_types.chapter_type_id
;
