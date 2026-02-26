CREATE TEMP TABLE temp_logs AS (
SELECT
  user_id,
  STRUCT('search' AS event, 'home' AS screen) AS details
FROM homeworklebedeva.homework_bigquery.event_logs);

-- Виводимо user_id та вкладені поля details.event і details.screen
SELECT
  user_id,
  details.event,
  details.screen
FROM temp_logs;


SELECT 
*
FROM `homeworklebedeva.homework_bigquery.event_logs`;
SELECT
  COUNT(DISTINCT user_id) AS unique_purchasers
FROM `homeworklebedeva.homework_bigquery.event_logs`
WHERE event_name = 'purchase'
  AND _PARTITIONDATE BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY) AND CURRENT_DATE();

SELECT
  user_id,
  DATE(event_time) AS event_date,
  ARRAY_AGG(event_name ORDER BY event_time) AS events_array
FROM `homeworklebedeva.homework_bigquery.event_logs`
GROUP BY user_id, DATE(event_time);
WITH user_struct AS (
  SELECT
    user_id,
    STRUCT('home' AS screen) AS details
  FROM `homeworklebedeva.homework_bigquery.event_logs`
)
SELECT
  user_id AS uid,
  details.screen AS location
FROM user_struct;

CREATE TABLE `homeworklebedeva.homework_bigquery.unique_purchasers_daily` (
  event_date DATE,
  unique_purchasers INT64
);
SELECT
  CURRENT_DATE() AS event_date,
  COUNT(DISTINCT user_id) AS unique_purchasers
FROM `homeworklebedeva.homework_bigquery.event_logs`
WHERE event_name = 'purchase'
  AND _PARTITIONDATE >= '2024-01-01';

  WITH user_events AS (
  SELECT
    user_id,
    DATE(event_time) AS event_date,
    ARRAY_AGG(event_name ORDER BY event_time) AS events_array
  FROM `homeworklebedeva.homework_bigquery.event_logs`
  GROUP BY user_id, DATE(event_time)
)
SELECT DISTINCT
  user_id,
  event_date,
  event_name AS individual_event
FROM user_events,
UNNEST(events_array) AS event_name
ORDER BY user_id, event_date, individual_event;






