db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.collisions
  .aggregate([
    {
      $match: {
        primary_road: { $ne: "" },
      },
    },
    {
      $group: {
        _id: "$primary_road",
        collision_count: { $sum: 1 },
      },
    },
    { $sort: { collision_count: -1 } },
    { $limit: 10 },
  ])
  .toArray();

printjson({
  query: "What are the top 10 primary roads where accidents happened?",
  result: query,
  "execution time": `${new Date() - d} ms`,
});