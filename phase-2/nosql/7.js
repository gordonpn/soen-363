db = new Mongo().getDB("soen-363");
db.auth("example", "example");

const num_days_2019=365
const collisions_2019=db.collisions.find({collision_date:{$regex:/^(2019).*/}}).toArray()
const collisions_2019_Christmas_week=db.collisions.find({collision_date:{$gte:"2019-12-18", $lte:"2019-12-25"}}).toArray()

print("Is there a higher number of accidents during 2019 holidays (week of Christmas)?")
print("Daily average accidents in year 2019: "+(collisions_2019.length/num_days_2019).toFixed(2))
print("Daily average accidents in week of Christmas 2019: "+(collisions_2019_Christmas_week.length/7).toFixed(2))
