# SOEN 363 Project Phase 2

## Getting Started

**Important:** If you start the all compose services for the first time (without any prior initialized volumes), `pgadmin` and `mongo-express` will most likely fail because of the amount of time it takes to load the databases with the dataset. (The connection ports aren't ready until the initialization scripts are done running).

To alleviate this, you must run `docker-compose up postgres` and `docker-compose up mongo` each separately first and wait for the databases to finish being seeded.

**You need Docker and Docker-compose installed.**

To start all the containers, use `docker-compose up`.

### About the dataset

The dataset cannot be uploaded to GitHub because all the files exceed 100 MB.

You must download the `switrs.sqlite` file from <https://www.kaggle.com/alexgude/california-traffic-collision-data-from-switrs>.

The `sqlite` file needs to be converted/exported to `csv`. On a Mac/Linux system you may use the following commands one by one:

```bash
sqlite3 -header -csv switrs.sqlite "select * from case_ids where db_year = '2020';" > case_ids.csv

sqlite3 -header -csv switrs.sqlite "select id,parties.case_id as case_id,party_number,party_type,at_fault,party_sex,party_age,party_sobriety,party_drug_physical,direction_of_travel,party_safety_equipment_1,party_safety_equipment_2,financial_responsibility,hazardous_materials,cellphone_use,school_bus_related,oaf_violation_code,oaf_violation_category,oaf_violation_section,oaf_violation_suffix,other_associate_factor_1,other_associate_factor_2,party_number_killed,party_number_injured,movement_preceding_collision,vehicle_year,vehicle_make,statewide_vehicle_type,chp_vehicle_type_towing,chp_vehicle_type_towed,party_race from parties join case_ids on case_ids.case_id = parties.case_id where case_ids.db_year = '2020';" > parties.csv

sqlite3 -header -csv switrs.sqlite "select collisions.case_id as case_id,jurisdiction,officer_id,reporting_district,chp_shift,population,county_city_location,special_condition,beat_type,chp_beat_type,city_division_lapd,chp_beat_class,beat_number,primary_road,secondary_road,distance,direction,intersection,weather_1,weather_2,state_highway_indicator,caltrans_county,caltrans_district,state_route,route_suffix,postmile_prefix,postmile,location_type,ramp_intersection,side_of_highway,tow_away,collision_severity,killed_victims,injured_victims,party_count,primary_collision_factor,pcf_violation_code,pcf_violation_category,pcf_violation,pcf_violation_subsection,hit_and_run,type_of_collision,motor_vehicle_involved_with,pedestrian_action,road_surface,road_condition_1,road_condition_2,lighting,control_device,chp_road_type,pedestrian_collision,bicycle_collision,motorcycle_collision,truck_collision,not_private_property,alcohol_involved,statewide_vehicle_type_at_fault,chp_vehicle_type_at_fault,severe_injury_count,other_visible_injury_count,complaint_of_pain_injury_count,pedestrian_killed_count,pedestrian_injured_count,bicyclist_killed_count,bicyclist_injured_count,motorcyclist_killed_count,motorcyclist_injured_count,primary_ramp,secondary_ramp,latitude,longitude,collision_date,collision_time,process_date from collisions join case_ids on case_ids.case_id = collisions.case_id where case_ids.db_year = '2020';" > collisions.csv

sqlite3 -header -csv switrs.sqlite "select id,victims.case_id as case_id,party_number,victim_role,victim_sex,victim_age,victim_degree_of_injury,victim_seating_position,victim_safety_equipment_1,victim_safety_equipment_2,victim_ejected from victims join case_ids on case_ids.case_id = victims.case_id where case_ids.db_year = '2020';" > victims.csv
```

**Warning**: May take a while to generate, it took my computer ~10 minutes for all 4 tables.

Move all the created `csv` files into the folder `dataset` inside of `phase-2`.

Documentation of this dataset: <https://tims.berkeley.edu/help/SWITRS.php>

Starting the postgres container for the first times takes ~25 minutes due to the initialization script.

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

To execute a file named `test-mongo.js`, you can use the command `mongo test-mongo.js`.

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
