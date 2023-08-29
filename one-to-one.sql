DROP TABLE person;
DROP TABLE passport;



-- Create

CREATE TABLE person (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name CHAR(50) NOT NULL,
	last_name CHAR(50) NOT NULL
);



CREATE TABLE passport (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	passport_number INT NOT NULL,
	city_of_registration CHAR(50) NOT NULL,
	person_id INT REFERENCES users(id) UNIQUE
);



-- Insert

INSERT INTO person (first_name, last_name) VALUES ('A', 'B');
INSERT INTO person (first_name, last_name) VALUES ('C', 'D');
INSERT INTO person (first_name, last_name) VALUES ('E', 'F');
INSERT INTO person (first_name, last_name) VALUES ('G', 'H');



INSERT INTO passport (passport_number, city_of_registration, person_id) VALUES (1111, 'Minsk', 1);
INSERT INTO passport (passport_number, city_of_registration, person_id) VALUES (2222, 'Minsk', 2);
INSERT INTO passport (passport_number, city_of_registration, person_id) VALUES (3333, 'Minsk', 3);
INSERT INTO passport (passport_number, city_of_registration, person_id) VALUES (4444, 'Minsk', 4);



-- Select

SELECT * FROM person;
SELECT id, first_name FROM person;

SELECT * FROM passport;
SELECT passport_number FROM passport;

SELECT person.first_name, passport.passport_number FROM person, passport
WHERE person.id=passport.person_id;
