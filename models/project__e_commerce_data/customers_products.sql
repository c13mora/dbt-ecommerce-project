{{ config(materialized='table') }}

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    p.product_id,
    p.product_name,
    p.price,
    oi.quantity,
    o.order_id,
    o.order_date
FROM
    {{ ref('customers') }} c
JOIN
    {{ ref('orders') }} o ON c.customer_id = o.customer_id
JOIN
    {{ ref('order_items') }} oi ON o.order_id = oi.order_id
JOIN
    {{ ref('products') }} p ON oi.product_id = p.product_id
