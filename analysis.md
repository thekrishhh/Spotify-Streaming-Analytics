# 📊 Spotify Data Analysis (Detailed SQL Analysis)

This file contains all business questions, SQL queries, and insights derived from the Spotify dataset.

---

## 🎯 Q1: Which tracks have the highest streams?

**SQL Query:**

```sql
SELECT track, SUM(streams) AS total_streams
FROM spotify_data
GROUP BY track
ORDER BY total_streams DESC
LIMIT 10;
```

**Explanation:**
Groups tracks and calculates total streams for each track, then sorts them in descending order.

**Insight:**
Top tracks dominate a large portion of total streams.

---

## 🎯 Q2: Which artists are most popular?

**SQL Query:**

```sql
SELECT artist, SUM(streams) AS total_streams
FROM spotify_data
GROUP BY artist
ORDER BY total_streams DESC
LIMIT 10;
```

**Explanation:**
Aggregates total streams per artist to identify the most popular ones.

**Insight:**
A few artists contribute significantly to total streaming numbers.

---

## 🎯 Q3: How does energy affect engagement?

**SQL Query:**

```sql
SELECT track, energy, views, likes
FROM spotify_data
ORDER BY energy DESC;
```

**Explanation:**
Lists tracks with their energy levels and engagement metrics.

**Insight:**
High-energy tracks generally show higher engagement.

---

## 🎯 Q4: Tracks with high energy-to-liveness ratio

**SQL Query:**

```sql
SELECT track, energy, liveness, (energy/liveness) AS ratio
FROM spotify_data
WHERE liveness > 0
ORDER BY ratio DESC;
```

**Explanation:**
Calculates ratio between energy and liveness to identify highly energetic studio-like tracks.

**Insight:**
Tracks with high ratios are likely more polished and less live-recorded.

---

## 🎯 Q5: Cumulative likes based on views (Window Function)

**SQL Query:**

```sql
SELECT track, views, likes,
SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify_data;
```

**Explanation:**
Uses a window function to calculate running total of likes ordered by views.

**Insight:**
Tracks with higher visibility tend to accumulate more likes over time.

---

## 🚀 Conclusion

* SQL can be used effectively for real-world data analysis
* Window functions help in understanding trends over time
* Music popularity is influenced by engagement and audio features
