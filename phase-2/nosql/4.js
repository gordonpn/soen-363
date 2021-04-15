db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.collisions
  .aggregate([
    {
      $match: {
        road_surface: { $in: ["slippery", "snowy", "wet"] },
      },
    },
    {
      $group: {
        _id: {
          pedestrian: "$pedestrian_action",
          severity: "$collision_severity",
        },
        count: { $sum: 1 },
      },
    },
    { $sort: { count: -1 } },
  ])
  .toArray();

printjson({
  query:
    "Are pedestrians usually involved, and how severe is the collision when the road surface is slippery, snowy, or wet?",
  result: query.slice(0, 5),
  "execution time": `${new Date() - d} ms`,
});
