# Spotify_Database_Analysis
This project involves a deep-dive analysis of a comprehensive Spotify Dataset using PostgreSQL. The analysis bridges the gap between raw music metadata and actionable industry insights, focusing on two key dimensions: Audio Performance and Platform Engagement.
![Spotify_logo](https://github.com/devt2503-blip/Spotify_Database_Analysis/blob/main/spotify_logo.jpg)

## Overview
This project involves a comprehensive analysis of a Spotify dataset containing various attributes about tracks, albums, and artists. Using PostgreSQL, the project transitions from basic data exploration and cleaning to advanced queries that analyze audio features (like energy and liveness) and compare streaming performance across platforms (Spotify vs. YouTube).

## Schema 
```sql
-- create table
DROP TABLE IF EXISTS spotify;
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
```
