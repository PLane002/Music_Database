/*Entity Creation*/
CREATE TABLE Acc(

	uid integer		NOT NULL,
	role varchar(50), /*Make sure this is user*/
	primary key(uid)
);

CREATE TABLE Review(

date_pub date,
subj varchar(50), /*1 = song, 0 = Album*/
rating smallint,
revid integer	NOT NULL,

primary key(revid)

);

CREATE TABLE Song(

songid integer	NOT NULL,
title varchar(50)	NOT NULL,
genre varchar(50),


primary key(songid)

);
/*Relationship Table Creation*/

/*Trigger creation*/

