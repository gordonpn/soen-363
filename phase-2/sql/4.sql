-- Car brands that have the most fatal accidents
CREATE
OR REPLACE VIEW fatal_collisions AS
SELECT
    CASE
        WHEN vehicle_make LIKE 'TOY%' THEN 'TOYOTA'
        WHEN vehicle_make LIKE 'HON%' THEN 'HONDA'
        WHEN vehicle_make LIKE 'FOR%' THEN 'FORD'
        WHEN vehicle_make LIKE 'CHEV%' THEN 'CHEVROLET'
        WHEN vehicle_make LIKE 'NISS%' THEN 'NISSAN'
        WHEN vehicle_make LIKE 'HAR%'
        OR vehicle_make IN ('HD', 'H.D.') THEN 'HARLEY-DAVIDSON'
        WHEN vehicle_make LIKE 'BMW' THEN 'BMW'
        WHEN vehicle_make LIKE 'YAM%' THEN 'YAMAHA'
        WHEN vehicle_make LIKE 'GMC' THEN 'GMC'
        WHEN vehicle_make LIKE 'KIA' THEN 'KIA'
        WHEN vehicle_make LIKE 'DOD%' THEN 'DODGE'
        WHEN vehicle_make LIKE 'JEEP' THEN 'JEEP'
        WHEN vehicle_make LIKE 'SUZ%' THEN 'SUZUKI'
        WHEN vehicle_make LIKE 'HYU%' THEN 'HYUNDAI'
        WHEN vehicle_make LIKE 'MAZ%' THEN 'MAZDA'
        WHEN vehicle_make LIKE 'INF%' THEN 'INFINITY'
        WHEN vehicle_make LIKE 'KAW%' THEN 'KAWASAKI'
        WHEN vehicle_make LIKE 'MER%' THEN 'MERCEDES-BENZ'
        WHEN vehicle_make LIKE 'VOLK%'
        OR vehicle_make = 'VW' THEN 'VOLKSWAGEN'
        WHEN vehicle_make LIKE 'LEX%' THEN 'LEXUS'
        WHEN vehicle_make LIKE 'MIT%' THEN 'MITSUBISHI'
        WHEN vehicle_make LIKE 'SUB%' THEN 'SUBARU'
        WHEN vehicle_make LIKE 'ACU%' THEN 'ACURA'
        WHEN vehicle_make LIKE 'POR%' THEN 'PORSCHE'
        WHEN vehicle_make LIKE 'TES%' THEN 'TESLA'
        WHEN vehicle_make LIKE 'CHR%' THEN 'CHRYSLER'
        WHEN vehicle_make LIKE 'PON%' THEN 'PONTIAC'
        WHEN vehicle_make LIKE 'SAT%' THEN 'SATURN'
        WHEN vehicle_make LIKE 'CAD%' THEN 'CADILAC'
        WHEN vehicle_make LIKE 'VOLV%' THEN 'VOLVO'
        WHEN vehicle_make LIKE 'BUI%' THEN 'BUICK'
        WHEN vehicle_make LIKE 'LINC%' THEN 'LINCOLN'
        WHEN vehicle_make LIKE 'MIN%' THEN 'MINI'
        WHEN vehicle_make LIKE 'AUD%' THEN 'AUDI'
        WHEN vehicle_make LIKE 'SCI%' THEN 'SCION'
    END AS brand,
    count(victim_degree_of_injury)
FROM
    victims AS v,
    parties AS p
WHERE
    v.case_id = p.case_id
    AND v.party_number = p.party_number
    AND v.victim_degree_of_injury = 'killed'
    AND p.vehicle_make IS NOT NULL
GROUP BY
    vehicle_make;

SELECT
    brand,
    sum(count) AS count
FROM
    fatal_collisions
WHERE
    brand IS NOT NULL
GROUP BY
    brand
ORDER BY
    count DESC