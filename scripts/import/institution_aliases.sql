SELECT
  institution_aliases.*,
  institutions.name AS `Institution (INFO)`
FROM institution_aliases
LEFT JOIN institutions
ON institution_aliases.institution_id = institutions.id
ORDER BY
  institution_aliases.institution_id,
  institution_aliases.alias
;
