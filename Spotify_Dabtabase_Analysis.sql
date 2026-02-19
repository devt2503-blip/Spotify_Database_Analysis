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

select * from Spotify;

select count(distinct artist) from Spotify;

select distinct album_type from Spotify;

select * from Spotify where duration_min = 0;

delete  from spotify 
where duration_min = 0;
select * from Spotify where duration_min = 0;

select distinct most_played_on from Spotify;

select distinct channel from Spotify;

Problems ??

-- 1. Retrieve the names of all tracks that have more than 1 billion streams.


select * from Spotify 
where Stream > 1000000000

-- 2. List all albums along with their respective artists.

select distinct album, artist 
from Spotify;

-- 3. Get the total number of comments for tracks where licensed = TRUE.

select sum(comments) as total_comments 
from Spotify 
where licensed = TRUE;

-- 4. Find all tracks that belong to the album type single.

select * from Spotify 
where album_type ilike '%single%'

select * from Spotify 
where album_type = 'single'

-- 5. Count the total number of tracks by each artist.

select artist, 
count(track) from Spotify 
group by 1 
order by 2 desc;

-- 6. Calculate the average danceability of tracks in each album.

select album, avg(danceability) as avg_danceability from Spotify
group by album 
order by 2 
desc;

-- 7. Find the top 5 tracks with the highest energy values.

select track, max(energy) as max_energy_value 
from Spotify
group by 1 
order by 2 
desc 
limit 5;

8. List all tracks along with their views and likes where official_video = TRUE.

select track, 
sum(views) as total_views, 
sum(likes) as total_likes
from Spotify
where official_video = 'true'
group by 1
order by 2 
desc 
limit 5;

-- 9. For each album, calculate the total views of all associated tracks.

select album, track, sum(views) as total_views
from Spotify
group by 1,2
order by 3
desc ;

-- 10. Retrieve the track names that have been streamed on Youtube more than Spotify.

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

-- 11. Find the top 3 most-viewed tracks for each artist using window functions.

with ranking_artist as
(select artist, track, sum(views) as total_views, 
dense_rank() over(partition by artist order by sum(views) desc ) as rank
from Spotify 
group by 1, 2
order by 1,3 desc )
select * from ranking_artist 
where rank <= 3

-- 12. Write a query to find tracks where the liveness score is above the average.

select track, artist, liveness from Spotify
where liveness > (select avg(liveness) from Spotify)


-- (select avg(liveness) from Spotify)

-- 13. Use a WITH clause to calculate the difference
-- between the highest and lowest energy values for tracks in each album.

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

-- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2..

SELECT 
    track, 
    artist, 
    energy, 
    liveness, 
    energy_liveness
FROM spotify
WHERE energy_liveness > 1.2;

-- 15. Calculate the cumulative sum of likes for tracks 
-- ordered by the number of views, using window functions.

SELECT 
    track,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views desc) AS cumulative_likes
FROM spotify
ORDER BY views desc;

