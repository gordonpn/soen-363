CREATE OR REPLACE VIEW an_movies AS
SELECT
  mid
FROM
  actors a
WHERE
  a.name = 'Annette Nicole';

CREATE OR REPLACE VIEW all_combinations AS
SELECT
  *
FROM
  an_movies,
  co_actors;

SELECT
  COUNT(*)
FROM
  all_combinations;

