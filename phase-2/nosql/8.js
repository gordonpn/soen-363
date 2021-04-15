db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.parties
  .aggregate([
    {
      $match: {
        party_type: "driver",
        at_fault: 1,
        vehicle_make: { $ne: "" },
      },
    },
    {
      $group: {
        _id: "$vehicle_make",
        collision_count: { $sum: 1 },
      },
    },
    { $sort: { collision_count: -1 } },
    { $limit: 5 },
  ])
  .toArray();

printjson({
  query: "What are the top 5 cars that at fault drivers enter collisions in?",
  result: query,
  "execution time": `${new Date() - d} ms`,
});
