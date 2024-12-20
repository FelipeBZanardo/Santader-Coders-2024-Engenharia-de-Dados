with 
source_calendar as (
    select * from {{ source('airbnb', 'calendar_bronze') }}
),

final_calendar as (
    select * from source_calendar
)

select * from final_calendar
