# QCM

## Qestion 01

Quel moteur devez-vous définir pour avoir une base de données relationelles

Répondez en choisissant une seule et bonne réponse ci-dessous.

[X] InnoDB 

[ ] MyISAM

[ ] MEMORY

[ ] ARCHIVE

## Qestion 02

A quel(s) type(s) l'option UNSIGNED s'applique-t-il en MySQL ?

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Il s'applique aux types CHAR et VARCHAR

[ ] Il s'applique au type BLOB

[X] Il s'applique aux types INT

## Question 03

Donnez la définition de l'acronyme suivant DQL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Quest Language

[X] Data Query Language

[ ] Dump Query Language

## Question 04

Donnez la définition de l'acronyme suivant DML

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Mapping Language

[ ] Data More Language

[X] Data Manipulation Language

## Question 05

Donnez la définition de l'acronyme suivant DDL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Dump Language

[ ] Data Drive Language

[X] Data Definition Language

## Question 06

Donnez la définition de l'acronyme suivant DCL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Cost Language

[X] Data Control Language

[ ] Data C Language

## Question 07

Que fait la requête suivante ?

```sql
SELECT 
ROUND(num_jobs / (SELECT SUM(num_jobs) from pilots), 2 )*100 as per_job 
FROM pilots 
WHERE num_jobs IS NOT NULL;
```

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] La somme du nombre d'heures de vol faite par les pilotes.

[ ] La pourcentage total du nombre d'heures de vol faite par les pilotes.

[X] La pourcentage du nombre d'heures de vol par pilote.

## Question 08

Que fait la requête suivante ?

```sql
set autocommit = 0;
SELECT @A:=SUM(numFlying) FROM pilots;
UPDATE pilots SET numFlying=@A ;
ROLLBACK;
```

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Il met à jour la table pilote de manière effective, car autocommit est désactivé.

[X] Il ne met pas à jour la table pilote de manière effective, car autocommit est désactivé.

[ ] Il lève une erreur car autocommit vaut 0.

## Question 09

Que fait la requête suivante ?

```sql
SELECT COUNT(*) as nb_compagny
FROM compagnies
WHERE comp IN (
    SELECT compagny
    FROM pilots
    GROUP BY compagny
    HAVING  SUM(numFlying) < 200 
);
```

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Le nombre total de compagnie.

[ ] Nombre de compagnie(s) dont le nombre d'heures de vol est différent de 0.

[X] Nombre de compagnie(s) dont le nombre d'heures de vol est de moins de 200 heures.


## Question 10

Que fait la requête suivante ?

```sql
SELECT c.`name` AS name_compagny, p.certificate AS certificate, p.`name` AS pilot_name
FROM compagnies AS c
LEFT OUTER JOIN pilots AS p
ON c.comp = p.compagny
UNION
SELECT c.`name` AS name_compagny, p.certificate AS certificate, p.`name` AS pilot_name
FROM compagnies AS c
RIGHT OUTER JOIN pilots AS p
ON c.comp = p.compagny;
```

Répondez en choisissant une seule et bonne réponse ci-dessous.

[X] Sélectionne les compagnies et leurs pilotes incluant les compagnies n'ayant pas de pilote et les pilotes n'ayant pas de compagnie.

[ ] Sélectionne les compagnies et leurs pilotes n'incluant pas les compagnies n'ayant pas de pilote et les pilotes n'ayant pas de compagnie.

[ ] Sélectionne les compagnies et leurs pilotes uniquement les compagnie ayant des pilotes.
