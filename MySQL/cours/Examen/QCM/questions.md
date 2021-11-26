# QCM

## Qestion 01

Quel moteur devez-vous définir pour avoir une base de données relationelles

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] InnoDB 

[ ] MyISAM

[ ] MEMORY

[ ] ARCHIVE

## Qestion 02

A quel(s) type(s) l'option UNSIGNED s'applique-t-il en MySQL ?

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Il s'applique aux types CHAR et VARCHAR

[ ] Il s'applique au type BLOB

[ ] Il s'applique aux types INT

## Question 03

Donnez la définition de l'acronyme suivant DQL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Quest Language

[ ] Data Query Language

[ ] Dump Query Language

## Question 04

Donnez la définition de l'acronyme suivant DML

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Mapping Language

[ ] Data More Language

[ ] Data Manipulation Language

## Question 05

Donnez la définition de l'acronyme suivant DDL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Dump Language

[ ] Data Drive Language

[ ] Data Definition Language

## Question 06

Donnez la définition de l'acronyme suivant DCL

Répondez en choisissant une seule et bonne réponse ci-dessous.

[ ] Data Cost Language

[ ] Data Control Language

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

[ ] La pourcentage du nombre d'heures de vol par pilote.

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

[ ] Il ne met pas à jour la table pilote de manière effective, car autocommit est désactivé.

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

[ ] Nombre de compagnie(s) dont le nombre d'heures de vol est de moins de 200 heures.


## Question 10

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

[ ] Nombre de compagnie(s) dont le nombre d'heures de vol est de moins de 200 heures.