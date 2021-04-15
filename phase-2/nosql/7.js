db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const collisions = db.collisions
  .aggregate([
    {
      $match: {
        collision_date: { $regex: /^(2019).*/ },
      },
    },
    {
      $facet: {
        collisions_2019: [
          {
            $count: "collisions_2019",
          },
        ],
        collisions_Christmas_2019: [
          {
            $match: {
              collision_date: { $gte: "2019-12-18", $lte: "2019-12-25" },
            },
          },
          {
            $count: "holidays",
          },
        ],
      },
    },
    {
      $project: {
        "Daily average accidents in year 2019": {
          $round: [
            {
              $divide: [
                { $arrayElemAt: ["$collisions_2019.collisions_2019", 0] },
                365,
              ],
            },
            2,
          ],
        },
        "Daily average accidents in week of Christmas 2019": {
          $round: [
            {
              $divide: [
                { $arrayElemAt: ["$collisions_Christmas_2019.holidays", 0] },
                7,
              ],
            },
            2,
          ],
        },
      },
    },
  ])
  .toArray();

printjson({
  query:
    "Is there a higher number of accidents during 2019 holidays (week of Christmas)?",
  result: collisions[0],
  "execution time": `${new Date() - d} ms`,
});
