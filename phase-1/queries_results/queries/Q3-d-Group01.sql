SELECT
  m.title,
  m.year,
  m.rating
FROM
  movies AS m
ORDER BY
  m.year ASC,
  m.rating DESC;

