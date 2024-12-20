WITH final AS (
    SELECT 
        id,
        COALESCE(review_scores_rating, 0) AS review_scores_rating,
        COUNT(*) AS contagem_reviews
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY id, review_scores_rating
    ORDER BY contagem_reviews DESC
)

SELECT * FROM final
