db = new Mongo().getDB("soen-363");
db.auth("example", "example");

// it seems that the data variable names and values don't match up with the documentation
// the query below can be used to list unique values for a certain variable/column/property
// use mongo-express to find the variable/column/property names

// printjson(db.collisions.distinct("road_surface"));
// printjson(db.collisions.distinct("type_of_collision"));
// printjson(db.collisions.distinct("pcf_violation_category"));
// printjson(db.collisions.distinct("road_condition_2"));
// printjson(db.collisions.distinct("weather_1"));
// printjson(db.collisions.distinct("weather_2"));
// printjson(db.collisions.distinct("road_surface"));
// printjson(db.collisions.distinct("chp_beat_type"));
// printjson(db.parties.distinct("party_type"));
printjson(db.victims.distinct("victim_degree_of_injury"));
