-- Purpose: Summarize sales by product category.

SELECT
    dp.category AS product_category,
    SUM(fs.total_amount) AS total_sales
FROM
    {{ ref('fact_sales')}} fs
JOIN
    {{ ref('dim_product') }} dp ON fs.product_key = dp.product_key
GROUP BY
    dp.category