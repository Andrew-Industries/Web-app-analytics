select 
*
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

limit 100
;

--Data Profiling: access key frequency
select key,
count(*)
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, unnest(event_params)
GROUP BY 1
ORDER BY 2 DESC
;
--Data profiling: Array Length
SELECT 
  MIN(ARRAY_LENGTH(event_params)) as min_params,
  MAX(ARRAY_LENGTH(event_params)) as max_params,
  AVG(ARRAY_LENGTH(event_params)) as avg_params
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
;
--Data profiling: Value Types
SELECT 
  ep.key,
  COUNT(ep.value.string_value) as has_string,
  COUNT(ep.value.int_value) as has_int,
  COUNT(ep.value.float_value) as has_float
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, UNNEST(event_params) AS ep
--WHERE ep.key = 'page_title'
GROUP BY 1
;
--Data profiling: Value Sampling 
SELECT 
  ep.value.string_value, 
  COUNT(*) as val_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, UNNEST(event_params) AS ep
WHERE ep.key = 'page_title'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
