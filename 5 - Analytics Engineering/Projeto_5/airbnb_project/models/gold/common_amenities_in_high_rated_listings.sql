WITH high_rated_amenities AS (
    SELECT 
        unnest(string_to_array(amenities, ',')) AS amenity,  -- Convert string to array and unnest
        COUNT(*) AS frequency
    FROM {{ ref('airbnb_listings_silver') }}  -- Replace with table name if not using dbt
    WHERE review_scores_rating > 4.5
    GROUP BY amenity
    ORDER BY frequency DESC
    LIMIT 10
)
SELECT * FROM high_rated_amenities