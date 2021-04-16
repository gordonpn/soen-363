db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const d = new Date();
const causes = db.parties
  .aggregate([
    {
      $facet: {
        total_collisions: [{ $count: "total" }],
        cellphone: [
          {
            $match: {
              $or: [
                { cellphone_use: { $in: ["B", 1, 2] } },
                { other_associate_factor_1: "P" },
              ],
            },
          },
          {
            $count: "cellphone",
          },
        ],
        physical: [
          { $match: { party_drug_physical: { $in: ["E", "F", "I"] } } },

          {
            $group: {
              _id: "$party_drug_physical",
              count: { $sum: 1 },
            },
          },
          {
            $project: {
              _id: 0,
              under_drug_influence: {
                $cond: {
                  if: { $ne: ["E", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              impairment_physical: {
                $cond: {
                  if: { $ne: ["F", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              sleepy_fatigued: {
                $cond: {
                  if: { $ne: ["I", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
            },
          },
        ],
        sobriety: [
          { $match: { party_sobriety: { $in: ["B", "C", "D", "G"] } } },

          {
            $count: "sobriety",
          },
        ],
        others: [
          {
            $match: {
              other_associate_factor_1: { $nin: ["M", "L", "N", "F", ""] },
            },
          },

          {
            $group: {
              _id: "$other_associate_factor_1",
              count: { $sum: 1 },
            },
          },
          {
            $project: {
              _id: 0,
              vision_obscurements: {
                $cond: {
                  if: { $ne: ["E", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              stop_and_go_traffic: {
                $cond: {
                  if: { $ne: ["G", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              defective_vehicle_equipment: {
                $cond: {
                  if: { $ne: ["K", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              previous_collision: {
                $cond: {
                  if: { $ne: ["I", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              runaway_vehicle: {
                $cond: {
                  if: { $ne: ["O", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              entering_leaving_ramp: {
                $cond: {
                  if: { $ne: ["H", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              unfamiliar_with_road: {
                $cond: {
                  if: { $ne: ["J", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
              violation: {
                $cond: {
                  if: { $ne: ["A", "$_id"] },
                  then: "$$REMOVE",
                  else: "$count",
                },
              },
            },
          },
        ],
      },
    },
    {
      $project: {
        "cellphone (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$cellphone.cellphone", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "sobriety (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$sobriety.sobriety", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "under_drug_influence (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$physical.under_drug_influence", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "sleepy_fatigued (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$physical.sleepy_fatigued", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "impairment_physical (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$physical.impairment_physical", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "runaway_vehicle (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.runaway_vehicle", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "entering_leaving_ramp (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.entering_leaving_ramp", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "defective_vehicle_equipment (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    {
                      $arrayElemAt: ["$others.defective_vehicle_equipment", 0],
                    },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "stop_and_go_traffic (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.stop_and_go_traffic", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "unfamiliar_with_road (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.unfamiliar_with_road", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "previous_collision (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.previous_collision", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "violation (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.violation", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
              ],
            },
            2,
          ],
        },
        "vision_obscurements (%)": {
          $round: [
            {
              $multiply: [
                {
                  $divide: [
                    { $arrayElemAt: ["$others.vision_obscurements", 0] },
                    { $arrayElemAt: ["$total_collisions.total", 0] },
                  ],
                },
                100,
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
  query: "Causes of accident in percentage",
  result: causes[0],
  "execution time": `${new Date() - d} ms`,
});
