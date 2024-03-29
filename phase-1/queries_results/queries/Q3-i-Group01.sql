CREATE OR REPLACE VIEW career_lengths AS (
  SELECT
    name,
    (max(year) - min(year)) AS longevity
  FROM
    actors
    JOIN movies ON actors.mid = movies.mid
  GROUP BY
    name
  ORDER BY
    longevity DESC);

SELECT
  name,
  longevity
FROM
  career_lengths
WHERE
  longevity >= ALL (
    SELECT
      longevity
    FROM
      career_lengths)
ORDER BY
  name;

