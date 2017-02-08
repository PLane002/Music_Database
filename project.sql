/*
	


*/


DROP database if EXISTS DatabaseProject_Winter2017;
CREATE database DatabaseProject_Winter2017;

USE DatabaseProject_Winter2017;

CREATE TABLE Account(
	user_id INT NOT NULL,
	role varchar(45) NOT NULL,
	PRIMARY KEY(user_id)
 );


CREATE TABLE Song(
	title varchar(45) NOT NULL,
	genre varchar(45) NOT NULL,
	song_id INT NOT NULL,
	date_released DATE NOT NULL,
	PRIMARY KEY(song_id)
);

CREATE TABLE Artist(
	artist_name VARCHAR(45) NOT NULL,
	artist_id INT NOT NULL,
	album_or_single VARCHAR(45) NOT NULL,
	average_rating DOUBLE PRECISION NOT NULL
);

CREATE TABLE Album(
	album_name VARCHAR(45) NOT NULL,
	date_released DATE NOT NULL,
	album_id INT NOT NULL
);


CREATE TABLE Review(
	date_published DATE NOT NULL,
	review_id BIGINT NOT NULL,
	rating INT NOT NULL,
	subject VARCHAR(45) NOT NULL
	
);

/* Relationships */

CREATE 



