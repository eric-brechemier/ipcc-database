USE giec

ALTER TABLE institutions
RENAME TO institution_countries;

CREATE TABLE IF NOT EXISTS institutions
SELECT MIN(id) AS id, name, type_id AS institution_type_id
FROM institution_countries
GROUP BY name;

ALTER TABLE institution_countries
ADD COLUMN institution_id INT(10)
AFTER id;

UPDATE institution_countries, institutions
SET institution_countries.institution_id = institutions.id
WHERE institution_countries.name = institutions.name;

ALTER TABLE institution_countries
DROP COLUMN name;

ALTER TABLE institution_countries
DROP FOREIGN KEY institutions_type_fk;

ALTER TABLE institutions
ADD PRIMARY KEY (id);

ALTER TABLE institutions
ADD CONSTRAINT institutions_type_fk FOREIGN KEY (institution_type_id)
REFERENCES institution_types (id);

ALTER TABLE institution_countries
DROP COLUMN type_id;
