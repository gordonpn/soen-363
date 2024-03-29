-- Find duplicates on each table
SELECT
  NAME,
  MID,
  COUNT(*)
FROM
  ACTORS
GROUP BY
  NAME,
  MID
HAVING
  COUNT(*) > 1;

SELECT
  GENRE,
  MID,
  COUNT(*)
FROM
  GENRES
GROUP BY
  GENRE,
  MID
HAVING
  COUNT(*) > 1;

SELECT
  TITLE,
  YEAR,
  COUNT(*)
FROM
  MOVIES
GROUP BY
  TITLE,
  YEAR
HAVING
  COUNT(*) > 1;

SELECT
  TAG,
  COUNT(*)
FROM
  TAG_NAMES
GROUP BY
  TAG
HAVING
  COUNT(*) > 1;

SELECT
  MID,
  TID,
  COUNT(*)
FROM
  TAGS
GROUP BY
  MID,
  TID
HAVING
  COUNT(*) > 1;

-- Only Movies table contains duplicates
-- Create a view of Movies table without duplicates
CREATE OR REPLACE VIEW movies_no_dupes AS (
  SELECT DISTINCT ON (title, year)
    title,
    year,
    mid,
    rating,
    num_ratings
  FROM
    movies);

SELECT
  *
FROM
  movies_no_dupes;

