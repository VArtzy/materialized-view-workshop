## Fundamental

### Materialized View vs. Standard View
| Feature              | Standard View               | Materialized View           |
|----------------------|----------------------------|----------------------------|
| Storage              | Query definition only      | Physical data storage       |
| Performance          | No improvement             | Fast reads                  |
| Freshness            | Always current             | Requires refresh            |
| Maintenance          | None                       | Storage + refresh overhead  |

### Refresh Mechanisms
- **Full Refresh:** Recomputes entire view (simpler but resource-intensive)
- **Incremental Refresh:** Only updates changed data (complex but efficient)
- **Refresh Triggers:** 
  - Time-based (hourly/daily)
  - Event-based (source table changes)
  - Manual (on-demand)
