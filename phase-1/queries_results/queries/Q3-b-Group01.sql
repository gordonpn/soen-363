SELECT
  a.name
FROM
  movies AS m,
  actors AS a
WHERE
  m.mid = a.mid
  AND m.title = 'The Dark Knight'
ORDER BY
  a.name;

