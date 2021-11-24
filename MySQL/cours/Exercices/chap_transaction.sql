/*
START TRANSACTION permet de faire du SQL en mode transactionnel équivalent à set autocommit = 0;

Dès que MySQL exécute la commande ROLLBACK ou COMMIT il se remet en autocommit = 1 ;

*/

START TRANSACTION;
SELECT @A:=SUM(numFlying) FROM pilots;
UPDATE pilots SET numFlying=@A ;
SELECT `name`, numFlying
FROM pilots;
ROLLBACK;