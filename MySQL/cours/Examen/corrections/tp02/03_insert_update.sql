
/*
Vous trouverez ci-dessous les commandes SQL
permettant de mettre à jour et insérer des enregistrements 
dans la table pilots avec la nouvelle clé plane_id.
*/

INSERT INTO `planes`
 (`name`, `description`, `numFlying`)
VALUES
('A320', 'Avion de ligne quadriréacteur', 17000.0),
('A340', 'Moyen courier', 50000.0),
('A380', 'Gros porteur', 12000.0);

UPDATE `pilots`
SET `plane_id` = 1
WHERE `plane` = 'A320';

UPDATE `pilots`
SET `plane_id` = 2
WHERE `plane` = 'A340';

UPDATE `pilots`
SET `plane_id` = 3
WHERE `plane` = 'A380';