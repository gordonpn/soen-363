Indexing number OF ratings IN the movies TABLE does reduce the query time,
but NOT BY
  much. Queries
  USING LIKE would NOT benefit
FROM
  indexing such AS query Q3 E. Running the Q3 A query
    RETURNS IN 63 ms INSTEAD OF 146 ms WITH the created index. Running the Q3 B query
      RETURNS IN 85 ms INSTEAD OF 164 ms WITH the created index. Running the Q3 G query
        RETURNS IN 76 ms INSTEAD OF 114 ms WITH the created index. Running the Q3 H - iii query
          RETURNS IN 55 ms INSTEAD OF 377 ms WITH the created index. Running the Q3 I query
            RETURNS IN 826 ms ms INSTEAD OF 997 ms WITH the created index. Running the Q3 J query
              RETURNS IN 85 ms INSTEAD OF 164 ms WITH the created index. Running the Q3 J - i query
                RETURNS IN 82 ms INSTEAD OF 103 ms WITH the created index. Running the Q3 J - ii query
                  RETURNS IN 30 ms INSTEAD OF 59 ms WITH the created index. Running the Q3 J - iii query
                    RETURNS IN 72 ms INSTEAD OF 115 ms WITH the created index. Running the Q3 J - iv query
                      RETURNS IN 88 ms INSTEAD OF 117 ms WITH the created index. Running the Q3 K - i query
                        RETURNS IN 52 ms INSTEAD OF 195 ms WITH the created index. Running the Q3 K - ii query
                          RETURNS IN 27 sec 195 ms INSTEAD OF 54 sec AND 368 ms WITH the created index.
