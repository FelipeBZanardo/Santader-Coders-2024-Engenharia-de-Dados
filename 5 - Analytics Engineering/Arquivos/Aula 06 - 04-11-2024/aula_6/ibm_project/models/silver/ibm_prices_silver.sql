select "datetime"
        , "1. open" as "open"
        , "2. high" as "high"
        , "3. low" as "low"
        , "4. close" as "closed"
        , "5. volume" as "volume"
        , ("2. high" - "3. low") as "diff_high_low"
from {{ ref('ibm_prices_bronze')}}
