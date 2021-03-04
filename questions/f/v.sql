SELECT
  mr.*
FROM
  most_rated mr
  INNER JOIN lowest_rated lr ON lr.mid = mr.mid