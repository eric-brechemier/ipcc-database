USE giec

ALTER TABLE participations
DROP FOREIGN KEY participations_institution_fk;

ALTER TABLE participations
CHANGE COLUMN institution_id institution_country_id INT(10);

ALTER TABLE participations
ADD CONSTRAINT participations_institution_country_fk
FOREIGN KEY ( institution_country_id )
REFERENCES institution_countries ( id );

SHOW COLUMNS IN participations;
