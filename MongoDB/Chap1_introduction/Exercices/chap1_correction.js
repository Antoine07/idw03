// Notez que une virgule séparant deux conditions est équivalent à un and
db.restaurants.find(
  {
    borough: "Brooklyn",
    $or: [{ name: /^B/ }, { name: /^W/ }],
  },
  { name: 1, borough: 1 }
);

db.restaurants.find(
  {
    $and: [
      {
        borough: "Brooklyn",
      },
      {
        $or: [{ name: /^B/ }, { name: /^W/ }],
      },
    ],
  },
  { name: 1, borough: 1 }
);


// Permet de parcourir l'ensemble des résultats 
let count = 0 ;
db.restaurants.find({borough: "Brooklyn"}, { _id : 0, name : 1}).forEach((doc) => print(tojson(doc)));

print("total", count);

// count