db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const query = db.collisions
  .aggregate([
    {
      $facet: {
        Alcohol: [
          {
            $match: {
              hit_and_run: "felony",
              lighting: "daylight",
              alcohol_involved: 1,
            },
          },
          {
            $count: "Alcohol",
          },
        ],
        NoAlcohol: [
          {
            $match: {
              hit_and_run: "felony",
              lighting: "daylight",
              alcohol_involved: "",
            },
          },
          {
            $count: "NoAlcohol",
          },
        ],
      },
    },
    {
      $project: {
        "Alcohol involvement": { $arrayElemAt: ["$Alcohol.Alcohol", 0] },
        "No alcohol involvement": { $arrayElemAt: ["$NoAlcohol.NoAlcohol", 0] },
      },
    },
  ])
  .toArray();

printjson({
  query:
    "How many felony hit and runs in broad daylight have involvement of alcohol versus no involvement of alcohol?",
  result: query[0],
});
