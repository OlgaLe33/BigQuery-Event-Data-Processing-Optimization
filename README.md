# BigQuery-Event-Data-Processing-Optimization
BigQuery Event Logs Analytics . This project demonstrates working with large volumes of event data in Google BigQuery, focusing on query optimization and automation. It includes examples of using STRUCTs, ARRAYs, UNNEST, and Scheduled Queries to analyze user events.

Features

Temporary Tables & STRUCTs
Create temporary tables with nested fields (STRUCT) and extract nested values.

Counting Unique Users
Calculate the number of unique users performing specific events within a date range using _PARTITIONDATE.User Event Arrays
Aggregate user events per day into arrays using ARRAY_AGG() and maintain chronological order.

Expanding Arrays
Flatten arrays of user events with UNNEST() to get all unique events per day.

Scheduled Queries
Automate daily calculations of unique purchasers and append results to a table.
