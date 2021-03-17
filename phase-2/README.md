# SOEN 363 Project Phase 2

## Getting Started

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
