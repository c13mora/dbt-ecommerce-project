{{ config(materialized='table') }}

SELECT * FROM {{ source('test', 'products')}}