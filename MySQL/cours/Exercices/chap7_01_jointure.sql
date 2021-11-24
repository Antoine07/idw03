

ALTER TABLE pilots
DROP FOREIGN KEY `fk_pilots_compagny_compagnies_comp`;

ALTER TABLE pilots
DROP KEY `fk_pilots_compagny_compagnies_comp`;

ALTER TABLE pilots
ADD CONSTRAINT `fk_pilots_compagny_compagnies_comp` 
FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`)
ON DELETE SET NULL;

set autocommit = 0;

-- met NULL dans la table pilots
DELETE FROM compagnies WHERE comp='AUS';

-- vérifiez que les tables ont été mis à jour

SELECT * FROM pilots;
SELECT * FROM compagnies;

-- on remet la base de données dans son état initial, si on veut vraiment modifier les tables tapez COMMIT;
ROLLBACK;

set autocommit = 1;
