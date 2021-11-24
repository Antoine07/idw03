
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