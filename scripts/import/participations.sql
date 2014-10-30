SELECT
  participations.id,
  participations.ar,
  participations.wg,
  participations.chapter,
  participations.role,
  participations.author_id,
  CONCAT(
    authors.first_name,
    ' ',
    authors.last_name
  ) AS `Author (INFO)`,
  participations.institution_country_id,
  institutions.name AS `Institution (INFO)`,
  countries.name AS `Country (INFO)`,
  participations.department_id,
  departments.name AS `Department (INFO)`
FROM participations
JOIN authors
ON participations.author_id = authors.id
JOIN chapters
ON participations.ar = chapters.ar
AND participations.wg = chapters.wg
AND participations.chapter = chapters.number
JOIN roles
ON participations.role = roles.symbol
JOIN institution_countries
ON participations.institution_country_id = institution_countries.id
JOIN institutions
ON institution_countries.institution_id = institutions.id
JOIN countries
ON institution_countries.country_id = countries.id
JOIN departments
ON participations.department_id = departments.id
ORDER BY
  participations.ar,
  participations.wg,
  chapters.id,
  roles.rank,
  authors.last_name,
  authors.first_name
;
