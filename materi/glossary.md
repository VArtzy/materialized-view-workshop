# Glossary

## A

### Aggregation
A computation that summarizes multiple rows of data (e.g., SUM, AVG, COUNT) stored pre-computed in materialized views.

### Automatic Refresh
The process where a materialized view updates itself without manual intervention based on triggers or schedules.

## C

### Change Data Capture (CDC)
Method to identify and track changes in source data for incremental view refreshes.

### Continuous Aggregate
Specialized materialized view (in TimescaleDB) that auto-refreshes time-series data in rolling windows.

## D

### Database Snapshot
A point-in-time static copy of data, similar to a materialized view but without query-specific optimization.

## E

### Eager Refresh
Immediate view update when source data changes (vs. lazy deferred refresh).

## F

### Full Refresh
Complete recomputation of all data in a materialized view, typically more resource-intensive than incremental refresh.

## I

### Incremental Refresh
Update method that only processes changed source data since last refresh, reducing computational overhead.

### Index-Organized Materialized View
A view physically stored as an index structure for faster access patterns.

## M

### Materialized View Log
Oracle's change tracking mechanism for incremental refreshes (equivalent to PostgreSQL's write-ahead log).

## P

### Partial Materialization
Strategy where only frequently accessed subsets of data are stored in the view.

### Primary Key Materialized View
A view that includes a primary key to enable concurrent refreshes without blocking reads.

## Q

### Query Rewrite
Database optimization where queries against base tables are automatically redirected to materialized views.

## R

### Refresh Interval
Time period between materialized view updates (e.g., 15 minutes, daily).

### Rollup Aggregation
Pre-computed hierarchical summaries (e.g., daily → monthly → yearly) stored in nested materialized views.

## S

### Staleness
Measure of how outdated a materialized view is compared to its source tables.

### Summary Table
Alternative term for materialized view, especially in MySQL/MariaDB contexts.

## T

### TTL (Time-To-Live)
Expiration policy that automatically purges old data from materialized views.

## V

### View Synchronization
Process of ensuring all materialized view replicas in distributed systems stay consistent.
