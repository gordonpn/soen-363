CREATE TABLE movies (
  mid integer PRIMARY KEY,
  title varchar(255) NOT NULL,
  year integer NOT NULL,
  rating real,
  num_ratings integer
);

CREATE TABLE actors (
  mid integer NOT NULL,
  name varchar(255) NOT NULL,
  cast_position integer NOT NULL,
  FOREIGN KEY (mid) REFERENCES movies (mid) ON DELETE CASCADE
);

CREATE TABLE genres (
  mid integer NOT NULL,
  genre varchar(255) NOT NULL,
  FOREIGN KEY (mid) REFERENCES movies (mid) ON DELETE CASCADE
);

CREATE TABLE tag_names (
  tid integer PRIMARY KEY,
  tag varchar(255) NOT NULL
);

CREATE TABLE tags (
  mid integer NOT NULL,
  tid integer NOT NULL,
  FOREIGN KEY (mid) REFERENCES movies (mid) ON DELETE CASCADE,
  FOREIGN KEY (tid) REFERENCES tag_names (tid) ON DELETE CASCADE
);

COPY movies
FROM
  '/var/lib/postgresql/dataset/movies.dat' WITH DELIMITER E'\t';

COPY actors
FROM
  '/var/lib/postgresql/dataset/actors.dat' WITH DELIMITER E'\t';

COPY genres
FROM
  '/var/lib/postgresql/dataset/genres.dat' WITH DELIMITER E'\t';

COPY tag_names
FROM
  '/var/lib/postgresql/dataset/tag_names.dat' WITH DELIMITER E'\t';

COPY tags
FROM
  '/var/lib/postgresql/dataset/tags.dat' WITH DELIMITER E'\t';

