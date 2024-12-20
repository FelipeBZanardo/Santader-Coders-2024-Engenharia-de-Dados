with source_ibm_prices as (
    select * from {{ source("ibm_prices", "ibm_prices_bronze_lauro") }}
),

final as (
    select * from source_ibm_prices
)

select * from final