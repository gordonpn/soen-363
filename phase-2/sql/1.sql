-- Victim id of all males under 25 that have been killed in an accident that are of black decent 
SELECT
    v.id
FROM
    victims v,
    parties p
WHERE
    v.victim_sex = 'male'
    and v.victim_age < 25
    and v.victim_degree_of_injury = 'killed'
    and v.case_id = p.case_id
    and p.party_race = 'black'
    and v.party_number = p.party_number