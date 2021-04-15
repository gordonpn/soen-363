db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.parties
  .aggregate([
    {
      $match: {
        party_age: { $gte: 95 },
        at_fault: 1,
        party_type: "driver",
      },
    },
    {
      $lookup: {
        from: "collisions",
        localField: "case_id",
        foreignField: "case_id",
        as: "collision_info",
      },
    },
    {
      $group: {
        _id: "$collision_info.pedestrian_action",
        count: { $sum: 1 },
      },
    },
    { $sort: { count: -1 } },
  ])
  .toArray();

printjson({
  query:
    "How likely is it that pedestrians are involved when drivers 95+ years old are at fault in a collision?",
  result: query,
  "execution time": `${new Date() - d} ms`,
});
