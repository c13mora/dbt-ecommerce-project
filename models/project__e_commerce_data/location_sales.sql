-- Purpose: Analyze sales by location.

SELECT
    dl.city,
    dl.state,
    dl.country,
    SUM(fs.total_amount) AS total_sales
FROM
     {{ ref('fact_sales')}} fs
JOIN
     {{ ref('dim_location')}} dl ON fs.location_key = dl.location_key
GROUP BY
    dl.city, dl.state, dl.country
ORDER BY
    total_sales DESC