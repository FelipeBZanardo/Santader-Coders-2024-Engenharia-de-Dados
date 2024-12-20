{{ config(materialized='view') }}


SELECT
    year_of_registration,
    ROUND(AVG(avg_price)::numeric, 2) AS avg_price,  -- Arredonda o preço médio para duas casas decimais
    SUM(total_listings) AS total_vehicles
FROM {{ ref('autos_silver') }}
GROUP BY year_of_registration
ORDER BY year_of_registration desc