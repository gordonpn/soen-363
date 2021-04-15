How many were uninjured in the passenger seat after being fully ejected 

SELECT COUNT(*) 
FROM (SELECT v.id 
FROM victims v
WHERE v.victim_role = '2' and v.victim_degree_of_injury = 'no injury' and v.victim_ejected = '1') AS passenger_ejected_not_injured