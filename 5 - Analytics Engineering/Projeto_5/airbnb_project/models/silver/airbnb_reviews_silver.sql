{{ config(materialized='table') }}


SELECT
    id,
    listing_id,
    TO_DATE(date, '%Y-%m-%d') AS date,
    reviewer_id,
    reviewer_name,
    {{ clean_text('comments') }} AS comments
FROM {{ ref('airbnb_reviews_bronze') }}