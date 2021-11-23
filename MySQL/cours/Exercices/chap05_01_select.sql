-- 01 Sélectionnez tous les pilotes de la compagnie AUS

SELECT `name`
FROM pilots
WHERE compagny='AUS';

-- 02 Sélectionnez les noms des pilotes de la compagnie FRE1 ayant fait plus de 15 heures de vols.

SELECT `name`
FROM pilots
WHERE compagny='FRE1' AND numFlying > 15;

-- 03 Sélectionnez les noms des pilotes de la compagnie FRE1 ayant fait plus de 20 heures de vols.

SELECT `name`
FROM pilots
WHERE compagny='FRE1' AND numFlying > 20;

-- 04 Sélectionnez les noms des pilotes de la compagnie FRE1 ou AUST ayant fait plus de 20 heures de vol.

SELECT `name`, numFlying
FROM pilots
WHERE ( compagny='FRE1' OR compagny='AUS' ) AND numFlying > 20;

SELECT `name`, numFlying
FROM pilots
WHERE compagny='FRE1' IN ('FRE1', 'AUST') AND numFlying > 20;

-- 05 Sélectionnez les noms des pilotes ayant fait entre 190 et 200 heures de vols.

-- BETWEEN inégalité large
SELECT `name`
FROM pilots
WHERE numFlying BETWEEN 190 AND 200;

SELECT `name`
FROM pilots
WHERE numFlying  >= 190 AND numFlying <= 200;

-- 06 Sélectionnez les noms des pilotes qui sont nés après 1978.

SELECT `name`, birth_date
FROM pilots
WHERE YEAR(birth_date) > '1978'; 

-- 07 Sélectionnez les noms des pilotes qui sont nés avant 1978.

SELECT `name`, birth_date
FROM pilots
WHERE YEAR(birth_date) < '1978'; 

-- 08 Sélectionnez les noms des pilotes qui sont nés entre 1978 et 2000.

SELECT `name`, birth_date
FROM pilots
WHERE YEAR(birth_date) BETWEEN '1978' AND '2000'; 

-- 09 Quels sont les pilotes qui ont un vol programmé après 2020-05-08 ?

-- Il existe des fonctions en MySQL qui permettent de formater dans la recherche ou la sélection les dates 
-- YEAR pour l'année, DAY pour le jour, MONTH pour le mois, DATE pour la date, ... Attention on travaille avec MySQL ces fonctions peuvent être différentes selon la SGDB

SELECT `name`, next_flight
FROM pilots
WHERE DATE(next_flight) >= '2020-05-09'; 

-- 10 Sélectionnez tous les noms des pilotes qui sont dans les compagnies : AUS et FRE1.

SELECT `name`, numFlying
FROM pilots
WHERE compagny='FRE1' IN ('FRE1', 'AUST');

-- 11 Sélectionnez tous les des pilotes dont le nom de compagnie contient un E.

SELECT `name`
FROM pilots
WHERE compagny IN (
    SELECT comp 
    FROM compagnies
    WHERE `name` LIKE '%e%'
);

-- Recherche sensible à la casse par exemple on recherche les noms de compagnies avec un petit "e", on utiliserait REGEXP
-- utilisez la clause BINARY pour comparer un binaire dans la recherche
SELECT comp, `name`
FROM compagnies
WHERE BINARY `name` REGEXP 'e';

-- 12.01 Sélectionnez tous les noms pilotes dont le nom de la compagnie commence par un A.

SELECT `name`
FROM pilots
WHERE compagny IN (
    SELECT comp 
    FROM compagnies
    WHERE `name` LIKE 'a%'
);

-- 12.02 Sélectionnez tous les noms pilotes dont le nom de la compagnie commence par un A en majuscule

SELECT `name`
FROM pilots
WHERE compagny IN (
    SELECT comp 
    FROM compagnies
    WHERE BINARY `name` REGEXP '^A'
);

-- 13 Sélectionnez tous les pilotes dont le nom de la compagnie contient un I suivi d'un caractère.

SELECT `name`
FROM pilots
WHERE compagny IN (
    SELECT comp 
    FROM compagnies
    WHERE `name` LIKE '%I_'
);

-- 14 Que fait la commande suivante ? Ecrivez la question qui correspond à la réponse SQL ci-dessous :

SELECT 
ROUND(num_jobs / (SELECT SUM(num_jobs) from pilots), 2 )*100 as per_job 
FROM pilots 
WHERE num_jobs IS NOT NULL;

-- Cette requête correspond au pourcentage du nombre de job pour les pilotes.

/*
02 Exercice 
Ajoutez une colonne bonus à la table pilots, puis ajoutez le bonus 1000 pour les certificats 'ct-1', 'ct-11', 'ct-12', pour le certificat ct-56 un bonus de 2000 et pour tous les autres 500.
*/

ALTER TABLE pilots
ADD bonus DECIMAL(5,1) AFTER name;

UPDATE pilots
SET bonus = 
(CASE 
    WHEN certificate IN ('ct-1', 'ct-11', 'ct-12') THEN 1000.0
    WHEN certificate IN ('ct-56') THEN 2000.0
    ELSE 500.0
END);

/*
03 Exercice 
Faites une requête permettant de sélectionner le pilote ayant eu le meilleur bonus. Vous pouvez utiliser la fonction max de MySQL.
*/

SELECT `name`
FROM pilots
WHERE bonus = (SELECT MAX(bonus) FROM pilots);

--  04 Exercice  Combien y-a-t-il d'heure de vols distincts dans la table pilotes ?
SELECT COUNT( DISTINCT numFlying ) as nb_numFlying
FROM pilots;

-- 05 Exercice Combien de pilotes sont en dessous de la moyenne d'heure de vols ?

-- moyenne des heures de vol
SELECT `name`
FROM pilots
WHERE numFlying < (SELECT AVG(numFlying) FROM pilots);