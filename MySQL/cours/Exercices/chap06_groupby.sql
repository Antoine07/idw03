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

-- 04 DONE

-- 05 Sélectionnez le nombre de pilote(s) par compagnie et par type d'avion.

SELECT compagny, plane, COUNT(certificate) as nb_pilot 
FROM pilots
GROUP BY compagny, plane;

-- 06 Exercice

-- Sélectionnez le noms des pilotes par bonus.

SELECT bonus, GROUP_CONCAT(`name`)
FROM pilots
GROUP BY bonus;

-- Sélectionnez le noms et la compagnie des pilotes par bonus.

SELECT bonus, GROUP_CONCAT(`name`, " ", `compagny`) as gnc
FROM pilots
GROUP BY bonus;

-- Exercice 07 Calculez l'étendue du nombre d'heure de vol par compagnie.

SELECT compagny, MAX(numFlying) - MIN(numFlying) as range_numFlying
FROM pilots
GROUP BY compagny;

-- Exercice 08 Faites la somme du nombre de jours de vols par compagnie dont la somme est supérieur à 30.

SELECT compagny, ROUND( SUM(numFlying)/24, 1) as nb_days
FROM pilots
GROUP BY compagny
HAVING nb_days > 30 ;

-- Exercice 09 Nombre de compagnie(s) dont le nombre d'heures de vol est de moins de 200 heures.
SELECT COUNT(*) as nb_compagny
FROM compagnies
WHERE comp IN (
    SELECT compagny
    FROM pilots
    GROUP BY compagny
    HAVING  SUM(numFlying) < 200 
);