with 
source_listings as (
    select * from {{ source('airbnb', 'listings_bronze') }}
),

final_listings as (
    select * from source_listings
)

select * from final_listings
