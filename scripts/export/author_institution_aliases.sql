SELECT
  author_institution_aliases.*,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`
FROM author_institution_aliases
LEFT JOIN authors
ON author_institution_aliases.author_id = authors.id
ORDER BY
  author_institution_aliases.alias,
  author_institution_aliases.institution
;
