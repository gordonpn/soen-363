CREATE OR REPLACE VIEW highest_rated AS
SELECT
  *
FROM
  movies m
WHERE
  m.rating = (
    SELECT
      MAX(m.rating)
    FROM
      movies m)
ORDER BY
  m.mid ASC;

