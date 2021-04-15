db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.parties
  .aggregate([
    {
      $match: {
        party_age: { $gte: 65 },
        at_fault: 1,
        party_type: "driver",
      },
    },
    {
      $group: {
        _id: "$movement_preceding_collision",
        count: { $sum: 1 },
      },
    },
    { $sort: { count: -1 } },
    { $limit: 5 },
  ])
  .toArray();

printjson({
  query:
    "What kind of maneuvers were seniors doing when they cause a collision?",
  result: query,
  "execution time": `${new Date() - d} ms`,
});
