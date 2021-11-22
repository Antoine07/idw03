
-- création de la clé étrangère
ALTER TABLE pilots 
ADD CONSTRAINT fk_pilots_compagny_compagnies_comp 
FOREIGN KEY (compagny) 
REFERENCES compagnies(`comp`);

-- suppression de la clé étrangère
ALTER TABLE pilots DROP FOREIGN KEY fk_pilots_compagny_compagnies_comp;

-- suppression de la KEY (nommé)
ALTER TABLE pilots KEY fk_pilots_compagny_compagnies_comp;