-- Instragram Database Clone Project
DROP DATABASE instagram;
CREATE DATABASE instagram;
USE instagram;
SELECT database();

CREATE TABLE users (
	user_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
    
DESCRIBE users; 

CREATE TABLE photos (
	photo_id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR (250) NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
    
DESCRIBE photos;
    
 SELECT * FROM photos
 JOIN users
	ON photos.user_id = users.user_id;

CREATE TABLE comments(
	comment_id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(250) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL, 
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (photo_id) REFERENCES photos(photo_id)
);

DESCRIBE comments;
    
CREATE TABLE likes (
	-- likes_id INT NOT NULL,   not needed
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (photo_id) REFERENCES photos(photo_id),
    PRIMARY KEY (user_id, photo_id)   -- PRIMARY KEY CONSTRAINT: a user can only like a photo once, this ensures the combination is unique (prevents duplication) 
);

DESCRIBE likes;
    
CREATE TABLE follows (
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (followee_id) REFERENCES users(user_id),
    PRIMARY KEY (follower_id, followee_id)  -- PRIMARY KEY CONSTRAINT: maintains the follower/ee relationship 
);

DESCRIBE follows;

-- HASHTAGS: a photo can have multiple #s, how should this be stored (single vs multiple tables)
-- considerations: speed of inserting/looking up, deletion of tags
-- https://stackoverflow.com/questions/20856/recommended-sql-database-design-for-tags-or-tagging

CREATE TABLE tags (
	tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR (255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY(photo_id) REFERENCES photos(photo_id),
    FOREIGN KEY(tag_id) REFERENCES tags(tag_id),
    PRIMARY KEY(photo_id, tag_id)  -- PRIMARY KEY CONSTRAINT: prevents duplication of this combination
);

SHOW TABLES;


    

	
    
    