-- Number of France Bridge Authors by AR and WG
-- (Bridge Authors have participations in more than 1 WG in same AR)

SELECT
  CONCAT(
    'WG ',
    CASE all_bridge_authors.wg_left
      WHEN 1 THEN 'I'
      WHEN 2 THEN 'II'
    END,
    '-',
    CASE all_bridge_authors.wg_right
      WHEN 2 THEN 'II'
      WHEN 3 THEN 'III'
    END
  ) AS `Bridge WG`,
  all_bridge_authors.ar AS `AR`,
  france_bridge_authors.total AS `Total France Bridge Authors`,
  all_bridge_authors.total AS `Total Bridge Authors`,
  (
    france_bridge_authors.total / all_bridge_authors.total
  ) * 100 AS `Percentage of Bridge Authors in France`
FROM
(
  SELECT ar, wg_left, wg_right, COUNT(*) AS total
  FROM
  (
    SELECT p1.ar, p1.wg AS wg_left, p2.wg AS wg_right, p1.author_id
    FROM participations p1
    JOIN participations p2
    ON p1.ar = p2.ar
    AND p1.author_id = p2.author_id
    AND p1.wg < p2.wg
    JOIN institution_countries ic1
    ON p1.institution_country_id = ic1.id
    JOIN countries c1
    ON ic1.country_id = c1.id
    JOIN institution_countries ic2
    ON p2.institution_country_id = ic2.id
    JOIN countries c2
    ON ic2.country_id = c2.id
    WHERE c1.name = 'France' OR c2.name = 'France'
    GROUP BY ar, p1.wg, p2.wg, author_id
  ) france_bridge_authors
  GROUP BY ar, wg_left, wg_right
) france_bridge_authors
JOIN
(
  SELECT ar, wg_left, wg_right, COUNT(*) AS total
  FROM
  (
    SELECT p1.ar, p1.wg AS wg_left, p2.wg AS wg_right, p1.author_id
    FROM participations p1
    JOIN participations p2
    ON p1.ar = p2.ar
    AND p1.author_id = p2.author_id
    AND p1.wg < p2.wg
    GROUP BY ar, p1.wg, p2.wg, author_id
  ) all_bridge_authors
  GROUP BY ar, wg_left, wg_right
) all_bridge_authors
USING (ar,wg_left,wg_right)
ORDER BY wg_left, wg_right, ar
