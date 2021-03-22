CREATE TABLE case_ids (
  case_id text NOT NULL PRIMARY KEY,
  db_year int
);

CREATE TABLE collisions (
  case_id text NOT NULL,
  FOREIGN KEY (case_id) REFERENCES case_ids (case_id),
  jurisdiction int,
  officer_id text,
  reporting_district text,
  chp_shift text,
  population text,
  county_city_location text,
  special_condition text,
  beat_type text,
  chp_beat_type text,
  city_division_lapd text,
  chp_beat_class text,
  beat_number text,
  primary_road text,
  secondary_road text,
  distance real,
  direction text,
  intersection int,
  weather_1 text,
  weather_2 text,
  state_highway_indicator int,
  caltrans_county text,
  caltrans_district int,
  state_route int,
  route_suffix text,
  postmile_prefix text,
  postmile real,
  location_type text,
  ramp_intersection int,
  side_of_highway text,
  tow_away int,
  collision_severity text,
  killed_victims int,
  injured_victims int,
  party_count int,
  primary_collision_factor text,
  pcf_violation_code text,
  pcf_violation_category text,
  pcf_violation int,
  pcf_violation_subsection text,
  hit_and_run text,
  type_of_collision text,
  motor_vehicle_involved_with text,
  pedestrian_action text,
  road_surface text,
  road_condition_1 text,
  road_condition_2 text,
  lighting text,
  control_device text,
  chp_road_type text,
  pedestrian_collision int,
  bicycle_collision int,
  motorcycle_collision int,
  truck_collision int,
  not_private_property int,
  alcohol_involved int,
  statewide_vehicle_type_at_fault text,
  chp_vehicle_type_at_fault text,
  severe_injury_count int,
  other_visible_injury_count int,
  complaint_of_pain_injury_count int,
  pedestrian_killed_count int,
  pedestrian_injured_count int,
  bicyclist_killed_count int,
  bicyclist_injured_count int,
  motorcyclist_killed_count int,
  motorcyclist_injured_count int,
  primary_ramp text,
  secondary_ramp text,
  latitude real,
  longitude real,
  collision_date text,
  collision_time text,
  process_date text
);

CREATE TABLE parties (
  id int,
  case_id text NOT NULL,
  FOREIGN KEY (case_id) REFERENCES case_ids (case_id),
  party_number int NOT NULL,
  PRIMARY KEY (case_id, party_number),
  party_type text,
  at_fault int,
  party_sex text,
  party_age int,
  party_sobriety text,
  party_drug_physical text,
  direction_of_travel text,
  party_safety_equipment_1 text,
  party_safety_equipment_2 text,
  financial_responsibility text,
  hazardous_materials text,
  cellphone_use text,
  school_bus_related text,
  oaf_violation_code text,
  oaf_violation_category text,
  oaf_violation_section int,
  oaf_violation_suffix text,
  other_associate_factor_1 text,
  other_associate_factor_2 text,
  party_number_killed int,
  party_number_injured int,
  movement_preceding_collision text,
  vehicle_year int,
  vehicle_make text,
  statewide_vehicle_type text,
  chp_vehicle_type_towing text,
  chp_vehicle_type_towed text,
  party_race text
);

CREATE TABLE victims (
  id int,
  case_id text NOT NULL,
  FOREIGN KEY (case_id) REFERENCES case_ids (case_id),
  party_number int NOT NULL,
  FOREIGN KEY (case_id, party_number) REFERENCES parties (case_id, party_number),
  victim_role text,
  victim_sex text,
  victim_age int,
  victim_degree_of_injury text,
  victim_seating_position text,
  victim_safety_equipment_1 text,
  victim_safety_equipment_2 text,
  victim_ejected text
);

COPY case_ids
FROM
  '/var/lib/postgresql/dataset/case_ids.csv' DELIMITER ',' csv header;

COPY collisions
FROM
  '/var/lib/postgresql/dataset/collisions.csv' DELIMITER ',' csv header;

COPY parties
FROM
  '/var/lib/postgresql/dataset/parties.csv' DELIMITER ',' csv header;

COPY victims
FROM
  '/var/lib/postgresql/dataset/victims.csv' DELIMITER ',' csv header;

