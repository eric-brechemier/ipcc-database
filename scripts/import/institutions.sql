SELECT
  institutions.id,
  institutions.name,
  institutions.institution_type_id,
  institution_types.name AS `Institution Type (INFO)`
FROM institutions
JOIN institution_types
ON institutions.institution_type_id = institution_types.id
;
