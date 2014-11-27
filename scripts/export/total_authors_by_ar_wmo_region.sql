-- Number of Authors by AR and WMO Region

SELECT
  all_authors.ar AS `AR`,
  wmo_authors.symbol AS `WMO Symbol`,
  wmo_authors.name AS `WMO Region`,
  wmo_authors.total AS `Total WMO Region Authors`,
  (
    wmo_authors.total / all_authors.total
  ) * 100 AS `% WMO Region Authors`,
  all_authors.total AS `Total Authors`
FROM
(
  SELECT ar, symbol, name, COUNT(*) AS total
  FROM
  (
    SELECT
      participations.ar,
      groups.symbol,
      groups.name,
      COUNT(*) AS total
    FROM participations
    JOIN institution_countries
    ON participations.institution_country_id = institution_countries.id
    JOIN countries
    ON institution_countries.country_id = countries.id
    JOIN groupings
    ON groupings.country_id = countries.id
    JOIN groups
    ON groupings.symbol = groups.symbol
    WHERE groups.type = 'WMO'
    GROUP BY
      participations.ar,
      groups.symbol,
      participations.author_id
  ) wmo_authors
  GROUP BY ar, symbol
) wmo_authors
JOIN
(
  SELECT ar, COUNT(*) AS total
  FROM
  (
    SELECT DISTINCT ar, author_id
    FROM participations
  ) all_authors
  GROUP BY ar
) all_authors
USING (ar)
ORDER BY wmo_authors.ar, wmo_authors.total DESC
