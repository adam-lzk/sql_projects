DROP TABLE author;
DROP TABLE book;
DROP TABLE author_book;



-- Create

CREATE TABLE author (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name CHAR(50) NOT NULL
);



CREATE TABLE book (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title CHAR(50) NOT NULL
);



CREATE TABLE author_book (
	author_id INT REFERENCES author(id),
	book_id INT REFERENCES book(id),
	CONSTRAINT id PRIMARY KEY (author_id, book_id)  -- to create an id as unique pairs of values (author_id:book_id)
);



-- Insert

INSERT INTO author (first_name) VALUES ('A');
INSERT INTO author (first_name) VALUES ('B');
INSERT INTO author (first_name) VALUES ('C');



INSERT INTO book (title) VALUES ('title1');
INSERT INTO book (title) VALUES ('title2');
INSERT INTO book (title) VALUES ('title3');
INSERT INTO book (title) VALUES ('title4');



INSERT INTO author_book (author_id, book_id) VALUES (1, 1);
INSERT INTO author_book (author_id, book_id) VALUES (2, 1);
INSERT INTO author_book (author_id, book_id) VALUES (2, 2);
INSERT INTO author_book (author_id, book_id) VALUES (3, 3);
INSERT INTO author_book (author_id, book_id) VALUES (3, 4);



-- Select

SELECT book.id, book.title, author.first_name FROM book LEFT JOIN author_book ON author_book.book_id = book.id LEFT JOIN author ON author_book.author_id = author.id;
