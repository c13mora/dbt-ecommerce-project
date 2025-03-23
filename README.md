# E-commerce Data Analysis with PostgreSQL, and dbt.

This project demonstrates simple way of taking data from a PostgreSQL schema with E-Commerce data, and using dbt to create new, analytical tables to be loaded in a new schema (ETL).

## Project Overview

1.  **PostgreSQL Schema Creation:** We begin by creating a relational database schema in PostgreSQL's `public` schema. This schema models an e-commerce platform, including tables for customers, products, orders, and related entities.

2.  **Schema Visualization:** The database schema is visualized using [dbdiagram.io](https://dbdiagram.io/d), providing a clear graphical representation of the tables and their relationships.

3.  **dbt Data Transformation:** We utilize [dbt (data build tool)](https://www.getdbt.com/) to model and transform the data from the `public` schema into a new schema named `test_schema_2`. dbt allows us to define data transformations using SQL and manage our data pipeline efficiently.

4.  **Analytical Tables:** Within `test_schema_2`, we create new tables specifically designed for analytical purposes. These tables aggregate sales data from various business perspectives, such as:
    * Sales by product category
    * Monthly sales trends
    * Customer purchase frequency
    * Sales by location

## Technologies Used

* PostgreSQL
* dbt (data build tool)
* dbdiagram.io
