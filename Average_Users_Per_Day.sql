/*
=================================================================
Query the average users per day to for test length calculation.
=================================================================
*/
SELECT
  AVG(daily_unique_users) AS avg_users_per_day
FROM (
  SELECT
    _TABLE_SUFFIX AS date,
    COUNT(DISTINCT user_pseudo_id) AS daily_unique_users
  FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
  GROUP BY 1
)
;
SELECT SUBSTR(_TABLE_SUFFIX, 1, 6) AS year_month, COUNT(*) AS record_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY 1
ORDER BY 1 DESC
