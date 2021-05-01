SELECT
  g.genre,
  count(*) AS N
FROM
  movies AS m,
  genres AS g
WHERE
  m.mid = g.mid
GROUP BY
  g.genre
HAVING
  count(*) > 1000
ORDER BY
  N;

