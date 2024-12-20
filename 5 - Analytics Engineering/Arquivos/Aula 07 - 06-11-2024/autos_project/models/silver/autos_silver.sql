{{ config(materialized='table') }}


SELECT
    brand,
    model,
    "yearOfRegistration" as year_of_registration,
    ROUND(AVG(price)::numeric, 2) AS avg_price,
    ROUND(AVG("powerPS")::numeric, 2) AS avg_power_ps,
    ROUND(AVG(kilometer)::numeric, 2) AS avg_kilometer,
    COUNT(*) AS total_listings
FROM {{ ref('autos_bronze') }}
GROUP BY brand, model, "yearOfRegistration"