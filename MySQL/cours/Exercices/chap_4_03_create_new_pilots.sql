
-- creer une table à partir d'une table existante

CREATE TABLE `new_pilots` (SELECT * FROM `pilots`);

-- On insert les données dans la table existantes

-- attention il faut respecter l'ordre des colonnes pour la mise à jour
INSERT INTO
pilots (
    `certificate`,
    `numFlying`,
    `compagny`,
    `name`,
    `num_jobs`,
    `next_flight`,
    `birth_date`,
    `created`
) SELECT * FROM `new_pilots`;


DROP TABLE `new_pilots`;