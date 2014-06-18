USE giec

UPDATE institutions
SET name=SUBSTR(name,2)
WHERE name LIKE ' %';

SELECT COUNT(*)
FROM institutions
WHERE name LIKE ' %';
