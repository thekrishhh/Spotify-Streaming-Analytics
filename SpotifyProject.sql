-- SQL Project // Spotify Dataset

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA
SELECT COUNT(*) from spotify

SELECT COUNT(DISTINCT artist) from spotify

SELECT COUNT(DISTINCT album) from spotify

SELECT DISTINCT album_type from spotify

SELECT MAX(duration_min) from spotify

SELECT * from spotify 
WHERE duration_min = 0

DELETE from spotify
WHERE duration_min = 0

SELECT DISTINCT channel from spotify

SELECT DISTINCT most_played_on from spotify

SELECT MAX(likes) from spotify

-------------------
-- Data Analysis --
-------------------

-- Q.1 Retrieve the names of all tracks that have more than 1 billion streams.
SELECT 
	track 
from spotify
where stream > 1000000000

-- Q.2 List all albums along with their respective artists.
SELECT 
	album, 
	artist 
from spotify

-- Q.3 Get the total number of comments for tracks where licensed = TRUE.
SELECT 
	track,
	SUM(comments)
FROM spotify
WHERE licensed = 'true'
GROUP BY track
ORDER BY 2 DESC

-- Q.4 Find all tracks that belong to the album type single.
SELECT 
	track
FROM spotify
WHERE album_type = 'single'

-- Q.5 Count the total number of tracks by each artist.
SELECT 
	artist, 
	COUNT(track)
FROM spotify
GROUP BY artist
ORDER BY 2 ASC

-- Q.6 Calculate the average danceability of tracks in each album.
SELECT 
	album, 
	AVG(danceability)
FROM spotify
GROUP BY album
ORDER BY 2 DESC

-- Q.7 Find the top 5 tracks with the highest energy values.
SELECT 
	track, 
	MAX(energy)
FROM spotify
GROUP BY track
ORDER BY 2 DESC
LIMIT 5
	
-- Q.8 List all tracks along with their views and likes where official_video = TRUE.
SELECT 
	track, 
	SUM(views), 
	SUM(likes)
FROM spotify
WHERE official_video = 'true'
GROUP BY track
ORDER BY 2 DESC

-- Q.9 For each album, calculate the total views of all associated tracks.
SELECT 
	album,
	SUM(views)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC 

-- Q.10 Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * 
FROM
(SELECT 
	track,
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' then stream END), 0) as streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' then stream END), 0) as streamed_on_spotify
FROM spotify
GROUP BY 1)
WHERE 
	streamed_on_spotify > streamed_on_youtube
	AND streamed_on_youtube <> 0

-- Q.11 Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist 
AS
(SELECT 
	artist,
	track,
	SUM(views),
	DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) as rank
FROM spotify
GROUP BY 1, 2
ORDER BY 1, 3 DESC)

SELECT * 
FROM ranking_artist
WHERE rank <= 3

-- Q.12 Write a query to find tracks where the liveness score is above the average.
SELECT 
	artist,
	track,
	liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

-- Q.13 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH CTE
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1)
SELECT 
	album,
	highest_energy - lowest_energy as energy_difference
FROM CTE
ORDER BY 2 DESC

-- Q.14 Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT 
	track,
	energy_liveness
FROM spotify
WHERE energy_liveness < 1.2
ORDER BY 2 DESC

-- Q.15 Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT 
	track,
	views,
	likes,
	SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify

