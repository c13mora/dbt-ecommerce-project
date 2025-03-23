CREATE TABLE "dim_customer" (
  "customer_key" SERIAL PRIMARY KEY,
  "customer_id" INT,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "email" VARCHAR(100),
  "registration_date" DATE,
  "address_key" INT
);

CREATE TABLE "dim_product" (
  "product_key" SERIAL PRIMARY KEY,
  "product_id" INT,
  "product_name" VARCHAR(100),
  "description" TEXT,
  "price" DECIMAL(10,2),
  "category" VARCHAR(50)
);

CREATE TABLE "dim_date" (
  "date_key" SERIAL PRIMARY KEY,
  "order_date" DATE,
  "year" INT,
  "month" INT,
  "day" INT,
  "day_of_week" INT
);

CREATE TABLE "fact_sales" (
  "sales_key" SERIAL PRIMARY KEY,
  "customer_key" INT,
  "product_key" INT,
  "date_key" INT,
  "order_id" INT,
  "quantity" INT,
  "total_amount" DECIMAL(10,2),
  "location_key" INT
);

CREATE TABLE "dim_location" (
  "location_key" SERIAL PRIMARY KEY,
  "city" VARCHAR(100),
  "state" VARCHAR(100),
  "country" VARCHAR(100),
  "postal_code" VARCHAR(20)
);

CREATE TABLE "dim_address" (
  "address_key" SERIAL PRIMARY KEY,
  "address" VARCHAR(255),
  "city" VARCHAR(100),
  "state" VARCHAR(100),
  "country" VARCHAR(100),
  "postal_code" VARCHAR(20)
);

ALTER TABLE "dim_customer" ADD FOREIGN KEY ("address_key") REFERENCES "dim_address" ("address_key");

ALTER TABLE "fact_sales" ADD FOREIGN KEY ("customer_key") REFERENCES "dim_customer" ("customer_key");

ALTER TABLE "fact_sales" ADD FOREIGN KEY ("product_key") REFERENCES "dim_product" ("product_key");

ALTER TABLE "fact_sales" ADD FOREIGN KEY ("date_key") REFERENCES "dim_date" ("date_key");

ALTER TABLE "fact_sales" ADD FOREIGN KEY ("location_key") REFERENCES "dim_location" ("location_key");
