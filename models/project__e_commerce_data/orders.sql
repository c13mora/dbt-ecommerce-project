{{ config(materialized='table') }}

SELECT * FROM {{ source('test', 'orders')}}