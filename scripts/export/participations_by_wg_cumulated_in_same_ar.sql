-- Number of participations by WG Cumulated in Same AR

SELECT
  cumulated_wg AS `Cumulated WG`,
  COUNT(*) AS `Total`
FROM
  (
    SELECT
      ar,
      CONCAT(
        'WG',
        GROUP_CONCAT(
          DISTINCT wg
          ORDER BY wg
          SEPARATOR '+'
        )
      ) cumulated_wg,
      author_id
    FROM participations
    GROUP BY ar, author_id
  ) author_participations
GROUP BY cumulated_wg
ORDER BY cumulated_wg
