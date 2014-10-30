SELECT
  author_aliases.*,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`
FROM author_aliases
LEFT JOIN authors
ON author_aliases.author_id = authors.id
ORDER BY
  author_aliases.author_id,
  author_aliases.alias
;
