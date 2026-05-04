# 📊 Spotify SQL Analysis

This file contains all business questions along with their SQL queries performed on the Spotify dataset.

## 🎯 Q1: Retrieve the names of all tracks that have more than 1 billion streams

```sql
SELECT track 
FROM spotify
WHERE stream > 1000000000;
```



## 🎯 Q2: List all albums along with their respective artists

```sql
SELECT album, artist 
FROM spotify;
```



## 🎯 Q3: Get the total number of comments for tracks where licensed = TRUE

```sql
SELECT track, SUM(comments) AS total_comments
FROM spotify
WHERE licensed = 'true'
GROUP BY track
ORDER BY total_comments DESC;
```



## 🎯 Q4: Find all tracks that belong to the album type 'single'

```sql
SELECT track
FROM spotify
WHERE album_type = 'single';
```



## 🎯 Q5: Count the total number of tracks by each artist

```sql
SELECT artist, COUNT(track) AS total_tracks
FROM spotify
GROUP BY artist
ORDER BY total_tracks ASC;
```



## 🎯 Q6: Calculate the average danceability of tracks in each album

```sql
SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album
ORDER BY avg_danceability DESC;
```



## 🎯 Q7: Find the top 5 tracks with the highest energy values

```sql
SELECT track, MAX(energy) AS max_energy
FROM spotify
GROUP BY track
ORDER BY max_energy DESC
LIMIT 5;
```



## 🎯 Q8: List all tracks along with their views and likes where official_video = TRUE

```sql
SELECT track, SUM(views) AS total_views, SUM(likes) AS total_likes
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY total_views DESC;
```



## 🎯 Q9: For each album, calculate the total views of all associated tracks

```sql
SELECT album, SUM(views) AS total_views
FROM spotify
GROUP BY album
ORDER BY total_views DESC;
```



## 🎯 Q10: Retrieve track names that have been streamed on Spotify more than YouTube

```sql
SELECT *
FROM (
    SELECT 
        track,
        COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_youtube,
        COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_spotify
    FROM spotify
    GROUP BY track
) t
WHERE streamed_on_spotify > streamed_on_youtube
AND streamed_on_youtube <> 0;
```



## 🎯 Q11: Find the top 3 most-viewed tracks for each artist using window functions

```sql
WITH ranking_artist AS (
    SELECT 
        artist,
        track,
        SUM(views) AS total_views,
        DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
    FROM spotify
    GROUP BY artist, track
)
SELECT *
FROM ranking_artist
WHERE rank <= 3;
```



## 🎯 Q12: Find tracks where the liveness score is above average

```sql
SELECT artist, track, liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);
```



## 🎯 Q13: Calculate the difference between highest and lowest energy values for each album

```sql
WITH CTE AS (
    SELECT 
        album,
        MAX(energy) AS highest_energy,
        MIN(energy) AS lowest_energy
    FROM spotify
    GROUP BY album
)
SELECT 
    album,
    highest_energy - lowest_energy AS energy_difference
FROM CTE
ORDER BY energy_difference DESC;
```



## 🎯 Q14: Find tracks where energy-to-liveness ratio is greater than 1.2

```sql
SELECT track, energy_liveness
FROM spotify
WHERE energy_liveness > 1.2
ORDER BY energy_liveness DESC;
```



## 🎯 Q15: Calculate cumulative sum of likes ordered by views (Window Function)

```sql
SELECT track, views, likes,
SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify;
```

## ⚡ Query Optimization

### 🔍 Query Used

```sql
SELECT 
    artist,
    track,
    views
FROM spotify
WHERE artist = 'Gorillaz'
AND most_played_on = 'Youtube'
ORDER BY views
LIMIT 25;
```

---

### 📉 Before Optimization

* Query used **Sequential Scan (Seq Scan)**
* Entire table was scanned
* Higher execution time, 3.163 ms

![Before Optimization](before.png)

---

### ⚡ Optimization Step

* Created index on frequently filtered columns:

```sql
CREATE INDEX idx_artist_platform 
ON spotify(artist, most_played_on);
```

---

### 📈 After Optimization

* Query uses **Index Scan**
* Only relevant rows are accessed
* Execution time reduced from 3.163 to 0.647 ms

![After Optimization](after.png)

---

### 🧠 Key Learning

* Indexing significantly improves query performance
* Useful for queries with `WHERE`, `ORDER BY`, and filtering conditions
* Should be used carefully to avoid unnecessary overhead


## 🚀 Summary

These queries demonstrate:

* Data filtering and aggregation
* Use of GROUP BY and ORDER BY
* Window functions (ranking & cumulative sum)
* CTEs (Common Table Expressions)
* Real-world business problem solving using SQL
* Basic query optimization using indexing
