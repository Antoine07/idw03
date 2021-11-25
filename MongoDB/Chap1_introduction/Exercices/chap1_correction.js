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

db.restaurants
  .find({ borough: "Brooklyn" }, { _id: 0, name: 1 })
  .forEach((doc) => print(tojson(doc)));

print("total", count);

// count
let count = 0;
db.restaurants
  .find({ borough: "Brooklyn" }, { _id: 0, name: 1 })
  .forEach((doc) => {
    count++;
  });
print(count);

// comparaison avec la méthode count
db.restaurants.find({ borough: "Brooklyn" }, { _id: 0, name: 1 }).count();

const cursor = db.restaurants.find(
  { borough: "Brooklyn" },
  { _id: 0, name: 1 }
);

cursor.forEach((doc) => {
  print(tojson(doc));
});

// 04 Exercice liste

/*
1. Combien y a t il de restaurants qui font de la cuisine italienne et qui ont eu un score de 10 au moins ? Affichez également le nom, les scores et les coordonnées GPS de ces restaurants. Ordonnez les résultats par ordre décroissant sur les noms des restaura
*/

db.restaurants
  .find(
    {
      cuisine: "Italian",
      "grades.score": { $gte: 10 }, // vérifie qu'il y a au moins un score >= 10 dans l'ensemble des scores
    },
    {
      name: 1,
      "grades.score": 1,
      "address.coord": 1,
      _id: 0,
    }
  )
  .pretty();

/*
2. Quels sont les restaurants qui ont eu un grade A avec un score supérieur ou égal à 20 en même temps ? Affichez uniquement les noms et ordonnez les par ordre décroissant. Affichez le nombre de résultat.
*/

db.restaurants
  .find(
    {
      grades: {
        $elemMatch: { score: { $gte: 20 }, grade: "A" }, // il faut qu'au moins une fois score et garde match avec les contraintes
      },
    },
    {
      name: 1,
      "grades.score": 1,
      "grades.grade": 1,
      _id: 0,
    }
  )
  .sort({ name: -1 })
  .pretty();

/*
3. Quels sont les restaurants qui ont eu un grade A et un score supérieur ou égal à 20 ? Affichez uniquement les noms et ordonnez les par ordre décroissant. Affichez le nombre de résultat.

*/

db.restaurants
  .find({
    "grades.grade": "A",
    "grades.score": { $gte: 20 },
  })
  .sort({
    name: -1,
  })
  .pretty();

/*
4 .A l'aide de la méthode distinct trouvez tous les quartiers distincts de NY.
*/

db.restaurants.distinct("borough"); // retourne un tableau

/*
5 .Trouvez tous les types de restaurants dans le quartiers du Bronx. Vous pouvez là encore utiliser distinct et un deuxième paramètre pour préciser sur quel ensemble vous voulez appliquer cette close :
*/

db.restaurants.distinct("cuisine", { borough : "Bronx"}); // retourne un tableau


/*
6. Sélectionnez les restaurants dont le grade est A ou B dans le Bronx.
*/

db.restaurants.find({
    borough : "Bronx",
    "grades.grade" : { $in : ["A", "B"]} 
}, {
    _id : 0,
    name : 1
}).pretty();

/*

7. Même question mais, on aimerait récupérer les restaurants qui ont eu à la dernière inspection un A ou B. Vous pouvez utilisez la notion d'indice sur la clé grade :
*/

db.restaurants.find({
    $and : [
        {borough: "Bronx"},
        {$or : [{"grades.0.grade" : "A"}, { "grades.0.grade" : "B"} ]}
    ]
}, {
    _id : 0,
    name : 1, 
    grades : 1
}).pretty();