USE giec

SELECT institutions.name, countries.name
FROM institutions, countries
WHERE institutions.country_id = countries.id
AND institutions.id NOT IN (
  SELECT institution_id
  FROM participations
);

DELETE FROM institutions
WHERE id NOT IN (
  SELECT institution_id
  FROM participations
);
