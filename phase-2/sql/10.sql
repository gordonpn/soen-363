Top 10 victim ages that had the most accidents in desc order

SELECT victim_age, COUNT(*) total
FROM victims
WHERE victim_age IS NOT null
GROUP BY victim_age
ORDER BY total DESC
LIMIT 10
