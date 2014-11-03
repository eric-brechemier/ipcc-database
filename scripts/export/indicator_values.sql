SELECT
  indicator_values.indicator_code,
  indicators.name AS `Indicator (INFO)`,
  indicator_values.country_code,
  countries.name AS `Country (INFO)`,
  indicator_values.year,
  indicator_values.value
FROM indicator_values
JOIN indicators
ON indicator_values.indicator_code = indicators.code
JOIN countries
ON indicator_values.country_code = countries.code
ORDER BY
  indicator_values.indicator_code,
  indicator_values.country_code,
  indicator_values.year
;
