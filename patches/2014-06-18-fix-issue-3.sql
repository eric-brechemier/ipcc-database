USE giec

UPDATE participations
SET role='CLA'
WHERE role='LCA';

SELECT COUNT(*)
FROM participations
WHERE role NOT IN (
  SELECT symbol
  FROM roles
);
