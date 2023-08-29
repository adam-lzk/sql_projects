DROP TABLE category;
DROP TABLE post;

-- Create

CREATE TABLE category (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title CHAR(50) NOT NULL
);



CREATE TABLE post (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	content CHAR(255) NOT NULL,
	category_id INT REFERENCES categories(id)
);



-- Insert

INSERT INTO category (title) VALUES ('Sport');
INSERT INTO category (title) VALUES ('Travelling');
INSERT INTO category (title) VALUES ('Cooking');



INSERT INTO post (content, category_id) VALUES ('text text text text', 1);
INSERT INTO post (content, category_id) VALUES ('text text text', 2);
INSERT INTO post (content, category_id) VALUES ('text text text text', 2);
INSERT INTO post (content, category_id) VALUES ('text text text text text', 3);



-- Select

SELECT * FROM category;
SELECT * FROM post;
SELECT post.*, category.title FROM post INNER JOIN category ON post.category_id = category.id;
