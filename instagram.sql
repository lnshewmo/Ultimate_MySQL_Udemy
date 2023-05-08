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
    
CREATE TABLE likes (
	likes_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_ID) REFERENCES users(user_id),
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    -- ensures combination of these 2 is unique
    PRIMARY KEY (user_id, photo_id)
);
    
CREATE TABLE follows (
	follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(), 
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (followee_id) REFERENCES users(user_id),
    -- this primary key maintains a follower/ee relationship (you can only follow someone once)
    PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags (
	id
    
    