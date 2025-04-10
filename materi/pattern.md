## Advanced Patterns

### Incremental Refresh (Change Data Capture)
```sql
-- PostgreSQL example using logical replication
CREATE MATERIALIZED VIEW user_activity
WITH (timescaledb.continuous) AS
SELECT 
    user_id, 
    COUNT(*) AS events_last_hour
FROM user_events
WHERE event_time > NOW() - INTERVAL '1 hour'
GROUP BY user_id;

-- Auto-refreshes every 5 minutes
SELECT add_continuous_aggregate_policy('user_activity',
  start_offset => INTERVAL '1 hour',
  end_offset => INTERVAL '5 minutes',
  schedule_interval => INTERVAL '5 minutes');
```

### Distributed Systems Pattern
![Materialized View in Microservices](https://example.com/mv-microservices.png)
1. Source service publishes change events to Kafka
2. Materialized view consumer processes events
3. Results stored in dedicated read-optimized DB
