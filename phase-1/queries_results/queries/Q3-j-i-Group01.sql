CREATE OR REPLACE VIEW co_actors AS SELECT DISTINCT
  name
FROM (
  SELECT
    m.mid
  FROM
    movies m,
    actors a
  WHERE
    a.name = 'Annette Nicole'
    AND a.mid = m.mid) AS an_movies,
  actors a2
WHERE
  a2.mid = an_movies.mid;

SELECT
  COUNT(*)
FROM
  co_actors;

