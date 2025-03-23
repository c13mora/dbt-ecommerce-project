SET search_path TO public;

-- Dimension Tables

-- Customer Dimension
CREATE TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(255),
    registration_date DATE
);

-- Product Dimension
CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

-- Date Dimension
CREATE TABLE dim_date (
    date_key SERIAL PRIMARY KEY,
    order_date DATE,
    year INT,
    month INT,
    day INT,
    day_of_week INT
);

-- Fact Table

-- Sales Fact Table
CREATE TABLE fact_sales (
    sales_key SERIAL PRIMARY KEY,
    customer_key INT REFERENCES dim_customer(customer_key),
    product_key INT REFERENCES dim_product(product_key),
    date_key INT REFERENCES dim_date(date_key),
    order_id INT,
    quantity INT,
    total_amount DECIMAL(10, 2)
);

-- Insert Data into Dimension Tables

-- Customer Dimension
INSERT INTO dim_customer (customer_id, first_name, last_name, email, address, registration_date) VALUES
(1, 'Alice', 'Johnson', 'alice.j@example.com', '123 Main St, Anytown', '2023-01-15'),
(2, 'Bob', 'Smith', 'bob.s@example.com', '456 Oak Ave, Otherville', '2023-02-20'),
(3, 'Charlie', 'Williams', 'charlie.w@example.com', '789 Pine Ln, Somewhere', '2023-03-10'),
(4, 'Diana', 'Brown', 'diana.b@example.com', '101 Elm Rd, Nowhere', '2023-04-05'),
(5, 'Eve', 'Davis', 'eve.d@example.com', '202 Maple Dr, Everywhere', '2023-05-12');

-- Product Dimension
INSERT INTO dim_product (product_id, product_name, description, price, category) VALUES
(1, 'Adjustable Dumbbell Set', 'Set of 2 adjustable dumbbells, 5-50 lbs each', 199.99, 'Weights'),
(2, 'Resistance Bands Set', 'Set of 5 resistance bands with varying resistance levels', 29.99, 'Accessories'),
(3, 'Yoga Mat', 'Non-slip yoga mat, 6mm thickness', 24.99, 'Accessories'),
(4, 'Weightlifting Gloves', 'Leather weightlifting gloves with wrist support', 39.99, 'Accessories'),
(5, 'Pull-up Bar', 'Doorway pull-up bar, adjustable width', 49.99, 'Equipment');

-- Date Dimension
INSERT INTO dim_date (order_date, year, month, day, day_of_week) VALUES
('2023-06-01', 2023, 6, 1, 5), -- Friday
('2023-06-05', 2023, 6, 5, 2), -- Tuesday
('2023-06-10', 2023, 6, 10, 7), -- Sunday
('2023-06-15', 2023, 6, 15, 5), -- Thursday
('2023-06-20', 2023, 6, 20, 3); -- Wednesday


-- Creating a new 'Location' Dimensiom

-- Location Dimension
CREATE TABLE dim_location (
    location_key SERIAL PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);

-- Modify fact_sales to include location_key
ALTER TABLE fact_sales ADD COLUMN location_key INT REFERENCES dim_location(location_key);

-- Insert sample data into dim_location
INSERT INTO dim_location (city, state, country, postal_code) VALUES
('Anytown', 'CA', 'USA', '12345'),
('Otherville', 'NY', 'USA', '67890'),
('Somewhere', 'TX', 'USA', '54321'),
('Nowhere', 'FL', 'USA', '98765'),
('Everywhere', 'IL', 'USA', '13579');

--  Denormalizing the 'customer' Dimension

-- Address Dimension
CREATE TABLE dim_address (
    address_key SERIAL PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20)
);

-- Modify dim_customer to remove address and add address_key
ALTER TABLE dim_customer DROP COLUMN address;
ALTER TABLE dim_customer ADD COLUMN address_key INT REFERENCES dim_address(address_key);

-- Insert sample data into dim_address
INSERT INTO dim_address (address, city, state, country, postal_code) VALUES
('123 Main St', 'Anytown', 'CA', 'USA', '12345'),
('456 Oak Ave', 'Otherville', 'NY', 'USA', '67890'),
('789 Pine Ln', 'Somewhere', 'TX', 'USA', '54321'),
('101 Elm Rd', 'Nowhere', 'FL', 'USA', '98765'),
('202 Maple Dr', 'Everywhere', 'IL', 'USA', '13579');

-- Modify dim_customer to reference dim_address
UPDATE dim_customer SET address_key = 1 WHERE customer_id = 1;
UPDATE dim_customer SET address_key = 2 WHERE customer_id = 2;
UPDATE dim_customer SET address_key = 3 WHERE customer_id = 3;
UPDATE dim_customer SET address_key = 4 WHERE customer_id = 4;
UPDATE dim_customer SET address_key = 5 WHERE customer_id = 5;

-- Insert data into fact_sales (including location_key)
INSERT INTO fact_sales (customer_key, product_key, date_key, location_key, order_id, quantity, total_amount) VALUES
(1, 1, 1, 1, 1, 1, 199.99),
(1, 2, 1, 1, 1, 1, 29.99),
(2, 2, 2, 2, 2, 2, 59.98),
(3, 3, 3, 3, 1, 1, 24.99), 
(4, 4, 4, 4, 1, 1, 39.99),
(5, 1, 5, 5, 1, 1, 199.99),
(5, 5, 5, 5, 1, 1, 49.99),
(5, 3, 5, 5, 1, 1, 24.99);
