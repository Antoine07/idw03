# CRUD create/read/update/delete avec MongoDB avec la base de données shop

## Exercices inventory

Pour les exercices suivants vous pouvez créer un fonction de type cursor en JS :

```js
const myCursor = (restriction,projection) => db.collection.find(restriction, projection)
```

Vous pouvez également trier vos documents à l'aide de la méthode sort :

```js
const myCursorSort = (restriction, projection, keySort) => db.collection.find(restriction, projection).sort(keySort)
```

Créez une base de données **shop** et insérez les données suivantes :

```js
use shop;

db.createCollection("inventory");

db.inventory.insertMany( [
   {
      "sale" : true, "price" : 0.99,
      "society" : "Alex", type: "postcard", qty: 19,
      size: { h: 11, w: 29, uom: "cm" },
      status: "A",
      tags: ["blank", "blank", "blank"], 
      "year" : 2019  
    },
   { 
       "sale" : false,
       "price" : 1.99,
       "society" : "Alan",
       type: "journal",
       qty: 25,
       size: { h: 14, w: 21, uom: "cm" },
       status: "A",
       tags: ["blank", "red", "blank", "blank"],
       "year" : 2019  
   },
    { 
       "sale" : true,
       "price" : 1.5,
       "society" : "Albert",
       type: "notebook",
       qty: 50,
       size: { h: 8.5, w: 11, uom: "in" },
       status: "A",  
       tags: ["gray"],
       year : 2019
   },
   { 
       "sale" : true, 
       "price" : 7.99, 
       "society" : "Alice", 
       type: "lux paper", 
       qty: 100, 
       size: { h: 8.5, w: 11, uom: "in" }, 
       status: "D", 
       year : 2020 
   },
    { 
       "sale" : true, 
       "price" : 2.99, 
       "society" : "Sophie", 
       type: "planner", 
       qty: 75, 
       size: { h: 22.85, w: 30, uom: "cm" }, 
       status: "D", 
       tags: ["gel", "blue"], 
       year : 2017 
   },
   {
       "sale" : false, 
       "price" : 0.99, 
       "society" : "Phil", 
       type: "postcard", 
       qty: 45, 
       size: { h: 10, w: 15.25, uom: "cm" }, 
       status: "A", 
       tags: ["gray"], 
       year : 2018 
   },
   { 
       "sale" : true, 
       "price" : 4.99, 
       "society" : "Nel", 
       type: "journal", 
       qty: 19, 
       size: { h: 10, w: 21, uom: "cm" }, 
       status: "B", 
       tags: ["blank", "blank", "blank", "red"], 
       "year" : 2019, 
       level : 100  
   },
   { 
       "sale" : true, 
       "price" : 4.99, 
       "society" : "Alex", 
       type: "journal", 
       qty: 15, 
       size: { h: 17, w: 20, uom: "cm" }, 
       status: "C", 
       tags: ["blank"], 
       "year" : 2019  
   },
   { 
       "sale" : false, 
       "price" : 5.99, 
       "society" : "Tony", 
       type: "journal", 
       qty: 100, 
       size: { h: 14, w: 21, uom: "cm" }, 
       status: "B", 
       tags: ["blank","blank", "blank", "red"], 
       "year" : 2020  
   },
]);

```

1. Affichez tous les articles de type journal. Et donnez la quantité total de ces articles (propriété qty). Pensez à faire un script en JS.

```js
// 1. Première solution
// définition d'une fonction cursor
const cursorInventor = (rest, proj) => {
   return db.inventory.find(rest, proj);
};

let total = 0;
cursorInventor({ type: "journal" }, {_id: 0, qty: 1}).forEach( doc => {
   const { qty } = doc; // assignation par destructuration

    total += qty;
});
print(`Total des quantités : ${total}`);

// 1. Deuxième solution
total = 0; // portée globale
db.inventory.find({ type: "journal" }).forEach(doc => {
    const { qty } = doc; // assignation par destructuration

    total += qty;
});

print(`Total des quantités : ${total}`);
```

2. Affichez les noms de sociétés depuis 2018 ainsi que leur quantité.

3. Affichez les types des articles pour les sociétés dont le nom commence par A.

Vous utiliserez une expression régulière classique : /^A/

4. Affichez le nom des sociétés dont la quantité d'articles est supérieur à 45.

Utilisez les opérateurs supérieur ou inférieur :

```js
// supérieur >=
// {field: {$gte: value} }

// supérieur
// {field: {$gt: value} }

// inférieur <=
// {field: {$lte: value} }

// inférieur <
// {field: {$lt: value} }

```

5. Affichez le nom des sociétés dont la quantité d'article(s) est strictement supérieur à 45 et inférieur à 90.

6. Affichez le nom des sociétés dont le statut est A ou le type est journal.

7. Affichez le nom des sociétés dont le statut est A ou le type est journal et la quantité inférieur strictement à 100.

8. Affichez le type des articles qui ont un prix de 0.99 ou 1.99 et qui sont true pour la propriété sale ou ont une quantité strictement inférieur à 45.

9. Affichez le nom des scociétés et leur(s) tag(s) si et seulement si ces sociétés ont des tags ou un tag.

Vous pouvez utiliser l'opérateur d'existance de Mongo pour vérifier que la propriété existe, il permet de sélectionner ou non des documents :

```js
{ field: { $exists: <boolean> } }
```

10. Affichez le nom des sociétés qui ont au moins un tag blank.

## Modification du curseurs

```js
// Retourne la collection à partir du 6 documents
db.students.find().skip( 5 )
// Limite le nombre de documents
db.students.find().limit( 5 )
```

Les méthodes combinées suivantes modifiants le curseur sont équivalentes (même résultat) :

```js
db.students.find().sort( { name: 1 } ).limit( 5 )
db.students.find().limit( 5 ).sort( { name: 1 } )
```

## Mettre à jour un document dans une collection

Repartons de la collection inventory, la méthode updateOne permet de modifier un document selon un critère de recherche.

Remarque : pour supprimer l'ensemble des documents dans une collection utilisez la syntaxe suivante.

```js
db.inventory.remove({})
```

Notez que vous pouvez également supprimer des documents en spécifiant une restriction. Par exemple ci-dessous on souhaite supprimer toutes les entreprises dont la quantité est supérieur ou égale à 100 :

```js
db.inventory.remove({ qty : { $gte : 100 }});
```

Pour supprimer la collection elle-même, utilisez la méthode drop :

```js
db.inventory.drop()
```

## updateOne modification

- Exemple de modification avec la méthode updateOne

Structure :

- critère de recherche

- Modification avec l'opérateur set

Dans l'exemple suivant on modifie le premier document trouvé dont le status vaut B :

```js
db.inventory.updateOne(
   { status: "B" },
   {
     $set: { "size.uom": "cm", status: "X" },
     $currentDate: { lastModified: true }
   }
)
```

*Remarque : Si il y a plusieurs documents qui correspondent au critère de recherche, seulement le premier document dans l'ordre naturel ou l'ordre des mises jours sera modifié.*

Si MongoDB ne trouve pas le document, vous pouvez ajouter la propriété **upsert** qui permet de créer une ligne supplémentaire dans le document.

```js
db.inventory.updateOne(
   { status: "XXX" },
   {
     $set: { "size.uom": "cm", status: "SUPER" },
     $currentDate: { lastModified: true }
   },
    {"upsert": true}
)

// ici on aura un nouveau document
 // { "_id" : ObjectId("5ef43c659c3a4c119caf7ef5"), "status" : "SUPER" }
```

Vous pouvez également mettre à jour plusieurs documents en même temps à l'aide de la méthode suivante :

collection.updateMany()

Vous pouvez si vous le souhaitez définir une fonction utile pour la mise à jour :

```js
const query = {status : "A"};
const update = { "$mul": { "qty": 10 } };
const options = { "upsert": false }; // par défaut à false

// création d'une fonction de mise à jour
const updateInventory = (query, update, options) => db.inventory.updateMany(query, update, options) ;

updateInventory(query, update, options);
```

## Ajouter des valeurs à un champ de type array

Pour ajouter une valeur seulement si elle n'existe pas dans le array du champ en question on utilise l'opérateur suivant :

```js
// On utilise $addToSet
db.inventory.updateOne(
   { society: "Phil" },
   { $addToSet: { tags: "gray" } } // ["gray", "blue" ] // n'ajoute pas gray si celui existe déjà dans ce tableau
);
```

Pour ajouter une valeur même si elle existe quand même, on utilise l'opérateur push de Mongo :

```js
// On utilise $push 
db.inventory.updateOne(
   { society: "Phil" },
   { $push: { tags: "blue" } } // ["gray", "blue", "bleu" ] ajoute la valeur même si elle existe
);
```

Vous avez également les opérateurs suivants : **mult** et **inc** qui vous permettent de multiplier, de diviser et d'ajouter ou retirer des valeurs à un champ numérique :

```js
// une augmentation de 50  qty*0.5 + qty = qty( 0.5 + 1) = qty * 1.5
db.inventory.updateMany({ society: "Alan" }, { $mul: { qty: 1.5 } }) 
// ici on ajoute 5 à qty pour la/les société(s) Alan
db.inventory.updateMany({ society: "Alan" }, { $inc: { qty: 5 } }) 
```

## Exercice faire une augmentation de 50% 

Augmentez de 50% la quantité de chaque document qui a un status C ou D.

### Correction

```js
db.inventory.updateMany({
    status: {
        $in: ["C", "D"]
    }
}, {
    $mul: { qty: 1.5 }
})
```

## Exercice ajouter un champ et calculer

Ajoutez un champ **scores** de type **array** avec le score 19 pour les entreprises ayant une **qty** supérieure ou égale à 75.

### Correction

```js
db.inventory.updateMany( {
    qty : { $gte : 75}
}, {
    $set : {  scores : [19]}
})
```

Puis mettre à jour les entreprises ayant au moins une lettre a ou A dans leurs noms de société et ajouter leur un score 11 (champ scores).

### Correction

```js
db.inventory.updateMany(
    {
        society : /a/i
    },
    {
        $addToSet : { scores : 11 }
    }
)
```

Question supplémentaire affichez les docs qui ont un score de 11 :

```js

// permet d'ajouter plusieurs valeurs dans un tableau
db.inventory.updateOne(
    {
        society : "Alex"
    },
    {
        $push : { scores : { $each : [ 20, 18,17, 10 ]} }
    }
)

db.inventory.find({
    scores : 10 // cherche dans le tableau si la valeur de 10 est présente
}, { scores : 1, _id : 0, society : 1})

```

- Ajoutez une clé **comment** pour les sociétés Alex et ajouter un commentaire : "Hello Alex". Affichez maintenant tous les docs qui n'ont pas la clé comment.


## Correction

```js
db.inventory.updateMany(
    {
        society : "Alex"
    },
    {
        $set : { comment : "Hello Alex" },
        $currentDate: { lastModified: true }
    }
)

db.inventory.find(
    {
        comment : { $exists :  false }
    },
    { society : 1 , _id : 0 }
)
```

## Méthode unset

Vous pouvez également supprimer un champ ou clé d'un document à l'aide de l'opérateur **unset**, ci-dessous on supprime les champs qty et status du premier document qui match avec la recherche :

```js
db.inventory.updateOne(
   { status: "A" },
   { $unset: { qty: "", status: "" } }, // supprime les champs entre les accolades
   {"upsert": false} // prendre garde à ne pas ajouter un document par défaut ce champ est à false
)
```

## Exercice suppression d'un champ

Supprimez la propriété level se trouvant dans un/les document(s). Vérifiez qu'il existe au moins un doc qui possède le champ ou la clé level à l'aide d'une requête avant cette action.

### Correction

```js
db.inventory.find({ level : { $exists : true } }, { society : 1, level : 1 }) 
```

Vérifiez que le champ **level** n'existe plus après suppression.

### Correction

```js
db.inventory.updateMany(
    {
        level : {
            $exists : true
        }
    },
    {
        $unset : { level : ""}
    }
);
```

## Opérateur switch

Vous pouvez utiliser l'opérateur **switch** afin de modifier un document selon une liste de cas, attention à l'ordre dans lequel vous allez écrire vos case. Si un case match avec la condition alors le switch retourne une valeur. Attention cet opérateur doit-être mis dans des crochets :

```js
// partie update de la méthode updateMany
[
   "name_field" : { 
        $switch: {
            branches: [
                { case: { $eq: [ 0, 5 ] }, then: "equals" }, // chaque case break implicite
                { case: { $gt: 8 }, then: "greater than" },
                { case: { $gt: [ { $size :  "$notes" } , 2  ], then: "less than" }
            ],
            default : "nothing"
            }
        }
   }
]
```

Nous le répétons dès que l'on rentre dans un cas on sort du switch/case.

## Exercice switch

L'opérateur size permet de compter le nombre d'élément(s) dans un array. Il faut cependant pré-fixer la propriété avec un dollar :

```js
{ $size :  "$tags" }
```

Ajoutez la propriété **label** pour les documents ayant la propriété tags uniquement. Label prendra les valeurs suivantes selon le nombre de tags :

- si le nombre de tags est strictement supérieur à 1 : A
- si le nombre de tags est strictement supérieur à 3 : AA
- Et B sinon.

### Correction

```js
db.inventory.updateMany(
    { tags: { $exists: true } }, // restriction
    // mise à jour dans des crochets
    [
        {
            $set: {
                label: {
                    $switch: {
                        branches: [
                            { case: { $gt: [{ $size: "$tags" }, 3] }, then: "AA" },
                            { case: { $gt: [{ $size: "$tags" }, 1] }, then: "A" },
                        ],
                        default: "B"
                    }
                }
            }
        }
    ]
)
```

## db.collection.deleteOne

La méthode suivante permet de supprimer un document à l'aide d'une condition :

```js
 db.orders.deleteOne( { "_id" : ObjectId("563237a41a4d68582c2509da") } );
```

### Exercice d'application

Insérez le document suivant dans la collection inventory :

```js

db.inventory.insertOne( {
   name : "Test sur les dates",
   creationts: ISODate("2020-06-27T08:41:57.114Z"),
   expiryts: ISODate("2020-08-27T08:41:57.114Z")
})
```

Pour récupérez le dernier document inséré tapez la ligne de commande suivante :

```js
db.inventory.find().sort({_id: -1}).limit(1);
```

Maintenant supprimez ce document en fonction de sa date d'expiration :

```js
db.inventory.deleteOne( { "expiryts" : { $lte: ISODate("2020-08-27T08:41:57.114Z") } } );
```

Vérifiez que ce document est bien supprimé de la collection.

## db.collection.deleteMany

Cette méthode permet de supprimer plusieurs documents à l'aide d'un critère de sélection.

## Exercice inventory

Reprenez la collection inventory.

1. Donnez le nombre d'entreprise(s) qui ont/a exactement 2 tags.

2. Trouvez toutes les entreprises dont les deux premières lettres sont identiques.

3. Faites la somme des quantités par status (aggregate).

4. Hydratation : créez les champs **created_at** et **expired_at** pour chaque document de la collection inventory.

Vous utiliserez la méthode **ISODate** pour créer une date aléatoire ainsi que l'objet Date de JS. Aidez-vous de l'exemple ci-dessous :

- Exemple

Décallage d'un jour par rapport à la date actuelle :

```js
// Pour un jour
// 1 x 24 hours x 60 minutes x 60 seconds x 1000 milliseconds
let day = 1*24*60*60*1000

// Ajoute un jour à la date actuel
new Date( ISODate().getTime() + day )
```

4. (facultatif) Ajoutez un champ qui calcule le nombre de jours qui reste avant la suppression du document.

Vous pouvez utiliser les opérateurs suivants :

```js
// Pour faire une différence entre les dates
$subtract

// Pour calculer le nombre de jour
$divide
```


## Introduction à l'agrégation

Voici comment on peut faire une requête SQL qui compterait le nombre d'items dans la collection.

En SQL :

```sql
SELECT COUNT(*) FROM sales;
```

En MongoDB on utiliserait aggregate comme suit, group permet de regrouper selon un champ ou une clé. Si la clé vaut null alors on regroupe toute les lignes

```js
db.inventory.aggregate( [
  {
    $group: {
       _id: null,
       count: { $sum: 1 }
    }
  }
] )
// affichera
{ "_id" : null, "count" : 8 }
```

## Exercice calculer la somme des quantités par société

### Correction

```js
db.inventory.aggregate( [
  {
    $group: {
       _id: "$society", // la clé de regroupement
       totalQty: { $sum: "$qty" } // un calcul par regroupement
    }
  }
] )

// Pour vérifier faites la requête suivante
db.inventory.find({ society : "Alex"},{ _id : 0, qty: 1 })
```