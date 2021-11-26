
-- ex1

ALTER TABLE `pilots` ADD COLUMN `salary` DECIMAL(2,1) AFTER `name`;

ALTER TABLE `pilots` MODIFY COLUMN `salary` DECIMAL(5,1) AFTER `name`;

UPDATE pilots
SET salary = 2000
WHERE name IN ('Alan', 'Sophie', 'Benoit', 'Albert');


UPDATE pilots
SET salary = 1500
WHERE name IN ('Tom', 'Yi',  'Yan');

UPDATE pilots
SET salary = 3000
WHERE name IN ('Jhon', 'Pierre');


/*
## Exercices

1. Quel est le salaire moyen.
*/
SELECT AVG(salary) as middle_salary FROM pilots;

/*
2. Calculez le salaire moyen par compagnie.
*/

SELECT compagny, AVG(salary) as middle_salary FROM pilots GROUP BY compagny;

/*
3. Quels sont les pilots qui sont au-dessus du salaire moyen.
*/

SELECT name, salary FROM pilots
WHERE salary > (
    SELECT AVG(salary) FROM pilots
);

/*
4. Calculez l'étendu des salaires.
*/

SELECT MAX(salary) - MIN(salary) FROM pilots ;

/*
5. Quels sont les noms des compagnies qui payent 
leurs pilotes au-dessus de la moyenne ?
*/

SELECT name FROM compagnies WHERE comp IN (
    SELECT compagny FROM pilots
        WHERE salary > (
            SELECT AVG(salary)  FROM pilots
        )
);

/*
6. Quels sont les pilotes qui par compagnie dépasse(nt) le salaire moyen ?
*/

SELECT compagny, name, AVG(salary) as avgSalary 
FROM pilots 
GROUP BY compagny, name
HAVING AVG(salary) > (SELECT AVG(salary)  FROM pilots);

# Ex2

/*
1. Faites une requête qui dimunue de 40% le salaire des pilotes de la compagnie AUS.
*/

UPDATE pilots
SET salary = salary*.6
WHERE compagny='AUS';

SELECT name, compagny 
FROM pilots
WHERE salary  < ALL (
    SELECT salary FROM pilots
    WHERE compagny <> 'AUS'
);

# Recherche

-- Mettre à jour les données suivantes :

UPDATE pilots 
SET plane='A320' 
WHERE name='Alan';

SELECT DISTINCT plane 
FROM pilots 
WHERE compagny='AUS' AND plane IN (
    SELECT DISTINCT plane FROM pilots WHERE compagny='FRE1' 
);

// UNION 
SELECT 
plane
FROM pilots
WHERE compagny="AUS"
UNION 
SELECT 
plane
FROM pilots
WHERE compagny="FRE1";