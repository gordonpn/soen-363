db = new Mongo().getDB("soen-363");
db.auth("example", "example");

db.parties.createIndex({ case_id: 1 });
db.collisions.createIndex({ case_id: 1 });
db.victims.createIndex({ case_id: 1 });

db.parties.createIndex({ at_fault: 1, party_type: 1 });
