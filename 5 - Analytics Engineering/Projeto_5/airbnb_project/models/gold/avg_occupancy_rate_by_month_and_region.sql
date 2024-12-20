WITH avg_occupancy_rate AS (
    SELECT 
        l.neighbourhood AS region,
        DATE_TRUNC('month', c.date) AS month,
        AVG(CASE WHEN c.available = 'f' THEN 1 ELSE 0 END) AS occupancy_rate
    FROM {{ ref('airbnb_calendar_silver') }} c
    JOIN {{ ref('airbnb_listings_silver') }} l ON c.listing_id = l.id
    GROUP BY 
        l.neighbourhood, DATE_TRUNC('month', c.date)
)

SELECT * FROM avg_occupancy_rate
