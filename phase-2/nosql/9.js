db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const query = db.victims
  .aggregate([
    {
      $match: {
        victim_ejected: { $gt: 0 },
      },
    },
    {
      $facet: {
        Killed: [
          {
            $match: {
              victim_degree_of_injury: "killed",
            },
          },
          {
            $count: "Killed",
          },
        ],
        NotKilled: [
          {
            $match: {
              victim_degree_of_injury: {
                $in: [
                  "severe injury",
                  "other visible injury",
                  "no injury",
                  "complaint of pain",
                ],
              },
            },
          },
          {
            $count: "NotKilled",
          },
        ],
      },
    },
    {
      $project: {
        "Likelyhood in percentage:": {
          $multiply: [
            {
              $divide: [
                { $arrayElemAt: ["$Killed.Killed", 0] },
                { $arrayElemAt: ["$NotKilled.NotKilled", 0] },
              ],
            },
            100,
          ],
        },
      },
    },
  ])
  .toArray();

printjson({
  query: "What is the likelyhood of death after being ejected from a car?",
  result: query[0],
  "execution time": `${new Date() - d} ms`,
});
