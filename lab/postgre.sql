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
