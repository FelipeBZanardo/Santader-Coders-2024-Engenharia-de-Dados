with final as (
    select customer_id
           ,avg(num_of_delayed_payment) as mean_num_of_delayed_payment
           ,avg(num_credit_inquiries) as mean_num_credit_inquiries
    from {{ ref('bank_info_silver')}}
    group by customer_id
)

select * from final

