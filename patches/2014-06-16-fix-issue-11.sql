USE giec

UPDATE institutions
SET name = REPLACE(name,'  ',' ')
WHERE name LIKE '%  %';
