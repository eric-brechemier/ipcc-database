-- Number of participations by AR, WG, Chapter and Country
-- Sorted in decreasing order of participations (top N countries)
SELECT
  ar, wg, chapter,
  COUNT(*) AS Total,
  country_id, countries.name AS Country
FROM participations
JOIN institution_countries
ON participations.institution_country_id = institution_countries.id
JOIN countries
ON institution_countries.country_id = countries.id
GROUP BY ar, wg, chapter, country_id
ORDER BY ar, wg, chapter, Total DESC, Country
