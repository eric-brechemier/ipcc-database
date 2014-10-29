SELECT
  institution_aliases.*,
  institutions.name AS `Institution (INFO)`
FROM institution_aliases
JOIN institutions
ON institution_aliases.institution_id = institutions.id
;
