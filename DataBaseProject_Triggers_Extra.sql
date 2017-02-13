/* TEST MAKING TRIGGERS */

/* DISJOINT ENFORCEMENT */
DELIMITER $$

CREATE TRIGGER Sub_Disjoint
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
	/* Here's the plan: */
	/* Check if SUBJECT is Album */
    /* Check if SIBJECT is Song */
    /* If it's neither of these, send out a 45000 */
    /* Have Rev_Song check if sub_id exists in SONG */
    /* Have Rev_Alb check if sub_id exists in ALBUM */
    /* TODO: Perhaps have the start trigger be outside of the ifs? */
    
    
	/* +++++ ALBUM CHECK +++++ */
	IF (new.subject = "ALBUM") THEN
			INSERT INTO rev_alb(review_id, album_id) VALUES (new.review_id, new.sub_id);
	END IF;
    
    
    
	/* +++++ SONG CHECK +++++ */
	IF (new.subject = "SONG") THEN
		INSERT INTO rev_song(review_id, song_id) VALUES(new.review_id, new.sub_id);
	END IF;
    
    
    
	/* +++++ ERROR CATCHER +++++ */
	IF (new.subject != "SONG" AND new.subject != "ALBUM") THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = "SET REVIEW SUBJECT TO EITHER 'SONG' OR 'ALBUM' AND NOTHING BESIDES.";
	END IF;
    
    /* +++++ CHECK FOR USER +++++ */
    INSERT INTO gives(user_id, review_id) VALUES(new.uid, new.review_id);
    
END
$$

DELIMITER ;



/* REVIEW -> SONG ENFORCEMENT */
DELIMITER $$

CREATE TRIGGER Rev_to_Song
BEFORE INSERT ON rev_song
FOR EACH ROW
	
BEGIN
    /* one review to one song */
    IF new.song_id NOT IN (SELECT song_id from song) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "The Song in this review does not exist.";
    END IF;
    
    IF new.review_id IN (SELECT review_id FROM rev_song) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Cannot have 2 reviews with same ID.";
    END IF;
END
$$

DELIMITER ;



/* REVIEW -> ALBUM ENFORCEMENT */
DELIMITER $$

CREATE TRIGGER Rev_to_Alb
BEFORE INSERT ON rev_alb
FOR EACH ROW
	
BEGIN
    /* one review to one song */
    IF new.album_id NOT IN (SELECT album_id from song) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "The Album in this review does not exist.";
    END IF;
    
    IF new.review_id IN (SELECT review_id FROM rev_alb) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Cannot have 2 reviews with same ID.";
    END IF;
END
$$

DELIMITER ;



/* Account to review. */
DELIMITER $$

CREATE TRIGGER Rev_to_Acc
BEFORE INSERT ON gives
FOR EACH ROW

BEGIN

    IF new.user_id NOT IN (SELECT user_id from account) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "This user does not exist.";
    END IF;
    

END

$$

DELIMITER ;



/* DUBIOUS. MUST DISCUSS. */
/*
DELIMITER $$

CREATE TRIGGER Album_Enforce
BEFORE INSERT ON album
FOR EACH ROW

BEGIN

    IF NOT EXISTS(SELECT album_id FROM in_ WHERE in_.album_id = new.album_id) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Songs must be assigned to an Album id BEFORE that album is created.";
    END IF;
    

END

$$

DELIMITER ;
*/



DELIMITER $$

CREATE TRIGGER Song_Enforce
BEFORE INSERT ON song
FOR EACH ROW

BEGIN

	/* Build Artist to Song Table */
	INSERT INTO by_(artist_id, song_id) VALUES(new.artist_id, new.song_id);
    
    /* Build Song to Album Table */
    IF EXISTS(SELECT album_id FROM new) THEN
		INSERT INTO in_(song_id, album_id) VALUES(new.song_id, new.album_id);
        
        /* Kill two birds with one stone. This builds the from_ table. */
        IF NOT EXISTS(SELECT artist_id, album_id FROM from_ WHERE from_.artist_id = new.artist_id AND from_.album_id = new.album_id) THEN
			INSERT INTO from_(album_id, artist_id) VALUES(new.album_id, new.artsit_id);
		END IF;
        /* Killed two birds with one stone */
        
    END IF;

END

$$

DELIMITER ;
