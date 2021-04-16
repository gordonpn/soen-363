-- What is the day of the year that had the record amount of deaths by collision in 2019?

SELECT
	count(*) AS fatal_collisons,
	c.collision_date
FROM
	collisions c
WHERE
	c.killed_victims > 0 AND c.collision_date BETWEEN '2018-12-31' AND '2020-01-01'
GROUP BY
	c.collision_date
ORDER BY
	fatal_collisons DESC
LIMIT 1