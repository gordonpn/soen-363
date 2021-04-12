db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const query = db.collisions
  .find({
    road_condition_1: "holes",
    weather_1: "clear",
    $or: [
      { collision_severity: "fatal" },
      { collision_severity: "severe injury" },
    ],
  })
  .toArray();

printjson({
  query:
    "Number of collisions caused by holes on the road with clear weather condition that ended fatally or with severe injury:",
  result: query.length,
});
