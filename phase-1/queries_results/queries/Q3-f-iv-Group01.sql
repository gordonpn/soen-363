CREATE OR REPLACE VIEW lowest_rated AS
SELECT
  *
FROM
  movies m
WHERE
  m.num_ratings = (
    SELECT
      MIN(m.rating)
    FROM
      movies m)
ORDER BY
  m.mid ASC;

