CREATE OR REPLACE VIEW co_actors AS (
  SELECT
    a1.name,
    count(DISTINCT (a2.name)) AS num_co_actors
  FROM
    actors AS a1,
    actors AS a2
  WHERE
    a1.mid = a2.mid
    AND a2.name != a1.name
  GROUP BY
    a1.name);

SELECT
  *
FROM
  co_actors AS ca
WHERE
  ca.num_co_actors = (
    SELECT
      max(ca.num_co_actors)
    FROM
      co_actors AS ca)
ORDER BY
  ca.name;

