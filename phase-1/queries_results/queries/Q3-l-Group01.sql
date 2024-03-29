CREATE OR REPLACE FUNCTION GET_AGE_GAP (WANTED_YEAR int)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
DECLARE
  movie_year real;
  min_year real;
BEGIN
  SELECT
    min(year) INTO min_year
  FROM
    movies
  LIMIT 1;
  SELECT
    year INTO movie_year
  FROM
    movies
  WHERE
    title = 'Mr. & Mrs. Smith';
  RETURN (1 - (ABS(wanted_year - movie_year) / ABS(min_year - movie_year)));
END;
$$;

CREATE OR REPLACE VIEW AGE_GAP AS
SELECT
  GET_AGE_GAP (M.YEAR) AS GAP,
  TITLE,
  MID
FROM
  movies AS M;

SELECT
  GAP,
  TITLE,
  MID
FROM
  AGE_GAP;

-- RATING GAP
CREATE OR REPLACE FUNCTION GET_RATING_GAP (WANTED_RATING real)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
DECLARE
  movie_rating real;
  min_rating real;
BEGIN
  IF WANTED_RATING IS NULL THEN
    RETURN 0;
  END IF;
  SELECT
    MIN(rating) INTO min_rating
  FROM
    movies
  LIMIT 1;
  SELECT
    rating INTO movie_rating
  FROM
    movies
  WHERE
    title = 'Mr. & Mrs. Smith';
  RETURN (1 - (ABS(wanted_rating - movie_rating) / ABS(min_rating - movie_rating)));
END;
$$;

CREATE OR REPLACE VIEW RATING_GAP AS
SELECT
  GET_RATING_GAP (M.RATING) AS GAP,
  TITLE,
  MID
FROM
  movies AS M;

SELECT
  GAP,
  TITLE,
  MID
FROM
  RATING_GAP
ORDER BY
  GAP;

-- FRACTION OF COMMON ACTORS
CREATE OR REPLACE VIEW SMITH_ACTORS_COUNT AS
SELECT
  COUNT(DISTINCT A.NAME)
FROM
  ACTORS AS A
  JOIN MOVIES AS M ON M.MID = A.MID
    AND M.TITLE = 'Mr. & Mrs. Smith';

CREATE OR REPLACE VIEW SMITH_ACTORS AS
SELECT
  M1.MID,
  COUNT(*) AS NUM_COMMON_ACTORS
FROM
  ACTORS AS A1,
  ACTORS AS A2,
  MOVIES AS M1,
  MOVIES AS M2
WHERE
  A1.MID = M1.MID
  AND A2.MID = M2.MID
  AND M2.MID = (
    SELECT
      M.MID
    FROM
      MOVIES AS M
    WHERE
      M.TITLE = 'Mr. & Mrs. Smith'
    LIMIT 1)
AND A2.NAME = A1.NAME
GROUP BY
  M1.MID
ORDER BY
  M1.MID;

CREATE OR REPLACE FUNCTION GET_COMMON_ACTOR_FRACTION (WANTED_MID int)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
DECLARE
  count_smith_actors real;
  common_actor_count real;
BEGIN
  SELECT
    num_common_actors INTO common_actor_count
  FROM
    SMITH_ACTORS
  WHERE
    mid = WANTED_MID;
  IF NOT found THEN
    RETURN 0;
  END IF;
  SELECT
    count INTO count_smith_actors
  FROM
    SMITH_ACTORS_COUNT;
  RETURN (common_actor_count / count_smith_actors);
END;
$$;

CREATE OR REPLACE VIEW COMMON_ACTOR_FRACTION AS
SELECT
  GET_COMMON_ACTOR_FRACTION (M.MID) AS FRACTION,
  TITLE,
  MID
FROM
  movies AS M;

SELECT
  fraction,
  title,
  mid
FROM
  COMMON_ACTOR_FRACTION
ORDER BY
  FRACTION;

-- FRACTION OF COMMON GENRES
CREATE OR REPLACE VIEW SMITH_GENRES AS SELECT DISTINCT
  G.GENRE
FROM
  GENRES AS G
  JOIN MOVIES AS M ON M.MID = G.MID
    AND M.TITLE = 'Mr. & Mrs. Smith';

CREATE OR REPLACE VIEW SMITH_GENRES_COUNT AS
SELECT
  COUNT(DISTINCT G.GENRE)
FROM
  GENRES AS G
  JOIN MOVIES AS M ON M.MID = G.MID
    AND M.TITLE = 'Mr. & Mrs. Smith';

CREATE OR REPLACE FUNCTION GET_COMMON_GENRE_FRACTION (WANTED_MID int)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
DECLARE
  count_smith_genres real;
  common_genre_count real;
BEGIN
  SELECT
    COUNT(DISTINCT genre) INTO common_genre_count
  FROM (
    SELECT
      G.GENRE
    FROM
      GENRES AS G
      JOIN MOVIES AS M ON M.MID = G.MID
        AND M.MID = WANTED_MID
      INTERSECT
      SELECT
        GENRE
      FROM
        SMITH_GENRES) AS COMMON;
  SELECT
    count INTO count_smith_genres
  FROM
    SMITH_GENRES_COUNT;
  RETURN (common_genre_count / count_smith_genres);
END;
$$;

CREATE OR REPLACE VIEW COMMON_GENRE_FRACTION AS
SELECT
  GET_COMMON_GENRE_FRACTION (M.MID) AS FRACTION,
  TITLE,
  MID
FROM
  MOVIES AS M;

SELECT
  FRACTION,
  TITLE,
  MID
FROM
  COMMON_GENRE_FRACTION
ORDER BY
  FRACTION;

-- FRACTION OF COMMON TAGS
CREATE OR REPLACE VIEW SMITH_TAGS AS SELECT DISTINCT
  TAG
FROM
  TAG_NAMES
  JOIN MOVIES ON MOVIES.TITLE = 'Mr. & Mrs. Smith'
  JOIN TAGS ON TAGS.MID = MOVIES.MID
    AND TAGS.TID = TAG_NAMES.TID;

CREATE OR REPLACE VIEW SMITH_TAGS_COUNT AS
SELECT
  COUNT(DISTINCT TAG)
FROM
  TAG_NAMES
  JOIN MOVIES ON MOVIES.TITLE = 'Mr. & Mrs. Smith'
  JOIN TAGS ON TAGS.MID = MOVIES.MID
    AND TAGS.TID = TAG_NAMES.TID;

CREATE OR REPLACE FUNCTION GET_COMMON_TAG_FRACTION (WANTED_MID int)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
DECLARE
  count_smith_tags real;
  common_tag_count real;
BEGIN
  SELECT
    COUNT(DISTINCT tag) INTO common_tag_count
  FROM ( SELECT DISTINCT
      TAG
    FROM
      TAG_NAMES
      JOIN MOVIES ON MOVIES.MID = WANTED_MID
      JOIN TAGS ON TAGS.MID = MOVIES.MID
        AND TAGS.TID = TAG_NAMES.TID
      INTERSECT
      SELECT
        TAG
      FROM
        SMITH_TAGS) AS COMMON;
  SELECT
    count INTO count_smith_tags
  FROM
    SMITH_TAGS_COUNT;
  RETURN (common_tag_count / count_smith_tags);
END;
$$;

CREATE OR REPLACE VIEW COMMON_TAG_FRACTION AS
SELECT
  GET_COMMON_TAG_FRACTION (M.MID) AS FRACTION,
  TITLE,
  MID
FROM
  MOVIES AS M;

SELECT
  FRACTION,
  TITLE,
  MID
FROM
  COMMON_TAG_FRACTION
ORDER BY
  FRACTION;

-- Final view
CREATE OR REPLACE FUNCTION RECOMMENDATION (fraction_actors real, fraction_tags real, fraction_genres real, age_gap real, rating_gap real)
  RETURNS real
  LANGUAGE PLPGSQL
  AS $$
BEGIN
  RETURN ((fraction_actors + fraction_tags + fraction_genres + age_gap + rating_gap) / 5) * 100;
END;
$$;

CREATE OR REPLACE VIEW JOINED_FRACTIONS AS
SELECT
  CGF.MID,
  m.TITLE,
  m.RATING,
  RECOMMENDATION (CAF.FRACTION, CTF.FRACTION, CGF.FRACTION, AG.GAP, RG.GAP) AS SIMILARITY
FROM
  COMMON_GENRE_FRACTION CGF
  JOIN COMMON_ACTOR_FRACTION CAF ON CAF.MID = CGF.MID
  JOIN AGE_GAP AG ON AG.MID = CGF.MID
  JOIN RATING_GAP RG ON RG.MID = CGF.MID
  JOIN COMMON_TAG_FRACTION CTF ON CTF.MID = CGF.MID
  JOIN MOVIES m ON m.MID = CGF.MID
WHERE
  m.TITLE <> 'Mr. & Mrs. Smith'
ORDER BY
  SIMILARITY DESC nulls LAST
LIMIT 10;

SELECT
  mid,
  title,
  rating,
  similarity
FROM
  JOINED_FRACTIONS;

