
-- 01 Exercice Quelles sont les coordonnées des compagnies qui employe(nt) des pilotes faisant moins de 90 heures de vols ?

SELECT street, numStreet, city FROM `compagnies`
WHERE `comp` IN (
    SELECT DISTINCT `compagny` 
    FROM `pilots`
    WHERE `numFlying` < 90
);

-- 02 Exercice faites la somme des heures de vols des pilotes de la compagnie Air France.

SELECT SUM(numFlying) as sum_numFlying
FROM pilots
WHERE compagny IN (
    SELECT comp
    FROM compagnies
    WHERE `name` = 'Air France'
);

-- 03 Exercice Trouvez toute(s) les/la compagnie(s) n'ayant pas de pilot.

INSERT INTO compagnies
SET comp = 'ITA', street= 'Napoli', city='Rome', `name`='Italia Air', numStreet = 20;

SELECT `name` 
FROM compagnies
WHERE comp NOT IN (
    SELECT compagny
    FROM pilots
);