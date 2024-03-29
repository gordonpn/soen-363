CREATE OR REPLACE VIEW non_existent AS
SELECT
  *
FROM
  all_combinations
EXCEPT (
  SELECT
    mid,
    name
  FROM
    actors);

SELECT
  COUNT(*)
FROM
  non_existent;

