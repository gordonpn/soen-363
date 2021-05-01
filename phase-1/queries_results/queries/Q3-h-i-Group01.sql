CREATE OR REPLACE VIEW high_rating AS SELECT DISTINCT
  name
FROM
  actors a,
  movies m
WHERE
  a.mid = m.mid
  AND m.rating >= 4;

SELECT
  COUNT(*)
FROM
  high_rating;

CREATE OR REPLACE VIEW low_rating AS SELECT DISTINCT
  name
FROM
  actors a,
  movies m
WHERE
  a.mid = m.mid
  AND m.rating < 4;

SELECT
  COUNT(*)
FROM
  low_rating;

