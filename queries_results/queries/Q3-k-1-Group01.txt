SELECT
  a1.name,
  count(DISTINCT (a2.name))
FROM
  actors AS a1,
  actors AS a2
WHERE
  a1.mid = a2.mid
  AND a1.name = 'Tom Cruise'
  AND a2.name != 'Tom Cruise'
GROUP BY
  a1.name;

