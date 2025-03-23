{{ config(materialized='table') }}

SELECT * FROM {{ source('test', 'order_items')}}