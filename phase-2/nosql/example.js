db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const officer11342Collisions = db.collisions
  .find({ officer_id: { $eq: 11342 } })
  .toArray();

printjson(officer11342Collisions.length);
