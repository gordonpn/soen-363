SELECT
  *
FROM
  co_actors
WHERE
  name <> 'Annette Nicole'
EXCEPT ( SELECT DISTINCT
    name
  FROM
    non_existent);

