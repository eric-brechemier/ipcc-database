-- Number of authors by WG Cumulated in Distinct AR

SELECT
  cumulated_wg AS `Cumulated WG`,
  total AS `Total Authors`
FROM
(
  -- bridge participations
  SELECT cumulated_wg, COUNT(*) AS total
  FROM
  (
    SELECT
      CONCAT(
        'WG',
        GROUP_CONCAT(
          DISTINCT wg
          ORDER BY wg
          SEPARATOR '+'
        )
      ) AS cumulated_wg,
      author_id
    FROM
    (
      SELECT
        p1.author_id,
        p1.ar AS ar,
        p1.wg AS wg,
        p2.ar AS bridge_ar,
        p2.wg AS bridge_wg
      FROM participations p1
      JOIN participations p2
      ON p1.ar <> p2.ar
      AND p1.wg <> p2.wg
      AND p1.author_id = p2.author_id
    ) bridge_participations
    GROUP BY author_id
  ) bridge_participations
  GROUP BY cumulated_wg
  UNION
  -- non-bridge participations
  SELECT CONCAT('WG',wg), COUNT(*) AS total
  FROM
  (
    SELECT wg, author_id
    FROM participations
    WHERE author_id NOT IN (
      SELECT p1.author_id
      FROM participations p1
      JOIN participations p2
      ON p1.ar <> p2.ar
      AND p1.wg <> p2.wg
      AND p1.author_id = p2.author_id
    )
  ) non_bridge_participations
  GROUP BY wg
) participations
ORDER BY cumulated_wg
