/*
	


*/




CREATE TABLE Account(
	user_id INT NOT NULL,
	role varchar(45) NOT NULL,
	PRIMARY KEY (user_id)
 );








/* Relationships*/
CREATE TABLE Gives(
	date_published DATE NOT NULL,
	review_id BIGINT NOT NULL,
	rating INT NOT NULL,
	subject VARCHAR(45) NOT NULL
	PRIMARY KEY 
);




