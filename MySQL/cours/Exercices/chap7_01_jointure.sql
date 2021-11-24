

ALTER TABLE pilots
DROP FOREIGN KEY `fk_pilots_compagny_compagnies_comp`;

ALTER TABLE pilots
DROP KEY `fk_pilots_compagny_compagnies_comp`;

ALTER TABLE pilots
ADD CONSTRAINT `fk_pilots_compagny_compagnies_comp` 
FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`)
ON DELETE SET NULL;

-- faire une sauve garde juste de la ligne de la compagnie que l'on va supprimer

CREATE TABLE `new_compagnies` (SELECT * FROM `compagnies` WHERE comp='AUS');

-- met NULL dans la table pilots
DELETE FROM compagnies WHERE comp='AUS';

INSERT INTO
compagnies (
    `comp`, `street`, `city`, `name`, `numStreet`, `status`
) SELECT * FROM `new_compagnies`;

UPDATE pilots
SET compagny='AUS'
WHERE compagny IS NULL ;