SELECT
  COUNT(*)
FROM (
  SELECT
    *
  FROM
    high_rating
  EXCEPT
  SELECT
    *
  FROM
    low_rating) AS no_flop;

