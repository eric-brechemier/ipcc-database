SELECT
  author_institutions.author_id,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`,
  author_institutions.institution_id,
  institutions.name AS `Institution (INFO)`,
  countries.name AS `Coutry (INFO)`
FROM author_institutions
JOIN authors
ON author_institutions.author_id = authors.id
JOIN institution_countries
ON author_institutions.institution_id = institution_countries.id
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
ORDER BY
  author_institutions.author_id,
  author_institutions.institution_id
;
