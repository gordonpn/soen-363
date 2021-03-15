CREATE MATERIALIZED VIEW co_actors AS (
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

-- For Q3 K 2, 49 secs 807 msec before materialized views
-- After materialized views, the query run time is 24 secs 411 msec
