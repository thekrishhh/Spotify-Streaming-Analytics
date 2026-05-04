# 🎧 Spotify Streaming Analytics (SQL Project)

## 👨‍💻 About This Project
This project was built as part of my SQL learning journey. I used a real Spotify dataset to practice solving business problems and improve my data analysis skills using SQL.

## 📌 Objective
Analyze Spotify streaming data using SQL to identify trends in music popularity, artist performance, and user engagement.

## 🗂 Dataset

The dataset contains:
* Track name, artist, album
* Audio features (energy, danceability, liveness)
* Engagement metrics (views, likes, comments, streams)

## 🛠 Tools Used

* SQL (PostgreSQL)

## 🔍 Key Business Questions Solved

1. Which tracks have the highest streams?
2. Which artists are most popular?
3. How does energy affect engagement?
4. Tracks with high energy-to-liveness ratio
5. Cumulative likes based on views (Window Functions)

📄 All questions and SQL queries are available in [Analysis.md](./Analysis.md)

## ⚙️ SQL Concepts Used

* GROUP BY & Aggregation
* ORDER BY & Filtering
* Window Functions
* CTE (Common Table Expressions)
* Subqueries
* Indexing (for query optimization) 

## 📊 Key Insights

* A small number of tracks dominate total streams
* High-energy songs tend to receive higher engagement, indicating that energetic tracks may perform better in streaming platforms.
* Engagement is strongly linked with visibility (views)
* Demonstrated query optimization using indexing and execution plan analysis

## 🚀 What I Learned

* Writing optimized SQL queries
* Using window functions for real-world analysis
* Understanding music data trends

## 📎 Files in this Repo

- 📄 [Spotify_Dataset.csv](./Spotify_Dataset.csv) → Dataset  
- 📄 [SpotifyProject.sql](./SpotifyProject.sql) → All SQL queries  

---
