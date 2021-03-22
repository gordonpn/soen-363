# SOEN 363 Project Phase 2

## Getting Started

The dataset cannot be uploaded to GitHub because all the files exceed 100 MB.

You must download the `switrs.sqlite` file from <https://www.kaggle.com/alexgude/california-traffic-collision-data-from-switrs>.

The `sqlite` file needs to be converted/exported to `csv`. On a Mac/Linux system you may use the following commands one by one:

```bash
sqlite3 -header -csv switrs.sqlite "select * from parties;" > parties.csv
sqlite3 -header -csv switrs.sqlite "select * from collisions;" > collisions.csv
sqlite3 -header -csv switrs.sqlite "select * from case_ids;" > case_ids.csv
sqlite3 -header -csv switrs.sqlite "select * from victims;" > victims.csv
```

**Warning**: May take a while to generate, it took my computer ~10 minutes for all 4 tables.

Move all the created `csv` files into the folder `dataset` inside of `phase-2`.

<https://tims.berkeley.edu/help/SWITRS.php>

Starting the postgres container for the first times takes about 25 minutes due to the initialization script.

### NoSQL

Mongo-express is available at <http://localhost:8081>

|          |         |
| -------- | ------- |
| username | root    |
| password | example |

### SQL

You need Docker and Docker-compose installed.

At the project root directory, run `docker-compose up` or `docker-compose up -d` or `make up` to spin up the containers.

The above will start PostgreSQL and pgAdmin containers.

pgAdmin can be used as a development tool and is accessible at <http://localhost:5050> after starting the containers.

The login info is as follows:

|          |                  |
| -------- | ---------------- |
| email    | admin@secret.com |
| password | secret           |

Then you must "add new server", with the following information:

|          |          |
| -------- | -------- |
| host     | postgres |
| username | postgres |
| password | secret   |
