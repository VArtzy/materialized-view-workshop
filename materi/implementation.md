## Implementation

### PostgreSQL Example
```sql
-- Create materialized view
CREATE MATERIALIZED VIEW sales_summary AS
SELECT 
    product_id,
    SUM(quantity) AS total_units,
    AVG(unit_price) AS avg_price
FROM orders
GROUP BY product_id;

-- Manual refresh
REFRESH MATERIALIZED VIEW sales_summary;

-- Add index for faster queries
CREATE INDEX idx_sales_summary_product ON sales_summary(product_id);
```

### Oracle Example
```sql
-- Create with automatic refresh
CREATE MATERIALIZED VIEW customer_orders
REFRESH COMPLETE ON DEMAND
ENABLE QUERY REWRITE
AS
SELECT customer_id, COUNT(*) AS order_count 
FROM orders 
GROUP BY customer_id;

-- Scheduled refresh
BEGIN
  DBMS_MVIEW.REFRESH('CUSTOMER_ORDERS', 'F');
END;
```

### Hands-on Exercise
**Task:** Create a materialized view that:
1. Aggregates daily revenue by product category
2. Automatically refreshes every night at 2 AM
3. Includes an index on the category column

*Hint: Use PostgreSQL's `REFRESH MATERIALIZED VIEW CONCURRENTLY` to allow reads during refresh.*
