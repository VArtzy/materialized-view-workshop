Linux main 5.10.0-33-amd64 #1 SMP Debian 5.10.226-1 (2024-10-03) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Apr 11 18:20:44 2025 from 
root@main:~# psql -U postgres -d mview -h localhost
Password for user postgres: 
psql (13.20 (Debian 13.20-0+deb11u1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

mview=# CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX
mview=# INSERT INTO products (name, category, price) VALUES
('Laptop Pro', 'Electronics', 1299.99),
('Desk Chair', 'Furniture', 249.50),
('Coffee Maker', 'Appliances', 89.99),
('Bluetooth Speaker', 'Electronics', 79.95);
ERROR:  column "category" of relation "products" does not exist
LINE 1: INSERT INTO products (name, category, price) VALUES
                                    ^
mview=# DESCRIBE products;
ERROR:  syntax error at or near "DESCRIBE"
LINE 1: DESCRIBE products;
        ^
mview=# DESCRIBE TABLE  products;
ERROR:  syntax error at or near "DESCRIBE"
LINE 1: DESCRIBE TABLE  products;
        ^
mview=# DESCRIBE TABLE products;
ERROR:  syntax error at or near "DESCRIBE"
LINE 1: DESCRIBE TABLE products;
        ^
mview=# \d
                   List of relations
 Schema |          Name           |   Type   |  Owner   
--------+-------------------------+----------+----------
 public | orders                  | table    | postgres
 public | orders_order_id_seq     | sequence | postgres
 public | products                | table    | postgres
 public | products_product_id_seq | sequence | postgres
(4 rows)

mview=# \d products
mview=# ALTER TABLE products RENAME cateogry TO category;
ALTER TABLE
mview=# INSERT INTO products (name, category, price) VALUES
('Laptop Pro', 'Electronics', 1299.99),
('Desk Chair', 'Furniture', 249.50),
('Coffee Maker', 'Appliances', 89.99),
('Bluetooth Speaker', 'Electronics', 79.95);
INSERT 0 4
mview=# INSERT INTO orders (product_id, quantity, unit_price, order_date, customer_id)
SELECT 
    (random() * 3 + 1)::int AS product_id,
    (random() * 5 + 1)::int AS quantity,
    p.price * (0.9 + random() * 0.2) AS unit_price,
    CURRENT_DATE - (random() * 365)::int AS order_date,
    (random() * 100)::int AS customer_id
FROM products p
CROSS JOIN generate_series(1,1000);
INSERT 0 4000
mview=# SELECT COUNT(*) FROM products;
 count 
-------
     4
(1 row)

mview=# SELECT COUNT(*) FROM orders;
 count 
-------
  4000
(1 row)

mview=# SELECT 
    p.category,
    COUNT(o.order_id) AS order_count,
    SUM(o.quantity * o.unit_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;
  category   | order_count | total_revenue 
-------------+-------------+---------------
 Furniture   |        1355 |    2017462.55
 Appliances  |        1292 |    1975385.07
 Electronics |        1353 |    2000583.92
(3 rows)

mview=# CREATE MATERIALIZED VIEW sales_summary AS
mview-# SELECT
mview-# product_id,
mview-# SUM(quantity) AS total_units,
mview-# AVG(unit_price) AS avg_price
mview-# FROM orders
mview-# GROUP BY product_id;
SELECT 4
mview=# /d
mview-# \d
                        List of relations
 Schema |          Name           |       Type        |  Owner   
--------+-------------------------+-------------------+----------
 public | orders                  | table             | postgres
 public | orders_order_id_seq     | sequence          | postgres
 public | products                | table             | postgres
 public | products_product_id_seq | sequence          | postgres
 public | sales_summary           | materialized view | postgres
(5 rows)

mview-# \d sales_summary 
        Materialized view "public.sales_summary"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 product_id  | integer |           |          | 
 total_units | bigint  |           |          | 
 avg_price   | numeric |           |          | 

mview-# \d products
mview-# \d products_product_id_seq 
              Sequence "public.products_product_id_seq"
  Type   | Start | Minimum |  Maximum   | Increment | Cycles? | Cache 
---------+-------+---------+------------+-----------+---------+-------
 integer |     1 |       1 | 2147483647 |         1 | no      |     1
Owned by: public.products.product_id

mview-# CREATE INDEX idx_sales_summary_product ON sales_summary(product_id)
mview-# \d sales_summary 
        Materialized view "public.sales_summary"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 product_id  | integer |           |          | 
 total_units | bigint  |           |          | 
 avg_price   | numeric |           |          | 

mview-# \d
                        List of relations
 Schema |          Name           |       Type        |  Owner   
--------+-------------------------+-------------------+----------
 public | orders                  | table             | postgres
 public | orders_order_id_seq     | sequence          | postgres
 public | products                | table             | postgres
 public | products_product_id_seq | sequence          | postgres
 public | sales_summary           | materialized view | postgres
(5 rows)

mview-# ;
ERROR:  syntax error at or near "/"
LINE 1: /d
        ^
mview=# CREATE INDEX idx_sales_summary_product ON sales_summary(product_id);
CREATE INDEX
mview=# \d sales_summary         Materialized view "public.sales_summary"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 product_id  | integer |           |          | 
 total_units | bigint  |           |          | 
 avg_price   | numeric |           |          | 
Indexes:
    "idx_sales_summary_product" btree (product_id)

mview=# \d                        List of relations
 Schema |          Name           |       Type        |  Owner   
--------+-------------------------+-------------------+----------
 public | orders                  | table             | postgres
 public | orders_order_id_seq     | sequence          | postgres
 public | products                | table             | postgres
 public | products_product_id_seq | sequence          | postgres
 public | sales_summary           | materialized view | postgres
(5 rows)

mview=# \d sales_summary 
        Materialized view "public.sales_summary"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 product_id  | integer |           |          | 
 total_units | bigint  |           |          | 
 avg_price   | numeric |           |          | 
Indexes:
    "idx_sales_summary_product" btree (product_id)

mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# REFRESH MATERIALIZED VIEW sales_summary; -- Manual refresh
REFRESH MATERIALIZED VIEW
mview=# CREATE OR REPLACE FUNCTION refresh_materialized_views()
RETURNS VOID AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY sales_by_category;
    REFRESH MATERIALIZED VIEW CONCURRENTLY customer_purchases;
    -- Add more views as needed
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION
mview=# CREATE EXTENSION IF NOT EXISTS pg_cron;
SELECT cron.schedule('0 2 * * *', $$SELECT refresh_materialized_views()$$);
ERROR:  could not open extension control file "/usr/share/postgresql/13/extension/pg_cron.control": No such file or directory
ERROR:  schema "cron" does not exist
LINE 1: SELECT cron.schedule('0 2 * * *', $$SELECT refresh_materiali...
               ^
mview=# exit
root@main:~# sudo apt-getinstall postres-13-cron
sudo: apt-getinstall: command not found
root@main:~# sudo apt-get install postres-13-cron
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package postres-13-cron
root@main:~# sudo apt-get install postres-15-cron
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package postres-15-cron
root@main:~# sudo apt-get install postres-cron
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package postres-cron
root@main:~# psql -U postgres -d mview -h localhost
Password for user postgres: 
psql (13.20 (Debian 13.20-0+deb11u1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

mview=# ANALYZE products;
ANALYZE
mview=# ANALYZE orders;
ANALYZE
mview=# CREATE MATERIALIZED VIEW user_activity
WITH (timescaledb.continuous) AS
SELECT 
    user_id, 
    COUNT(*) AS events_last_hour
FROM user_events
WHERE event_time > NOW() - INTERVAL '1 hour'
GROUP BY user_id;
ERROR:  relation "user_events" does not exist
LINE 6: FROM user_events
             ^
mview=# SELECT add_continuous_aggregate_policy('user_activity',
  start_offset => INTERVAL '1 hour',
  end_offset => INTERVAL '5 minutes',
  schedule_interval => INTERVAL '5 minutes');
ERROR:  function add_continuous_aggregate_policy(unknown, start_offset => interval, end_offset => interval, schedule_interval => interval) does not exist
LINE 1: SELECT add_continuous_aggregate_policy('user_activity',
               ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
mview=# 
