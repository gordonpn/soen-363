db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.collisions
  .aggregate([
    {
      $match: {
        pcf_violation_category: "speeding",
      },
    },
    { $group: { _id: "$type_of_collision", count: { $sum: 1 } } },
    { $sort: { count: -1 } },
  ])
  .toArray();

printjson({
  query: "What is the most common type of collision from speeding?",
  result: query,
  "execution time": `${new Date() - d} ms`,
});
