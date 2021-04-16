-- Most common degree of injury when the party at fault causes a collision from a left turn
SELECT
  victim_degree_of_injury,
  COUNT(*)
FROM
  victims
  JOIN parties ON parties.case_id = victims.case_id
WHERE
  party_age IS NOT NULL
  AND at_fault = 1
  AND movement_preceding_collision = 'making left turn'
GROUP BY
  victim_degree_of_injury
ORDER BY
  COUNT DESC;

