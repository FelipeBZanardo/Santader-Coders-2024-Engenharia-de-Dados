WITH avg_price AS (
    SELECT 
        neighbourhood AS region,
        room_type AS accommodation_type,
        ROUND(AVG(price), 2) AS avg_price
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY 
        neighbourhood, room_type
)

SELECT * FROM avg_price
