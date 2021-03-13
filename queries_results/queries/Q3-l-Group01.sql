-- CREATE OR REPLACE FUNCTION GET_AGE_GAP(WANTED_YEAR int) RETURNS real LANGUAGE PLPGSQL AS $$
-- declare
--    movie_year real;
--    min_year real;
-- begin

--   select min(year)
--    into min_year
--    from movies
--    limit 1;
--    select year
--    into movie_year
--    from movies
--    where title = 'Mr. & Mrs. Smith';

--    return (1 - (ABS(wanted_year - movie_year)/ABS(min_year - movie_year)));
-- end;
-- $$;
-- CREATE OR REPLACE VIEW AGE_GAP AS
-- SELECT GET_AGE_GAP(M.YEAR) AS GAP,
-- 	TITLE, MID
-- FROM movies AS M;

-- SELECT GAP,
-- 	TITLE,
-- 	MID
-- FROM AGE_GAP;

-- CREATE OR REPLACE FUNCTION GET_RATING_GAP(WANTED_RATING real) RETURNS real LANGUAGE PLPGSQL AS $$
-- declare
--    movie_rating real;
--    min_rating real;
-- begin

--   select MIN(rating)
--    into min_rating
--    from movies
--    limit 1;
--    select rating
--    into movie_rating
--    from movies
--    where title = 'Mr. & Mrs. Smith';

--    return (1 - (ABS(wanted_rating - movie_rating)/ABS(min_rating - movie_rating)));
-- end;
-- $$;


-- CREATE OR REPLACE VIEW RATING_GAP AS
-- SELECT GET_RATING_GAP(M.RATING) AS GAP,
-- 	TITLE,
-- 	MID
-- FROM movies AS M;


-- SELECT GAP,
-- 	TITLE,
-- 	MID
-- FROM RATING_GAP
-- ORDER BY GAP;

-- FRACTION OF COMMON ACTORS


CREATE OR REPLACE VIEW SMITH_ACTORS_COUNT AS
SELECT COUNT(distinct A.NAME)
FROM ACTORS AS A
JOIN MOVIES AS M ON M.MID = A.MID
AND M.TITLE = 'Mr. & Mrs. Smith';

CREATE OR REPLACE VIEW SMITH_ACTORS AS
SELECT M1.MID,
	COUNT(*) AS NUM_COMMON_ACTORS
FROM ACTORS AS A1,
	ACTORS AS A2,
	MOVIES AS M1,
	MOVIES AS M2
WHERE A1.MID = M1.MID
				AND A2.MID = M2.MID
				AND M2.MID =
								(SELECT M.MID
									FROM MOVIES AS M
									WHERE M.TITLE = 'Mr. & Mrs. Smith'
									LIMIT 1)
				AND A2.NAME = A1.NAME
GROUP BY M1.MID
ORDER BY M1.MID;


CREATE OR REPLACE FUNCTION GET_COMMON_ACTOR_FRACTION(WANTED_MID int) RETURNS real LANGUAGE PLPGSQL AS $$
declare
   count_smith_actors real;
   common_actor_count real;
begin

	select num_common_actors into common_actor_count from SMITH_ACTORS where mid = WANTED_MID;

	if NOT found THEN
	return 0;
	END IF;
	
    select count into count_smith_actors from SMITH_ACTORS_COUNT;

   return (common_actor_count / count_smith_actors);
end;
$$;

CREATE OR REPLACE VIEW COMMON_ACTOR_FRACTION AS
SELECT GET_COMMON_ACTOR_FRACTION(M.MID) AS FRACTION,
	TITLE,
	MID
FROM movies AS M;

SELECT fraction, title, mid
FROM COMMON_ACTOR_FRACTION
ORDER BY FRACTION;

-- FRACTION OF COMMON GENRES

CREATE OR REPLACE VIEW SMITH_GENRES AS
SELECT DISTINCT G.GENRE
FROM GENRES AS G
JOIN MOVIES AS M ON M.MID = G.MID
AND M.TITLE = 'Mr. & Mrs. Smith';


CREATE OR REPLACE VIEW SMITH_GENRES_COUNT AS
SELECT COUNT(DISTINCT G.GENRE)
FROM GENRES AS G
JOIN MOVIES AS M ON M.MID = G.MID
AND M.TITLE = 'Mr. & Mrs. Smith';


CREATE OR REPLACE FUNCTION GET_COMMON_GENRE_FRACTION(WANTED_MID int) RETURNS real LANGUAGE PLPGSQL AS $$
declare
   count_smith_genres real;
   common_genre_count real;
begin
SELECT COUNT(DISTINCT genre) into common_genre_count
FROM
				(SELECT G.GENRE
FROM GENRES AS G
JOIN MOVIES AS M ON M.MID = G.MID
AND M.MID = WANTED_MID INTERSECT
									SELECT GENRE FROM SMITH_GENRES)AS COMMON;

    select count into count_smith_genres from SMITH_GENRES_COUNT;

   return (common_genre_count / count_smith_genres);
end;
$$;


CREATE OR REPLACE VIEW COMMON_GENRE_FRACTION AS
SELECT GET_COMMON_GENRE_FRACTION(M.MID) AS FRACTION,
	TITLE,
	MID
FROM MOVIES AS M;


SELECT FRACTION,
	TITLE,
	MID
FROM COMMON_GENRE_FRACTION
ORDER BY FRACTION;

-- FRACTION OF COMMON TAGS

CREATE OR REPLACE VIEW SMITH_TAGS AS
SELECT DISTINCT TAG
FROM TAG_NAMES
JOIN MOVIES ON MOVIES.TITLE = 'Mr. & Mrs. Smith'
JOIN TAGS ON TAGS.MID = MOVIES.MID
AND TAGS.TID = TAG_NAMES.TID;

CREATE OR REPLACE VIEW SMITH_TAGS_COUNT AS
SELECT COUNT(DISTINCT TAG)
FROM TAG_NAMES
JOIN MOVIES ON MOVIES.TITLE = 'Mr. & Mrs. Smith'
JOIN TAGS ON TAGS.MID = MOVIES.MID
AND TAGS.TID = TAG_NAMES.TID;




