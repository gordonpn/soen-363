CREATE OR REPLACE VIEW no_flop AS
SELECT
  *
FROM
  high_rating
EXCEPT
SELECT
  *
FROM
  low_rating;

SELECT
  nf.name,
  COUNT(m.mid) AS n
FROM
  no_flop nf,
  actors a,
  movies m
WHERE
  nf.name = a.name
  AND a.mid = m.mid
GROUP BY
  nf.name
ORDER BY
  n DESC,
  nf.name
LIMIT 10;

