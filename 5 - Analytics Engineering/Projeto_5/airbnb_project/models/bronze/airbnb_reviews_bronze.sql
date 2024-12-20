with 
source_reviews as (
    select * from {{ source('airbnb', 'reviews_bronze') }}
),

final_reviews as (
    select * from source_reviews
)

select * from final_reviews
