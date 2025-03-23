-- Purpose: Analyze customer purchase behavior.

SELECT
    dc.customer_id,
    COUNT(fs.order_id) AS purchase_count,
    MIN(dd.order_date) AS first_purchase_date,
    MAX(dd.order_date) AS last_purchase_date
FROM
     {{ ref('fact_sales')}} fs
JOIN
     {{ ref('dim_customer')}} dc ON fs.customer_key = dc.customer_key
JOIN
     {{ ref('dim_date')}} dd ON fs.date_key = dd.date_key
GROUP BY
    dc.customer_id
ORDER BY
    purchase_count DESC