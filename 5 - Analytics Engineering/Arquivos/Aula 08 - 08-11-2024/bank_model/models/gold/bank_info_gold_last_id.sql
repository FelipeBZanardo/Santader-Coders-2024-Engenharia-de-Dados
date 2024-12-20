with last_id as (
    select customer_id, 
           max(id) as max_id
    from {{ ref('bank_info_silver')}}
    group by customer_id
),

final as (
    select bank_info_silver.customer_id
           ,credit_history_age_years as last_credit_history_age_years
           ,credit_history_months as last_credit_history_months
    from {{ ref('bank_info_silver')}} as bank_info_silver, last_id
    where bank_info_silver.id = last_id.max_id
)

select * from final

