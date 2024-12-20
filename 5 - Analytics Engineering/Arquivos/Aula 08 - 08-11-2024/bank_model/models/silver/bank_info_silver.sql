WITH cleaned_char AS (
    SELECT 
        id,
        customer_id,
        REGEXP_REPLACE(num_of_delayed_payment, '[^0-9]', '', 'g') AS num_of_delayed_payment,
        SPLIT_PART(credit_history_age, ' ', 1) AS credit_history_age_years,
        SPLIT_PART(credit_history_age, ' ', 4) AS credit_history_months,
        num_credit_inquiries,
        1 AS cst_join
    FROM {{ ref('bank_info_bronze') }}
),

percentile AS (
    SELECT 
        percentile_cont(0.01) WITHIN GROUP (ORDER BY num_credit_inquiries ASC) AS num_credit_inquiries_lb,
        percentile_cont(0.99) WITHIN GROUP (ORDER BY num_credit_inquiries ASC) AS num_credit_inquiries_ub,
        1 AS cst_join
    FROM {{ ref('bank_info_bronze') }}
),

result_1 AS (
    SELECT 
        a.id,
        a.customer_id,
        COALESCE(CAST(a.num_of_delayed_payment AS INT), -1) AS num_of_delayed_payment,
        CAST(REGEXP_REPLACE(a.credit_history_age_years, '[^0-9]', '', 'g') AS INT) AS credit_history_age_years,
        CAST(REGEXP_REPLACE(a.credit_history_months, '[^0-9]', '', 'g') AS INT) AS credit_history_months,
        a.num_credit_inquiries,
        b.num_credit_inquiries_lb,
        b.num_credit_inquiries_ub
    FROM cleaned_char a
    JOIN percentile b ON a.cst_join = b.cst_join
),

final AS (
    SELECT 
        id,
        customer_id,
        num_of_delayed_payment,
        credit_history_age_years,
        credit_history_months,
        num_credit_inquiries,
        CASE
            WHEN num_credit_inquiries < num_credit_inquiries_lb THEN num_credit_inquiries_lb
            WHEN num_credit_inquiries > num_credit_inquiries_ub THEN num_credit_inquiries_ub
            ELSE num_credit_inquiries
        END AS new_num_credit_inquiries
    FROM result_1
)

-- Seleciona todos os dados finais
SELECT * FROM final