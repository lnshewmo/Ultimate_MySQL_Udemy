-- SOLUTIONS FOR INSTAGRAM CHALLENGE
use ig_clone_data;

SET @old_sql_mode=@@sql_mode;
SET @@sql_mode= REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY,',"");

-- find the oldest 5 users
SELECT * FROM users
ORDER BY created_at ASC LIMIT 5;

-- what day of the week do most users register on
SELECT
	    DAYNAME(created_at) AS day,
        COUNT(*) AS total
FROM users
GROUP BY day 
ORDER BY total DESC;

-- find users who never posted a photo
SELECT * FROM photos;

SELECT username FROM users
LEFT JOIN photos	-- left join returns full user list and corresponding data from photos table
	ON users.id = photos.user_id
WHERE photos.image_url IS NULL;  -- could use any of the photos.columns which have nulls

-- find photo with most likes and user
SELECT * FROM likes;

SELECT 
	username,
   	photos.id, 
    photos.image_url, 
    COUNT(*) as total 
FROM photos
INNER JOIN likes 
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- how many times does the average user post?  calculate avg number of photos per user
SELECT 
	(SELECT COUNT(*) from photos) / 
    (SELECT COUNT(*) FROM users) AS avg;
    
-- what are the most popular hashtags
SELECT * from tags;

SELECT tags.tag_name, COUNT(*) AS total 
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC LIMIT 8;