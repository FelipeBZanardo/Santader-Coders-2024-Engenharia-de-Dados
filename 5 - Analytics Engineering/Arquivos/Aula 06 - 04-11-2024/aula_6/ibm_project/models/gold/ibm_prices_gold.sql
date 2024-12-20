select
    date("datetime") as "date"
    , max("high") as "max_high"
    , min("low") as "min_low"
    , avg("diff_high_low") as "mean_diff_high_low"
from {{ ref('ibm_prices_silver')}}
group by date("datetime")
