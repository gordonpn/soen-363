-- Road conditions that causes the most accidents


select road_surface, road_condition_1, road_condition_2 ,lighting, count(*)  from collisions 
group by road_surface, road_condition_1, road_condition_2 ,lighting
order by count desc 

