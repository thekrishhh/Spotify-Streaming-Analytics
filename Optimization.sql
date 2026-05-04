---

-- Query Optimization & Indexing

---

-- 🎯 Objective:
-- Improve query performance by reducing execution time using indexing.

---

-- 🔍 Query Used for Optimization

---

EXPLAIN ANALYZE
SELECT
artist,
track,
views
FROM spotify
WHERE artist = 'Gorillaz'
AND most_played_on = 'Youtube'
ORDER BY views
LIMIT 25;

---

-- ⚠️ Before Optimization

---

-- Observation:
-- - Query uses Sequential Scan (Seq Scan)
-- - Entire table is scanned
-- - Higher execution time

---

-- ⚡ Optimization Step

---

-- Creating index on columns used in filtering

CREATE INDEX artist_name ON spotify (artist)

---

-- ✅ After Optimization

---

-- Observation:
-- - Query uses Index Scan
-- - Only relevant rows are accessed
-- - Execution time is reduced

---

-- 🧠 Notes

---

-- Indexes improve performance of SELECT queries
-- especially when using WHERE, ORDER BY, and GROUP BY

-- However:
-- - Too many indexes can slow down INSERT/UPDATE
-- - Indexes should be created based on query usage
