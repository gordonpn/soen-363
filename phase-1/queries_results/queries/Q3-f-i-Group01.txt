CREATE OR REPLACE VIEW most_rated AS
SELECT
  *
FROM
  movies m
WHERE
  m.num_ratings = (
    SELECT
      MAX(m.num_ratings)
    FROM
      movies m);

