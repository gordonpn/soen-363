How many were female drivers under 21 were severely injured 

SELECT COUNT(*) 
FROM (SELECT v.id 
FROM victims v
WHERE v.victim_role = '1' and v.victim_sex = 'female' and v.victim_degree_of_injury = '5' and v.victim_age < 21) AS female_under_21_severe_injury