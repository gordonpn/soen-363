CREATE OR REPLACE VIEW lowRating AS (
  SELECT
    m.title,
    m.year,
    m.rating
  FROM
    movies AS m,
    (
      SELECT
        m.year,
        min(m.rating) AS lowest_rating
      FROM
        movies AS m
      WHERE
        m.year >= 2005
        AND m.year <= 2011
      GROUP BY
        m.year
      ORDER BY
        m.year ASC) AS temp
    WHERE
      m.rating = temp.lowest_rating
      AND m.year = temp.year);

CREATE OR REPLACE VIEW highRating AS (
  SELECT
    m.title,
    m.year,
    m.rating
  FROM
    movies AS m,
    (
      SELECT
        m.year,
        max(m.rating) AS highest_rating
      FROM
        movies AS m
      WHERE
        m.year >= 2005
        AND m.year <= 2011
      GROUP BY
        m.year
      ORDER BY
        m.year ASC) AS temp
    WHERE
      m.rating = temp.highest_rating
      AND m.year = temp.year);

SELECT
  *
FROM (
  SELECT
    *
  FROM
    highRating
  UNION
  SELECT
    *
  FROM
    lowRating) AS hl
ORDER BY
  hl.year,
  hl.rating,
  hl.title;

