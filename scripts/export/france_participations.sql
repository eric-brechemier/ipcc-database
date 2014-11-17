-- FRENCH AUTHORS
-- Q12. Where are French authors on the IPCC?
-- To which chapters do they contribute the most?

SELECT
  authors.first_name AS 'First Name',
  authors.last_name AS 'Last Name',
  participations.ar AS 'AR',
  participations.wg AS 'WG',
  participations.chapter AS 'Chapter',
  participations.role AS 'Role',
  institutions.name AS 'Institution',
  institution_types.name AS 'Institution Type',
  countries.name AS 'Country'
FROM
  authors,
  participations,
  institution_countries,
  institutions,
  institution_types,
  countries
WHERE authors.id = participations.author_id
AND participations.institution_country_id = institution_countries.id
AND institution_countries.institution_id = institutions.id
AND institutions.institution_type_id = institution_types.id
AND institution_countries.country_id = countries.id
AND countries.name = 'France'
ORDER BY
  authors.last_name,
  authors.first_name,
  participations.ar,
  participations.wg,
  participations.chapter,
  participations.role
;
