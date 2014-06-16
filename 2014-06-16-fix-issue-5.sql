USE giec

UPDATE institutions
SET name=SUBSTR(name,4)
WHERE name LIKE 'The %';

SELECT COUNT(*)
FROM institutions
WHERE name LIKE 'The %';
