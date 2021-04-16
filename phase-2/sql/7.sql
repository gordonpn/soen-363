-- What were the pedestrian not at fault doing before getting hit, and what was the lighting and road surface condition
SELECT
  movement_preceding_collision,
  road_surface,
  lighting,
  COUNT(*)
FROM
  parties
  JOIN collisions ON collisions.case_id = parties.case_id
WHERE
  at_fault = 0
  AND party_type = 'pedestrian'
  AND movement_preceding_collision IS NOT NULL
GROUP BY
  movement_preceding_collision,
  road_surface,
  lighting
ORDER BY
  COUNT DESC;

