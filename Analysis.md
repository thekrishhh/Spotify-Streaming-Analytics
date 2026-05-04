# 📊 Spotify SQL Analysis – Questions & Queries

This file contains all business questions along with their SQL queries.

---

## 🎯 Q1: Which tracks have the highest streams?

```sql
SELECT track, SUM(streams) AS total_streams
FROM spotify_data
GROUP BY track
ORDER BY total_streams DESC
LIMIT 10;
```

---

## 🎯 Q2: Which artists are most popular?

```sql
SELECT artist, SUM(streams) AS total_streams
FROM spotify_data
GROUP BY artist
ORDER BY total_streams DESC
LIMIT 10;
```

---

## 🎯 Q3: Which albums have the highest total streams?

```sql
SELECT album, SUM(streams) AS total_streams
FROM spotify_data
GROUP BY album
ORDER BY total_streams DESC
LIMIT 10;
```

---

## 🎯 Q4: What are the top 10 most liked tracks?

```sql
SELECT track, SUM(likes) AS total_likes
FROM spotify_data
GROUP BY track
ORDER BY total_likes DESC
LIMIT 10;
```

---

## 🎯 Q5: Which tracks have the highest number of comments?

```sql
SELECT track, SUM(comments) AS total_comments
FROM spotify_data
GROUP BY track
ORDER BY total_comments DESC
LIMIT 10;
```

---

## 🎯 Q6: What is the average energy of tracks?

```sql
SELECT AVG(energy) AS avg_energy
FROM spotify_data;
```

---

## 🎯 Q7: What is the average danceability of tracks?

```sql
SELECT AVG(danceability) AS avg_danceability
FROM spotify_data;
```

---

## 🎯 Q8: Which tracks have energy greater than 0.8?

```sql
SELECT track, energy
FROM spotify_data
WHERE energy > 0.8
ORDER BY energy DESC;
```

---

## 🎯 Q9: Which tracks have low liveness (< 0.2)?

```sql
SELECT track, liveness
FROM spotify_data
WHERE liveness < 0.2
ORDER BY liveness;
```

---

## 🎯 Q10: Tracks with high energy-to-liveness ratio

```sql
SELECT track, energy, liveness, (energy/liveness) AS ratio
FROM spotify_data
WHERE liveness > 0
ORDER BY ratio DESC;
```

---

## 🎯 Q11: Which tracks have more than 1 million views?

```sql
SELECT track, views
FROM spotify_data
WHERE views > 1000000
ORDER BY views DESC;
```

---

## 🎯 Q12: Top 5 artists based on average likes

```sql
SELECT artist, AVG(likes) AS avg_likes
FROM spotify_data
GROUP BY artist
ORDER BY avg_likes DESC
LIMIT 5;
```

---

## 🎯 Q13: Tracks with high energy but low views

```sql
SELECT track, energy, views
FROM spotify_data
WHERE energy > 0.8 AND views < 100000
ORDER BY energy DESC;
```

---

## 🎯 Q14: Rank tracks based on streams

```sql
SELECT track, streams,
RANK() OVER (ORDER BY streams DESC) AS rank
FROM spotify_data;
```

---

## 🎯 Q15: Cumulative likes based on views

```sql
SELECT track, views, likes,
SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify_data;
```

---

## 🚀 Summary

These queries demonstrate:

* Aggregation & filtering
* Ranking & window functions
* Real-world business analysis using SQL
