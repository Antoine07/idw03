# CLEF PRIMAIRE et étrangère

**PRIMARY KEY** clef primaire, elle peut être composite (plusieurs nom de colonnes) <=> UNIQUE NOT NULL INDEX
Rappelons qu'un INDEX est une structure supplémentaire créé par MySQL pour garder l'ordre des colonnes indexées.

**FOREIGN KEY** clef étrangère (éventuellement composite) elle se réfère à un INDEX ou clef primaire. Attention, on doit utiliser le moteur **InnoDB**, MyISAM n'est pas relationnel (pas de clef étrangère).

Elle permet de ne pas insérer de données qui n'auraient pas de sens dans les tables. **Elle permet l'intégrité des données**.

Pour créer une clef étrangère on doit :

- Choisir la ou les colonnes FOREIGN KEY

- Choisir dans l'autre table la ou les colonnes qui va/vont servir de référence(s), REFRENCES.
La clef étrangère ne peut s'ajouter dans la description d'une colonne, on met sa définition en général en dessous de la clef primaire.

## Contraintes à connaître sur les tables

La table pilots est physiquement relié à la table compagnies.

- Les contraintes sont les suivantes :

1. Vous ne pouvez pas ajouter ou modifier une ligne dans la table pilots dont la compagnie n'existe pas dans la table compagnies.

2. Vous ne pouvez pas supprimer ou modifier une compagnie qui aurait des/une référence(s) dans la table pilots.

```sql
CREATE TABLE `pilots` (
  `certificate` varchar(6) NOT NULL,
  `numFlying` decimal(7,1),
  `compagny` char(4),
  `name` varchar(20) NOT NULL,
  `plane` char(5),
  `bonus` decimal(5,1),
  `num_jobs` tinyint(3) unsigned,
  `next_flight` datetime,
  `birth_date` datetime,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`certificate`),
  UNIQUE KEY `un_name` (`name`),
  KEY `fk_pilots_compagny` (`compagny`),
  CONSTRAINT `fk_pilots_compagny` FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
```

Table compagnies :

```sql
CREATE TABLE `compagnies` (
  `comp` char(4) NOT NULL,
  `street` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `numStreet` tinyint(3) unsigned DEFAULT NULL,
  `status` enum('published','unpublished','draft') DEFAULT 'draft',
  PRIMARY KEY (`comp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## Options des clefs étrangères

On a deux types : DELETE et UPDATE.

ON DELETE [RESTRICT| NO ACTION | SET NULL | CASCADE ] permet de déterminer le comportement de MySQL en cas de suppression d'une référence.

ON UPDATE [RESTRICT| NO ACTION | SET NULL | CASCADE ] permet de déterminer le comportement de MySQL en cas de modification d'une référence.

ON DELETE RESTRICT et NO ACTION comportement par défaut, ces deux options on le même effet dans MySQL uniquement mais pas dans les autres SGDB.

ON DELETE SET NULL dans ce cas NULL est substitué aux valeurs dont la référence est supprimée.

```sql 
ALTER TABLE pilots
ADD CONSTRAINT `fk_pilots_compagny` 
FOREIGN KEY (`compagny`) REFERENCES `compagnies` (`comp`)
ON DELETE SET NULL;

-- la suppression de la compagnie AUS => le champ compagny dans la table pilots aura la valeur NULL pour tous les pilotes de cette compagnie
DELETE FROM compagnies WHERE comp='AUS'; 
```

Exemple : si on a ON DELETE SET NULL sur la clef étrangère de la table pilots, et si on supprime une compagnie alors les pilotes qui avaient cette référence (comp de la table compagnies supprimé) ne sont pas supprimés et la valeur NULL est mise à la place de l'identifiant de la table compagnies dans la table pilots.

ON DELETE CASCADE comportement plus risqué, plus voilent ! Elle supprime toutes les lignes. Par exemple si on supprime une compagnie dans la table compagnies reliée à la table pilots (c'est dans cette table que l'on a la clef étrangère) alors tous les pilotes référencés seront également supprimés.

Moins utiliser
UPDATE RESTRICT et NO ACTION : empêche la modification si elle casse la contrainte (comportement par défaut).

SET NULL : met NULL partout où la valeur modifiée était référencée.
CASCADE : modifie également la valeur là où elle est référencée.

## 01 Exercice

Modifiez la clé étrangère dans la table pilots afin que celle-ci possède l'option ON DELETE SET NULL.

Supprimez la compagnie AUS, vérifiez que les pilotes de cette compagnie n'ont plus la référence AUS dans la table pilots.

Puis remettez cette référence en place.

Indication faite une sauvegarde de votre base de données au préalable

```bash
mysqldump -u root -p --databases db_aviation > dump_db_aviation.sql

# pour remettre la base de données 
mysql -u root -p --databases db_aviation < dump_db_aviation.sql
```

Vous pouvez utiliser le moteur InnoDB de MySQL qui est en mode transactionnel et utiliser le mode autocommit=0 pour valider l'ensemble de vos requêtes en une fois avec un COMMIT ou revenir en arrière avec ROLLBACK.

```sql
set autocommit= 0;

-- faire vos requêtes 

-- vérifiez que les commandes SQL INSERT, DELETE ou UPDATE ont bien produit l'effet souhaité. Puis faite un ROLLBACK pour remettre la base de données dans son état précédent. N'oubliez pas de remettre autocommit=1, comportement par défaut du moteur InnoDB.
```
