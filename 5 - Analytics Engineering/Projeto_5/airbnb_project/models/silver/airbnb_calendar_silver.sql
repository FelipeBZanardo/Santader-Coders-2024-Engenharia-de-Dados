{{ config(materialized='table') }}


SELECT
    listing_id,
    TO_DATE(date, '%Y-%m-%d') as date,
    CASE 
        WHEN available = 't' THEN true 
        WHEN available = 'f' THEN false 
    END AS available,
    ROUND(REPLACE(REPLACE(price, ',', ''), '$', '')::NUMERIC, 2) AS price,
    COALESCE(minimum_nights::INTEGER, 0) as minimum_nights,
    COALESCE(maximum_nights::INTEGER, 0) as maximum_nights

FROM {{ ref('airbnb_calendar_bronze') }}