-- Road conditions that causes the most accidents
SELECT
    road_surface,
    road_condition_1,
    road_condition_2,
    lighting,
    count(*)
FROM
    collisions
GROUP BY
    road_surface,
    road_condition_1,
    road_condition_2,
    lighting
ORDER BY
    count DESC