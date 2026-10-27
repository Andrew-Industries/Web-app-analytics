/*
=================================================================
Determine the historical conversion rate for users.
=================================================================
*/
WITH user_activity AS (
  SELECT 
    user_pseudo_id,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS made_purchase
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20201130'
    AND user_pseudo_id IS NOT NULL
  GROUP BY user_pseudo_id
)
SELECT 
  COUNT(DISTINCT user_pseudo_id) AS total_users,
  SUM(made_purchase) AS converting_users,
  ROUND(SAFE_DIVIDE(SUM(made_purchase), COUNT(DISTINCT user_pseudo_id)) * 100, 4) AS conversion_rate_pct
FROM user_activity;
