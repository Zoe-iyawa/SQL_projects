# Client Profile
- Name: Amanda
- Age: 15
- Gender: Female
- Location: USA
- Occupation: Student
- Movie and TV show Preferences:
  - Genres: Thriller
  - Favourite Director: None
  - Preferences for highly rated and recently released,
- Preferences (TV Show Only):
  - Shows with short durations.

Based on this profile, we are now able to suggest movies that align with our clients preferences.

## Question and Solution
N.B Convert Date to sql format.

```sql
UPDATE netflix_movies
SET Date_Added = STR_TO_DATE(Date_Added, '%M %e, %Y')
```

-The date added column was first converted from VARCHAR to DATE format

1. Retrieve the top rated shows with imdb_score above 8

```sql
USE netflix;
SELECT *
FROM netflix_movies;

SELECT Title, imdb_score_new
FROM netflix_movies
WHERE imdb_score_new >= 8
ORDER BY 2 DESC;
```
- The query above suggests similar films which have a high rating (above 8 rating) ordered by the rating column(imdb_score_new).
  
2. Trending shows released within the last two years

```sql
SELECT Title, imdb_score_new, Release_Date
FROM netflix_movies
WHERE imdb_score_new >= 8 AND Release_Date BETWEEN 2020 AND 2021
ORDER BY 3;
```
- The query above suggests recently released films based on our clients request.

3. Identify the shortest show in terms of duration ? 
```sql
With Duration_table AS (SELECT Title, Duration,
CASE 
WHEN Duration LIKE '1%son' THEN 1 * (7 * 30)
WHEN Duration LIKE '2%s' THEN 2 * (7 * 30)
WHEN Duration LIKE '3%s' THEN 3 * (7 * 30)
WHEN Duration LIKE '4%s' THEN 4 * (7 * 30)
WHEN Duration LIKE '5%s' THEN 5 * (7 * 30)
WHEN Duration LIKE '6%s' THEN 6 * (7 * 30)
WHEN Duration LIKE '7%s' THEN 7 * (7 * 30)
WHEN Duration LIKE '8%s' THEN 8 * (7 * 30)
WHEN Duration LIKE '9%s' THEN 9 * (7 * 30) 
WHEN Duration LIKE '10%s' THEN 10 * (7 * 30) ELSE NULL 
END AS duration_new
FROM netflix_movies
)


SELECT Title, Duration_new AS Shortest_movie
FROM Duration_table
WHERE Duration_new = (SELECT MIN(Duration_new) FROM Duration_table) AND Duration_new IS NOT NULL;

```
- For this query we are interested in only TV shows and not movies based on our clients request.
- The Subquery is based on the suggestion that each episode per season lasts for 30 minutes.
We are trying to identify which TV show has the shortest duration:

|Title                                     | Shortest_movie|
|------------------------------------------|---------------|
|The Underclassmen                         | 210           |
|They've Gotta Have Us                     | 210           |
|Garth Brooks: The Road I'm On             | 210           |
|The American Bible Challenge              |210            |
|The Cat in the Hat Knows a Lot About That!|210            |


4.  List Directors along with the count of shows they directed
```sql
SELECT Director, COUNT(Title) AS num_of_shows
FROM netflix_movies
WHERE Content_Type = 'TV Show'
GROUP BY Director
ORDER BY 2 DESC;

 List Directors along with the count of movie they directed;
SELECT Director, COUNT(Title) AS num_of_movies
FROM netflix_movies
WHERE Content_Type = 'Movie'
GROUP BY Director
ORDER BY 2 DESC;

```
- The first part is filtered by TV Shows only
- The second part is filtered by Movies.

5. Average duration of shows released each year
```sql
With netflix_table AS (SELECT Title, Release_Date, Duration,
CASE 
WHEN Duration LIKE '1%son' THEN 1 * (7 * 30)
WHEN Duration LIKE '2%s' THEN 2 * (7 * 30)
WHEN Duration LIKE '3%s' THEN 3 * (7 * 30)
WHEN Duration LIKE '4%s' THEN 4 * (7 * 30)
WHEN Duration LIKE '5%s' THEN 5 * (7 * 30)
WHEN Duration LIKE '6%s' THEN 6 * (7 * 30)
WHEN Duration LIKE '7%s' THEN 7 * (7 * 30)
WHEN Duration LIKE '8%s' THEN 8 * (7 * 30)
WHEN Duration LIKE '9%s' THEN 9 * (7 * 30) 
WHEN Duration LIKE '10%s' THEN 10 * (7 * 30) ELSE NULL 
END AS duration_new
FROM netflix_movies)
 

SELECT Release_Date, CEIL(AVG(Duration_new)) AS Avg_show_duration
FROM netflix_table
WHERE Duration_new IS NOT NULL
GROUP BY 1
ORDER BY 2;
```
- For this query we are only interested in TV Shows


6. Shows similar to a particular film based on genre and rating

```sql
SELECT Genres, Title, Rating
FROM netflix_movies
WHERE Genres LIKE '%Thrillers%' AND Rating = 'PG-13';
```
- The query suggests movie or TV Show content with a thriller genre included based on our clients request. 
- We have specified the rating to be PG-13 based on our client's age

|Genres                                       |Title                |Rating|
|---------------------------------------------|---------------------|------|
|Horror Movies, Thrillers                     | The Ring	          |PG-13 |
|Horror Movies, Thrillers                     |The Stepfather       |PG-13|
|Dramas, Thrillers	                          |Operation Finale     |PG-13|
|Thrillers	                                  |The Interpreter	    |PG-13 |
|Horror Movies, Thrillers                     |Before I Wake	      |PG-13 |
|Horror Movies, Thrillers                     |	Insidious	          |PG-13 |
|Horror Movies, Thrillers                     |The Darkness	        |PG-13 |
|Dramas, Thrillers	                          |The Keeping Hours    |PG-13 |
|Horror Movies, Thrillers                     | Incarnate	          |PG-13 |
|Dramas, Thrillers	                          |The Pelican Brief    |PG-13 |
|Thrillers	                                  |The Fourth Kind	    |PG-13 |
|Horror Movies, Thrillers.                    |The Possession	      |PG-13 |
|Action & Adventure, Thrillers	              |Congo	              |PG-13 |  
|Sci-Fi & Fantasy, Thrillers	                |Selfless	            |PG-13 |
|Dramas, Thrillers	                          |Strange but True	    |PG-13 |
|Horror Movies, International Movies,Thrillers|Under the Shadow	    |PG-13 |
|Thrillers	                                  |Domestic Disturbance	|PG-13 |
|Thrillers	                                  |Angels & Demons	    |PG-13 |
|Horror Movies, Thrillers	                    |The Silence	        |PG-13 |
|Thrillers	                                  |The Da Vinci Code	  |PG-13 |
|Dramas, International Movies, Thrillers	    |The Command	        |PG-13 |
|Dramas, Thrillers	                          |State of Play	      |PG-13 |
|Action & Adventure, Thrillers	              |Unknown	            |PG-13 |
|Dramas, Thrillers	                          |Septembers of Shiraz	|PG-13 |
|Dramas, Romantic Movies, Thrillers           |Rebecca	            |PG-13 |
|Dramas, Thrillers	                          |The Next Three Days	|PG-13 |
|Horror Movies, Sci-Fi & Fantasy, Thrillers	  |Sweetheart	          |PG-13 |



## Data Analysis

7. Calculate the percentage increase in the number of shows added each year

```sql
With shows_table AS (SELECT YEAR(Date_added) AS movie_count_per_year, COUNT(Title) AS num_of_shows
FROM netflix_movies
GROUP BY 1
ORDER BY 1)

SELECT *, LAG(num_of_shows) OVER(ORDER BY num_of_shows) AS previous_year, ROUND(100*(
num_of_shows - LAG(num_of_shows) OVER(ORDER BY num_of_shows))/ num_of_shows, 1) AS percentage_increase
FROM shows_table;
```
- 2014 and 2016 had the highest increase with 75% and 78.4% respectively

8. Calulate the number of shows and movie added each month

```sql
SELECT MONTH(Date_Added) AS MONTH, COUNT(Show_id)
FROM netflix_movies
GROUP BY 1
ORDER BY 1;
```
- Using sql, we have been able to identify what month had the highest number of movies. 




  
  
