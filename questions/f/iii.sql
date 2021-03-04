SELECT
  mr.*
FROM
  most_rated mr
  INNER JOIN highest_rated hr ON hr.mid = mr.mid