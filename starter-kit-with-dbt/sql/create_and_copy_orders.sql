-- Create schemas once
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS stg;
CREATE SCHEMA IF NOT EXISTS marts;

-- Create a target table (if not using Singer auto-create)
CREATE TABLE IF NOT EXISTS raw.orders (
    order_id     BIGINT PRIMARY KEY,
    order_ts     TIMESTAMPTZ NOT NULL,
    customer_id  BIGINT NOT NULL,
    amount       NUMERIC(12,2) NOT NULL,
    status       TEXT NOT NULL
);

-- SERVER-SIDE COPY (requires the file to be on the DB server's filesystem)
-- Adjust the absolute path accordingly if your server is remote.
-- COPY raw.orders FROM '/absolute/path/to/sample_orders.csv' WITH (FORMAT CSV, HEADER TRUE);

-- CLIENT-SIDE COPY using psql (works from your machine):
-- Run this inside psql, replacing the path below if needed:
\copy raw.orders FROM '/mnt/data/starter-kit/data/sample_orders.csv' WITH (FORMAT CSV, HEADER TRUE);

-- Verify load
SELECT COUNT(*) AS rowcount FROM raw.orders;
SELECT * FROM raw.orders ORDER BY order_id LIMIT 5;
