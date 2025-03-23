-- Purpose: Track sales trends over time (monthly).

SELECT
    EXTRACT(YEAR FROM dd.order_date) AS year,
    EXTRACT(MONTH FROM dd.order_date) AS month,
    SUM(fs.total_amount) AS total_sales
FROM
    {{ ref('fact_sales')}} fs
JOIN
     {{ ref('dim_date') }} dd ON fs.date_key = dd.date_key
GROUP BY
    EXTRACT(YEAR FROM dd.order_date), EXTRACT(MONTH FROM dd.order_date)
ORDER BY
    year, month