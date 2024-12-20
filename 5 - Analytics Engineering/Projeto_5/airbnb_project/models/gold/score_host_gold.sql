WITH final AS (
    SELECT 
        host_id,
        host_name,
        AVG(review_scores_rating) AS media_avaliacao
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY host_id, host_name
    HAVING AVG(review_scores_rating) IS NOT NULL
    ORDER BY host_name DESC
)

SELECT * FROM final
