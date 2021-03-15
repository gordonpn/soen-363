SELECT
  m.title
FROM
  movies m
  JOIN tags t ON t.mid = m.mid
  JOIN tag_names tn ON tn.tid = t.tid
WHERE
  tn.tag LIKE '%good%'
INTERSECT
SELECT
  m.title
FROM
  movies m
  JOIN tags t ON t.mid = m.mid
  JOIN tag_names tn ON tn.tid = t.tid
WHERE
  tn.tag LIKE '%bad%';

