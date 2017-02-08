/*
	


*/




CREATE TABLE Account(
	user_id INT NOT NULL,
	role varchar(45) NOT NULL,
	PRIMARY KEY (user_id)
 );


CREATE TABLE Song(
	title varchar(45) NOT NULL,
	genre varchar(45) NOT NULL,
	song_id INT NOT NULL,
	date_released DATE NOT NULL
	PRIMARY KEY (song_id)
);

CREATE TABLE Artist(
	artist_name VARCHAR(45) NOT NULL,
	artist_id INT NOT NULL,
	album_or_single VARCHAR(45) NOT NULL,
	average_rating DOUBLE PRECISION NOT NULL
);


/* Relationships */

CREATE TABLE Gives(
	date_published DATE NOT NULL,
	review_id BIGINT NOT NULL,
	rating INT NOT NULL,
	subject VARCHAR(45) NOT NULL
	PRIMARY KEY 
);



