WITH avg_occupancy_by_neighborhood AS (
    SELECT
        COALESCE(neighbourhood, 'Desconhecido') AS neighbourhood,
        ROUND(AVG(COALESCE(availability_365, 0)), 2) AS avg_occupancy
    FROM {{ ref('airbnb_listings_silver') }}
    WHERE COALESCE(neighbourhood, 'Desconhecido') IS NOT NULL 
      AND COALESCE(availability_365, 0) IS NOT NULL
    GROUP BY neighbourhood
    ORDER BY avg_occupancy DESC
)

SELECT * FROM avg_occupancy_by_neighborhood
