use imdb_ijs;


-- The big picture

-- 1.How many actors are there in the actors table?

SELECT
    COUNT(distinct id) as total_actors
FROM
    actors;
    
-- 2.How many directors are there in the directors table?
SELECT
    COUNT(distinct id) as total_directors
FROM
    directors;

-- 3.How many movies are there in the movies table?
    
    SELECT 
    COUNT(*)
FROM
    movies;
    
    
-- Exploring the movies

-- 4.From what year are the oldest and the newest movies? What are the names of those movies?

  SELECT 
    MIN(year) AS oldest_year, 
    MAX(year) AS newest_year
FROM
    movies;


-- 5.What movies have the highest and the lowest ranks?

SELECT 
    name, `rank`
FROM
    movies
WHERE
    `rank` = (SELECT 
            MAX(`rank`)
        FROM
            movies)
        OR `rank` = (SELECT 
            MIN(`rank`)
        FROM
            movies)
            order by `rank`;
    
-- 6.What is the most common movie title?

SELECT 
    `name`, 
    COUNT(*) AS total_count
FROM
    movies
GROUP BY `name`
ORDER BY total_count DESC
limit 1;

-- 7.Which genre is the highest-ranked on average?

SELECT 
   mg.genre, round(avg(m.rank),1) as avg_rank
FROM
    movies m
        JOIN
    movies_genres mg ON mg.movie_id = m.id
group by mg.genre
order by avg_rank desc
limit 1;

-- Understanding the database

-- 8.Are there movies with multiple directors?


SELECT 
    md.movie_id,
    m.name AS movie_name,
    COUNT(md.director_id) AS director_count
FROM
    movies_directors md
        JOIN
    movies m ON m.id = md.movie_id
GROUP BY md.movie_id , m.name
HAVING director_count> 1
ORDER BY director_count DESC;



-- 9.What is the movie with the most directors? Why do you think it has so many?
SELECT 
    md.movie_id,
    m.name AS movie_name,
    COUNT(md.director_id) AS director_count
FROM
    movies_directors md
        JOIN
    movies m ON m.id = md.movie_id
GROUP BY md.movie_id, m.name
ORDER BY director_count DESC;


-- 10.On average, how many actors are listed for each movie?

SELECT 
    AVG(n_actors)
FROM
    (SELECT 
        movie_id, COUNT(distinct actor_id) AS n_actors
    FROM
        roles
    GROUP BY movie_id) as x ;
    

-- 11. Are there movies with more than one “genre”?

SELECT 
    movie_id, COUNT(genre)
FROM
    movies_genres
GROUP BY movie_id
HAVING COUNT(genre) > 1
ORDER BY COUNT(genre) DESC;



-- 12.Compute the average, minimum, and maximum rank for movies released each decade.


SELECT 
    (`year` - (`year` % 10)) AS decade, -- can also use FLOOR(m.year / 10) * 10 AS decade,
    AVG(`rank`) AS avg_rank,
    MIN(`rank`) AS min_rank,
    MAX(`rank`) AS max_rank
FROM movies
GROUP BY decade
ORDER BY decade;


-- Looking for specific movies


-- 13. Can you find the movie called “Pulp Fiction”?

SELECT 
    *
FROM
    movies
WHERE
    name LIKE 'Pulp Fiction';

-- 14. Who directed it?
SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS full_name
FROM
    directors d
        JOIN
    movies_directors md ON md.director_id = d.id
        JOIN
    movies m ON m.id = md.movie_id
WHERE
    m.name LIKE 'pulp fiction';

-- 15.Which actors were cast in it?
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name
FROM
    actors a
        JOIN
    roles r ON r.actor_id = a.id
        JOIN
    movies m ON m.id = r.movie_id
WHERE
    m.name LIKE 'pulp fiction';
    

    
-- 16.Can you find the movie called “La Dolce Vita”?

SELECT 
    *
FROM
    movies
WHERE
    name LIKE '%La Dolce Vita%';
    
-- 17Who directed it?

SELECT 
    CONCAT(d.first_name, ' ', d.last_name) AS full_name
FROM
    directors d
        JOIN
    movies_directors md ON md.director_id = d.id
        JOIN
    movies m ON m.id = md.movie_id
WHERE
    m.name LIKE '%Dolce Vita%, la';
    

    
-- 18.Which actors were cast in it?
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name
FROM
    actors a
        JOIN
    roles r ON r.actor_id = a.id
        JOIN
    movies m ON m.id = r.movie_id
WHERE
    m.name LIKE '%dolce vita, la';
    
    

-- 19.When was the movie “Titanic” by James Cameron released?
-- Hint: there are many movies named “Titanic”. We want the one directed by James Cameron.
-- Hint 2: the name “James Cameron” is stored with a weird character on it.


SELECT 
     m.name, m.year, d.first_name, d.last_name
FROM
    movies m
        JOIN
    movies_directors md ON m.id = md.movie_id
        JOIN
    directors d ON d.id = md.director_id
WHERE
    m.name like 'titanic'
    and d.first_name like '%James%'
    and d.last_name like '%Cameron%';
    



-- Actors and directors

-- 20.What are the genres of movies directed by James Cameron who directed Titanic?

SELECT 
    mg.genre, count(mg.genre) as count
FROM
    movies_genres mg
        JOIN
        movies_directors md on md.movie_id=mg.movie_id
        join
    directors d ON d.id = md.director_id
where 
d.first_name='James (I)'
and 
d.last_name='Cameron'
group by mg.genre;






-- 21.What is the probability of James Cameron working on a Horror movie?
SELECT 
    COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            movies m
                JOIN
            movies_directors md ON m.id = md.movie_id
                JOIN
            directors d ON d.id = md.director_id
        WHERE
            d.first_name LIKE '%James%'
                AND d.last_name LIKE '%Cameron%')
FROM
    movies m
        JOIN
    movies_genres mg ON m.id = mg.movie_id
        JOIN
    movies_directors md ON m.id = md.movie_id
        JOIN
    directors d ON d.id = md.director_id
WHERE
    mg.genre = 'Horror'
        AND d.first_name LIKE '%James%'
        AND d.last_name LIKE '%Cameron%';

-- 2nd method
  
  SELECT 
    (SELECT 
            COUNT(*)
        FROM
            movies_directors md
                JOIN
            movies_genres mg ON md.movie_id = mg.movie_id
        WHERE
            md.director_id = (SELECT 
                    id
                FROM
                    directors
                WHERE
                    first_name = 'James (I)'
                        AND last_name = 'Cameron')
                AND mg.genre = 'Horror') 
                /
		(SELECT 
            COUNT(*)
        FROM
            movies_directors
        WHERE
            director_id = (SELECT 
                    id
                FROM
                    directors
                WHERE
                    first_name = 'James (I)'
                        AND last_name = 'Cameron')) AS probability_of_horror;


-- 22.What’s the average rank of a movie by James Cameron?

SELECT 
    AVG(m.`rank`) AS average
FROM
    movies m
        JOIN
    movies_directors md ON md.movie_id = m.id
        JOIN
    directors d ON d.id = md.director_id
WHERE
    d.first_name LIKE '%james%'
        AND d.last_name LIKE '%cameron%';



-- 23.Who is the actor that acted more times as “Himself”?

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    COUNT(a.id) AS appearance
FROM
    actors a
        JOIN
    roles r ON a.id = r.actor_id
WHERE
    r.role LIKE '%Himself%'
GROUP BY a.id, full_name
ORDER BY appearance DESC
LIMIT 1;





-- 24.What is the most common name for actors? And for directors?
-- for actors
-- most common first name
SELECT DISTINCT
    (first_name), COUNT(*) AS name_count
FROM
    actors
GROUP BY first_name
ORDER BY name_count DESC;

-- most common last name
SELECT DISTINCT
    (last_name), COUNT(*) AS name_count
FROM
    actors
GROUP BY last_name
ORDER BY name_count DESC;

-- most common full name
SELECT 
    CONCAT(first_name, ' ', last_name) AS fullname, COUNT(*)
FROM
    actors
GROUP BY fullname
ORDER BY COUNT(*) DESC;

-- And for directors
-- most common first name
SELECT 
    first_name, COUNT(*)
FROM
    directors
GROUP BY 1
ORDER BY 2 DESC;

-- most common last name

SELECT 
    last_name, COUNT(*)
FROM
    directors
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    CONCAT(first_name, ' ', last_name) AS fullname, COUNT(*)
FROM
    directors
GROUP BY fullname
ORDER BY COUNT(*) DESC;

-- 25.Which directors have Samuel L. Jackson worked with?
SELECT DISTINCT
    d.first_name, d.last_name
FROM
    directors d
        JOIN
    movies_directors md ON d.id = md.director_id
        JOIN
    roles r ON md.movie_id = r.movie_id
        JOIN
    actors a ON r.actor_id = a.id
WHERE
    a.first_name = 'Samuel L.'
        AND a.last_name = 'Jackson';
        
-- 26.What is the highest-ranked movie Samuel L. Jackson has been in?

SELECT 
   m.name, m.rank
FROM
    actors a
        JOIN
    roles r ON r.actor_id = a.id
        JOIN
    movies m ON m.id = r.movie_id
WHERE
    a.first_name = 'samuel l.'
        AND a.last_name ='jackson'
ORDER BY m.rank DESC;

-- 27.Which director has directed the most movies, and how many have they directed?
SELECT 
    d.first_name, d.last_name, COUNT(m.id)
FROM
    directors d
        JOIN
    movies_directors md ON md.director_id = d.id
        JOIN
    movies m ON m.id = md.movie_id
GROUP BY d.first_name , d.last_name
ORDER BY COUNT(m.id) DESC
LIMIT 1;

-- 2nd method

SELECT 
    d.first_name,
    d.last_name,
    director_movies.movie_count
FROM 
    (SELECT 
        md.director_id,
        COUNT(md.movie_id) AS movie_count
     FROM 
        movies_directors md
     GROUP BY 
        md.director_id
     ORDER BY 
        movie_count DESC
     LIMIT 1) AS director_movies
JOIN 
    directors d ON director_movies.director_id = d.id;

-- 28.Which actors have played the same role in different movies?

SELECT DISTINCT
    a.first_name,
    a.last_name,
    r.role,
    COUNT(DISTINCT r.movie_id) AS movie_count
FROM
    actors a
        JOIN
    roles r ON a.id = r.actor_id
WHERE
    r.role IS NOT NULL AND r.role != ''
GROUP BY r.role , a.id
HAVING COUNT(DISTINCT r.movie_id) > 1
ORDER BY movie_count DESC;


-- 29.Find the number of directors who have worked with the same actor in multiple movies

SELECT 
    COUNT(DISTINCT repeated_pairs.director_id) AS directors_with_repeated_collaborations
FROM
    (SELECT 
        md.director_id,
            r.actor_id,
            COUNT(DISTINCT r.movie_id) AS movie_count
    FROM
        movies_directors md
    JOIN 
    roles r ON r.movie_id = md.movie_id
    GROUP BY 
    md.director_id , r.actor_id
    HAVING 
    COUNT(DISTINCT r.movie_id) > 1) AS repeated_pairs;

    


-- 30.Which 10 actors have the longest career span in terms of years active in movies?

SELECT 
    a.first_name, a.last_name, (max(m.year)-min(m.year)) as career_span
FROM
    actors a
        JOIN
    roles r ON r.actor_id = a.id
        JOIN
    movies m ON m.id = r.movie_id
    group by a.id, a.first_name, a.last_name
    order by career_span desc
    limit 10;
    



-- Analysing genders

-- 31.How many actors are male and how many are female?

SELECT 
    gender, COUNT(*)
FROM
    actors
GROUP BY gender;

-- 32.What percentage of actors are female, and what percentage are male?

SELECT 
    gender,
    COUNT(gender) / (select  count(*) from actors) *100 as percentage
FROM
    actors
GROUP BY gender;

-- 33.How many movies have had an equal number of male and female actors?

SELECT 
    COUNT(*) AS movies_with_equal_cast
FROM (
    SELECT 
        r.movie_id,
        SUM(CASE WHEN a.gender = 'M' THEN 1 ELSE 0 END) AS male_count,
        SUM(CASE WHEN a.gender = 'F' THEN 1 ELSE 0 END) AS female_count
    FROM roles r
    JOIN actors a ON a.id = r.actor_id
    GROUP BY r.movie_id
    HAVING male_count
         = female_count
) AS t;


-- Determine the ratio of male to female actors in movies of each genre.
SELECT 
    mg.genre,
    SUM(CASE WHEN a.gender = 'M' THEN 1 ELSE 0 END) AS male_actors,
    SUM(CASE WHEN a.gender = 'F' THEN 1 ELSE 0 END) AS female_actors,
    CASE 
        WHEN SUM(CASE WHEN a.gender = 'F' THEN 1 ELSE 0 END) = 0 THEN NULL
        ELSE SUM(CASE WHEN a.gender = 'M' THEN 1 ELSE 0 END) / SUM(CASE WHEN a.gender = 'F' THEN 1 ELSE 0 END)
    END AS male_to_female_ratio
FROM 
    roles r
JOIN 
    actors a ON r.actor_id = a.id
JOIN 
    movies_genres mg ON r.movie_id = mg.movie_id
GROUP BY 
    mg.genre;

-- 34.How many movies had a majority of females among their cast?

SELECT 
    COUNT(*) AS movie_with_higher_female
FROM
    (SELECT 
        r.movie_id,
            SUM(CASE
                WHEN a.gender = 'M' THEN 1
                ELSE 0
            END) AS male_count,
            SUM(CASE
                WHEN a.gender = 'F' THEN 1
                ELSE 0
            END) AS female_count
    FROM
        roles r
    JOIN actors a ON a.id = r.actor_id
    GROUP BY r.movie_id) as x
    where male_count < female_count;

-- 35.What percentage of the total movies had a majority female cast?

-- What percentage of the total movies had a majority female cast?
SELECT
    (
        SELECT COUNT(*)
        FROM (
            SELECT 
                r.movie_id,
                COUNT(CASE WHEN a.gender = 'M' THEN 1 END) as male_count,
                COUNT(CASE WHEN a.gender = 'F' THEN 1 END) as female_count
            FROM roles r
            JOIN actors a ON r.actor_id = a.id
            GROUP BY r.movie_id
        ) AS movie_gender_counts
        WHERE female_count > male_count
    )
    /
    (
        SELECT COUNT(DISTINCT movie_id)
        FROM roles
    ) * 100 AS female_majority_movies_percentage;
    
    -- 2nd method
    SELECT
    SUM(CASE WHEN female_count > male_count THEN 1 ELSE 0 END) 
        * 100.0 
        / COUNT(*) AS female_majority_movies_percentage
FROM (
    SELECT 
        r.movie_id,
        SUM(CASE WHEN a.gender = 'M' THEN 1 ELSE 0 END) AS male_count,
        SUM(CASE WHEN a.gender = 'F' THEN 1 ELSE 0 END) AS female_count
    FROM roles r
    JOIN actors a ON r.actor_id = a.id
    GROUP BY r.movie_id
) AS movie_gender_counts;


-- 16.8745%
/*
Note: movies and roles have a different count of movies
Here we've used the number of movies in roles as the denominator
We did this as we got the number of majority female movies from the table roles
You may get a different number herE if you used the number of movies in the movies table as the denominator
*/
SELECT count(DISTINCT id) FROM movies;
SELECT count(DISTINCT movie_id) FROM roles;


-- Movies across time


-- 36.How many of the movies were released after the year 2000?

SELECT 
    count(*)
FROM
    movies
WHERE
    year > 2000;

-- 37.How many of the movies were released between the years 1990 and 2000?

SELECT 
    COUNT(*)
FROM
    movies
WHERE
    year BETWEEN 1990 AND 2000;


-- 38.Which are the 3 years with the most movies? How many movies were produced in those years?

SELECT 
    year, COUNT(distinct id) AS total_movies
FROM
    movies
GROUP BY year
ORDER BY total_movies desc
LIMIT 3;


-- 39.What are the top 5 movie genres?

SELECT 
   genre, COUNT(genre) as total_movies
FROM
    movies_genres
GROUP BY genre
order by total_movies desc
limit 5;

-- 40.What are the top 5 movie genres before 1920?
SELECT 
    mg.genre, COUNT(mg.genre) AS total_movies
FROM
    movies_genres mg join movies m on m.id=mg.movie_id
WHERE
    m.year< 1920
GROUP BY mg.genre
ORDER BY total_movies DESC
LIMIT 5;

-- 41.Which 5 years had the highest average movie ranks, and what are those ranks and years?

SELECT 
   year, AVG(`rank`) as avg_rank
FROM
    movies
    group by year
    order by avg_rank desc
    limit 5;

