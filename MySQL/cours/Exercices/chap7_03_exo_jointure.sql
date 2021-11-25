
ALTER TABLE `pilots`
ADD `lead_pl` VARCHAR(6);

-- foreign key

ALTER TABLE `pilots` 
ADD CONSTRAINT `fk_pilots_lead_pl_pilots_certificate`
FOREIGN KEY (`lead_pl`) 
REFERENCES `pilots`(`certificate`);

-- UPDATE 

UPDATE `pilots` 
SET `lead_pl` = 'ct-7'
WHERE certificate IN ('ct-1', 'ct-100', 'ct-10');

UPDATE `pilots` 
SET `lead_pl` = 'ct-6'
WHERE certificate IN ('ct-11', 'ct-12', 'ct-16');

-- Pilotes n'ayant pas de chef

SELECT `name`
FROM `pilots`
WHERE `lead_pl` IS NULL;

-- 02 Exercice 

SELECT `p`.`certificate`, `c`.`name`
FROM `compagnies` as `c`
JOIN `pilots` as `p` ON `p`.`compagny`  =  `c`.`comp`;

-- Ici on utilise la clause WHERE qui permet de faire une restriction

SELECT `p`.`certificate`, `c`.`name`
FROM `compagnies` as `c`
JOIN `pilots` as `p` ON `p`.`compagny`  =  `c`.`comp`
WHERE `c`.`name` = 'Air France'
AND `p`.`numFlying` > 60;

-- 03 Exercice 

SELECT SUM(p.numFlying) as sum_numFlying
FROM pilots as p
JOIN compagnies as c
ON p.compagny = c.comp
WHERE c.name = 'AUSTRA Air';


-- 04

-- 04 01
SELECT c.name, p.certificate, p.name 
FROM compagnies as c 
RIGHT OUTER JOIN pilots as p 
ON p.compagny = c.comp ;

-- 04 02
SELECT c.name, p.certificate, p.name 
FROM compagnies as c 
LEFT OUTER JOIN pilots as p 
ON p.compagny = c.comp
WHERE p.compagny IS NULL;

-- 05 

-- première version avec un deuxième SELECT sans jointure

SELECT c.name as name_compagny, p.certificate, p.name
FROM pilots as p
RIGHT OUTER JOIN compagnies as c
ON p.compagny = c.comp
UNION
SELECT NULL, `certificate`, `name`
FROM pilots
WHERE compagny is NULL;

-- Solution avec deux jointures une union
SELECT c.`name` AS name_compagny, p.certificate AS certificate, p.`name` AS pilot_name
FROM compagnies AS c
LEFT OUTER JOIN pilots AS p
ON c.comp = p.compagny
UNION
SELECT c.`name` AS name_compagny, p.certificate AS certificate, p.`name` AS pilot_name
FROM compagnies AS c
RIGHT OUTER JOIN pilots AS p
ON c.comp = p.compagny;