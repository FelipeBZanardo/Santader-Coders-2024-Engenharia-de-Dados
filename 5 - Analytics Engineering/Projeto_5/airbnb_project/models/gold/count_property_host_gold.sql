WITH final AS (
    SELECT
        host_id,
        host_name,
        COUNT(*) AS contagem_imoveis
    FROM {{ ref('airbnb_listings_silver') }}
    GROUP BY host_id, host_name
    ORDER BY contagem_imoveis DESC
)

SELECT * FROM final
