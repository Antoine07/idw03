ALTER TABLE compagnies 
ADD status ENUM('published', 'unpublished', 'draft') 
DEFAULT 'draft';