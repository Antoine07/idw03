ALTER TABLE pilots
ADD birth_date DATETIME,
ADD next_flight DATETIME,
ADD num_jobs TINYINT UNSIGNED;

/*

On peut sourcer avec un fichier (*.sql) pour exécuter des commandes SQL

DANS le dossier du fichier SQL  avec le fichier update_pilots.sql
*/

mysql -u root -p --database db_aviation < update_pilots.sql 

-- DANS LA BASE DE DONNEES on peut utiliser la commande SOURCE [PATH/file.sql]

SOURCE update_pilots.sql