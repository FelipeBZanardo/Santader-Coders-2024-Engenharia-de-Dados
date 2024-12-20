with source_autos as (
    select * from {{ source('autos', 'autos_cleaned') }}
),


final as (
    select * from source_autos
)


select * from final
