WITH avg_review_score AS (
    SELECT 
        neighbourhood AS region,
        AVG(review_scores_rating) AS avg_review_score
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY 
        neighbourhood
)

SELECT * FROM avg_review_score
