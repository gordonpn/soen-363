SELECT
  m.title
FROM
  movies AS m,
  actors AS a
WHERE
  m.mid = a.mid
  AND a.name = 'Daniel Craig'
ORDER BY
  title;

