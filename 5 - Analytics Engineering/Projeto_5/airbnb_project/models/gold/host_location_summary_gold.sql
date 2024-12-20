WITH location_summary AS (
    SELECT
        host_location,
        COUNT(*) AS property_count
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY host_location
    ORDER BY property_count DESC
)

SELECT * FROM location_summary