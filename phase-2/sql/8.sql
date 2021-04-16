-- How many people by race, were killed by a hit and run?

SELECT
	count(*) AS KILLED_BY_HIT_AND_RUN, p.party_race 
FROM
	victims v
JOIN collisions c ON
	c.case_id = v.case_id
JOIN parties p ON
	p.party_number = v.party_number AND p.case_id = v.case_id 
WHERE
	v.victim_degree_of_injury = 'killed'
	AND c.hit_and_run IN ('misdemeanor', 'felony')
	AND p.party_race IS NOT NULL
GROUP BY
	p.party_race