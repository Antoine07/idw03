/*

Correction du TP

*/

-- Définition de la table planes, 
-- ici on utilisera une clé numérique auto incrémenté, vous pouvez également préciser que c'est un entier strictement > 0

CREATE TABLE `planes` (
    `id` INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` CHAR(5) NOT NULL,
    `description` TEXT,
    `numFlying` DECIMAL(8,1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertion multiple

INSERT INTO `planes` (`name`, `description`, `numFlying`)
VALUES 
('A380', 'Gros porteur', 12000.0),
('A320', 'Avion de ligne quadriréacteur', 17000.0),
('A340', 'moyen courrier', 50000.0);

-- supprimer et sauvegarder le

ALTER TABLE `pilots`
DROP COLUMN `plane`;

ALTER TABLE `pilots`
ADD COLUMN `plane_id` INT UNSIGNED DEFAULT NULL;

ALTER TABLE `pilots`
ADD CONSTRAINT `fk_pilots_planes`
FOREIGN KEY (`plane_id`) REFERENCES `planes`(`id`);

-- Insertion des données dans la table planes

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

-- puis supprimer la colonne plane de la table pilots

ALTER TABLE `pilots`
DROP COLUMN `plane`;

-- Redéfinition de la contrainte sur la suppression

ALTER TABLE `pilots`
ADD CONSTRAINT `fk_pilots_planes`
FOREIGN KEY (`plane_id`) REFERENCES `planes`(`id`)
ON DELETE SET NULL;

-- Sélectionne les colonnes plane de type NULL

UPDATE `pilots`
SET `plane` = 'A320'
WHERE `plane` IS NULL;


-- relation N:N

-- création des tables

CREATE TABLE `trips` (
    `id` INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `depature` VARCHAR(100),
    `arrival` VARCHAR(100),
    `created` DATETIME 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- table de jointure

CREATE TABLE `pilot_trip` (
    `certificate` VARCHAR(6),
    `trip_id` INT UNSIGNED,
    CONSTRAINT un_pilot_trip UNIQUE(`certificate`,`trip_id` ),
    FOREIGN KEY (`trip_id`) REFERENCES `trips`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`certificate`) REFERENCES `pilots`(`certificate`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `trips`
 (`name`, `depature`, `arrival`, `created`)
VALUES
('direct', 'Paris', 'Brest',  '2020-01-01 00:00:00'),
('direct', 'Paris', 'Berlin',  '2020-02-01 00:00:00'),
('direct', 'Paris', 'Barcelone',  '2020-08-01 00:00:00'),
('direct', 'Amsterdan', 'Brest',  '2020-11-11 00:00:00'),
('direct', 'Alger', 'Paris',  '2020-09-01 00:00:00'),
('direct', 'Brest', 'Paris',  '2020-12-01 00:00:00');

INSERT INTO `pilot_trip`
(`certificate`, `trip_id`)
VALUES
('ct-10', 1),
('ct-6', 2),
('ct-100', 1),
('ct-11', 3),
('ct-12', 4),
('ct-10', 4),
('ct-12', 5);

/*
Sélectionnez les trajets de tous les pilotes.
*/

SELECT t.name, t.depature, t.arrival, t.created
FROM trips as t
INNER JOIN pilot_trip as pt
ON pt.trip_id = t.id;

/*
Sélectionnez les trajets des pilotes avec leurs noms et certifications.
*/

SELECT t.name, t.depature, t.arrival, t.created, p.name, p.certificate
FROM trips as t
INNER JOIN pilot_trip as pt
ON pt.trip_id = t.id
INNER JOIN pilots as p
ON p.certificate = pt.certificate;

/*
Quels sont les pilotes qui n'ont pas de trajet ?
*/

SELECT p.name, p.certificate
FROM pilots as p
LEFT OUTER JOIN pilot_trip as pt
ON pt.certificate = p.certificate
WHERE pt.certificate IS NULL;

/*
Sélectionnez les départs des pilotes par certification.
*/

SELECT p.certificate, GROUP_CONCAT(t.depature)
FROM trips as t
INNER JOIN pilot_trip as pt
ON pt.trip_id = t.id
INNER JOIN pilots as p
ON p.certificate = pt.certificate
GROUP BY p.certificate;
