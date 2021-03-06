# DQL

## Fonctions de groupe

Elles s'utilisent dans la clause SELECT sur une/des colonnes, elles permettent de regrouper des données. Si vous utilisez les fonctions de groupement avec une requête ne contenant pas de clause GROUP BY, cela revient à grouper toutes les lignes.
```text
AVG([DISTINCT] exp)              moyenne
COUNT({*| DISTINCT] expr})       nombre de lignes
MAX([DISTINCT] exp)              max
MIN([DISTINCT] exp)              min
SUM([DISTINCT] exp)              somme
GROUP_CONCAT(exp)                composition d'un nombre de valeurs, concaténation de valeurs de champ a, b, c, d
VARIANCE(exp)                    variance
STDDEV(exp)                       écart type
```
## Groupement de lignes

```sql
SELECT col1 [,col2, ...], fonction_groupe
FROM table
WHERE (condition).  # s'applique à toutes les lignes
GROUP BY clo1 [, col2, ...]
HAVING condition # s'applique au groupement
ORDER BY col1 [ASC | DESC] [, col2 ...]
```
SELECT col1 [,col2, ...], fonction_groupe

- La clause WHERE exclue des lignes pour chaque groupement ou permet de rejeter des groupements entiers. Elle s'applique à la totalité de la table.

- La clause GROUP BY liste des colonnes de groupement.

- La clause HAVING permet de poser des conditions sur chaque groupement.

Attention, les colonnes préssentes dans le SELECT doivent apparaître dans le GROUP BY. Seules des fonctions ou expressions peuvent exister en plus dans le SELECT.

##  01 Exercice moyenne des vols

Calculez la moyenne des heures de vols des pilots,
par compagnie.

## 02 Exercice moyenne et bonus

Calculez la moyenne des heures de vols des pilots dont le bonus est de 500,
par compagnie.

## 03 Exercice nombre de pilotes

Sélectionnez les compagnies et leur nombre de pilote(s), ayant plus d'un pilote.

## 04 Exercice ajout d'une colonne & valeurs

*Si vous n'avez pas fait les exercices supplémentaires. Vous devez faire ce qui suit, sinon passer à la suite.*

Ajoutez une colonne plane à la table pilots de type ENUM ayant pour valeurs possibles :
'A380', 'A320', 'A340'.

Et mettez à jour la table avec les contraintes suivantes :

- 'Alan', 'Sophie', 'Albert', 'Benoit' volent sur un A380.

- 'Tom', 'Jhon', 'Pierre' volent sur un A320.

- 'Yan', 'Yin' sur un A340.

## 05 Exercice sélectionner pilotes & compagnies

Sélectionnez le nombre de pilote(s) par compagnie et par type d'avion.

Indication : on peut faire des groupements sur plusieurs colonnes.

## 06 Exercice noms de pilotes

- Sélectionnez le noms des pilotes par bonus.

- Sélectionnez le noms et la compagnie des pilotes par bonus.

## 07 Exercice étendue

Calculez l'étendue du nombre d'heure de vol par compagnie.

Indication : l'étendue est la différence entre MAX et le MIN pour chacune des valeurs. On peut évidement faire ce type de calcul dans la partie SELECT d'une requête SQL.

## 08 Exercice nombre de jours

- Faites la somme du nombre de jours de vols par compagnie dont la somme est supérieur à 30.

## 09 Exercice nombre de compagnies (synthèse avec les précédent cours)

Nombre de compagnie(s) dont le nombre d'heures de vol est de moins de 200 heures.


