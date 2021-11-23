--01 Exercice Calculez la moyenne des heures de vol pour chaque compagnie.

SELECT ROUND( AVG(numFlying), 1 ) as avg_numFlying ,compagny
FROM pilots
GROUP BY compagny;

-- 02 Exercice Calculez la moyenne des heures de vol des pilots dont le bonus est de 500 par compagnie

SELECT ROUND( AVG(numFlying), 1 ) as avg_numFlying ,compagny
FROM pilots
WHERE bonus=500
GROUP BY compagny;

-- 03 Exercice Sélectionnez le nombre de pilote(s) par compagnie ayant plus d'un d'un pilote.

SELECT COUNT(certificate) as nb_pilot, compagny
FROM pilots
GROUP BY compagny
HAVING nb_pilot > 1;