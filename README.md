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

-- Spotify_Database_Analysis --

-- create table
DROP TABLE IF EXISTS Spotify;
CREATE TABLE Spotify (
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

```sql
*Some Basic Queries*
select * from Spotify;

select count(distinct artist) from Spotify;

select distinct album_type from Spotify;

select * from Spotify where duration_min = 0;

delete  from spotify 
where duration_min = 0;
select * from Spotify where duration_min = 0;

select distinct most_played_on from Spotify;

select distinct channel from Spotify;
```

## Problems ??

-- 1. Retrieve the names of all tracks that have more than 1 billion streams.

```sql
select * from Spotify 
where Stream > 1000000000
```

-- 2. List all albums along with their respective artists.
```sql
select distinct album, artist 
from Spotify;
```
-- 3. Get the total number of comments for tracks where licensed = TRUE.
```sql
select sum(comments) as total_comments 
from Spotify 
where licensed = TRUE;
```
-- 4. Find all tracks that belong to the album type single.
```sql
select * from Spotify 
where album_type ilike '%single%'

select * from Spotify 
where album_type = 'single'
```
-- 5. Count the total number of tracks by each artist.
```sql
select artist, 
count(track) from Spotify 
group by 1 
order by 2 desc;
```
-- 6. Calculate the average danceability of tracks in each album.
```sql
select album, avg(danceability) as avg_danceability from Spotify
group by album 
order by 2 
desc;
```
-- 7. Find the top 5 tracks with the highest energy values.
```sql
select track, max(energy) as max_energy_value 
from Spotify
group by 1 
order by 2 
desc 
limit 5;
```
8. List all tracks along with their views and likes where official_video = TRUE.
```sql
select track, 
sum(views) as total_views, 
sum(likes) as total_likes
from Spotify
where official_video = 'true'
group by 1
order by 2 
desc 
limit 5;
```
-- 9. For each album, calculate the total views of all associated tracks.
```sql
select album, track, sum(views) as total_views
from Spotify
group by 1,2
order by 3
desc ;
```
-- 10. Retrieve the track names that have been streamed on Youtube more than Spotify.
```sql
select * from 
(select track,
coalesce(sum(case when most_played_on = 'Youtube' then stream end), 0) as stream_on_youtube,
coalesce(sum(case when most_played_on = 'Spotify' then stream end), 0) as stream_on_spotify
from Spotify 
group by 1
) as t1
 where stream_on_youtube > stream_on_spotify
 and 
 stream_on_spotify <> 0
```
-- 11. Find the top 3 most-viewed tracks for each artist using window functions.
```sql
with ranking_artist as
(select artist, track, sum(views) as total_views, 
dense_rank() over(partition by artist order by sum(views) desc ) as rank
from Spotify 
group by 1, 2
order by 1,3 desc )
select * from ranking_artist 
where rank <= 3
```
-- 12. Write a query to find tracks where the liveness score is above the average.
```sql
select track, artist, liveness from Spotify
where liveness > (select avg(liveness) from Spotify)


-- (select avg(liveness) from Spotify)
```
-- 13. Use a WITH clause to calculate the difference
-- between the highest and lowest energy values for tracks in each album.
```sql
with difference
as
(select album, 
max(energy) as highest_energy,
min(energy) as lowest_energy
from Spotify 
group by 1
)
select album, 
highest_energy - lowest_energy as energy_difference
from difference
order by 2 desc
```
