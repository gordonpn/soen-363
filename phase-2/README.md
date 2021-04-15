# SOEN 363 Project Phase 2

## Getting Started

**Important:** If you start the all compose services for the first time (without any prior initialized volumes), `pgadmin` and `mongo-express` will most likely fail because of the amount of time it takes to load the databases with the dataset. (The connection ports aren't ready until the initialization scripts are done running).

To alleviate this, you must run `docker-compose up postgres` and `docker-compose up mongo` each separately first and wait for the databases to finish being seeded.

**You need Docker and Docker-compose installed.**

To start all the containers, use `docker-compose up`.

### About the dataset

You must download the `switrs.sqlite` file from <https://www.kaggle.com/alexgude/california-traffic-collision-data-from-switrs>.

The `sqlite` file needs to be converted/exported to `csv`. On a Mac/Linux system you may use the bash script `./dataset/export_sqlite.sh`.

Or simply unzip `dataset.zip` inside the `/dataset` directory.

**Warning**: May take a while to generate, it took my computer ~10 minutes for all 3 tables.

Move all the created `csv` files into the folder `dataset` inside of `phase-2`.

Documentation of this dataset: <https://tims.berkeley.edu/help/SWITRS.php>

Starting the postgres container for the first times takes ~15 minutes due to the initialization script.

### NoSQL

At the project root directory, run `docker-compose up mongo mongo-express` and this will start the `mongo` and `mongo-express` service only.

Mongo-express is available at <http://localhost:8081>

|          |         |
| -------- | ------- |
| username | root    |
| password | example |

#### Working with queries in MongoDB

Unfortunately, the mongo-express interface doesn't allow running queries like the pgadmin interface does.

Instead, the `phase-2/nosql` directory is mounted inside the container, in this directory you can write queries in separate `.js` files and they will be available inside the container.

First, you must attach a shell, using the VSCode extension or by using the command `docker exec -it mongo-soen-363-p2 bash`. Then change directory into `/home` with `cd /home` and the scripts will be there.

To execute a file named `example.js`, you can use the command `mongo example.js`.

### SQL

At the project root directory, run `docker-compose up postgres pgadmin` and this will start the `postgres` and `pgadmin` service only.

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
