DROP  DATABASE myJoinsDB;
CREATE DATABASE myJoinsDB;

USE myJoinsDB;

CREATE TABLE person
(
id int auto_increment NOT NULL PRIMARY KEY,
name varchar(60) NOT NULL,
phone varchar(12) NOT NULL
);

CREATE TABLE salary
(
id int auto_increment NOT NULL PRIMARY KEY,
salary float(10,2) NOT NULL,
position varchar(40) NOT NULL
);

CREATE TABLE personalData
(
id int auto_increment NOT NULL PRIMARY KEY,
familyStatus varchar(30) NOT NULL,
birthday date NOT NULL,
adress varchar(50) NOT NULL
);

INSERT INTO person
(name, phone)
VALUES
('Anton Pavlov','(060)7142212'),
('Mary Cure','(067)4302001'),
('Jack Sparrow','(050)6202990'),
('Dave Johns','(068)7181236'),
('Jane Ostin','(050)2133217');

INSERT INTO salary
(salary, position)
VALUES
(350.20, 'worker'),
(500.50, 'worker'),
(690.25, 'Manager'),
(800.50, 'Manager'),
(2300.50, 'Director');

INSERT INTO personalData
(familyStatus, birthday, adress)
VALUES
('Single', '1994-02-13', 'Adler st, 14'),
('Divorced', '1990-12-09', 'Broken st, 56'),
('Married', '1991-03-12', 'Gray st, 101'),
('Divorced', '1986-06-23', 'Sample st, 99'),
('Married', '1984-01-29', 'Kane st, 19');

SELECT * FROM person;
SELECT * FROM salary;
SELECT * FROM personalData;

SELECT name, phone, adress FROM person
INNER JOIN
personalData
ON person.id = personalData.id;

-- SUBQUERY STATEMENTS -- 
SELECT phone,(SELECT adress FROM personalData WHERE personalData.id = person.id) as adress
FROM person;

SELECT name, birthday, phone FROM personalData
INNER JOIN
person
ON personalData.id = person.id
WHERE personalData.familyStatus = 'Divorced';


-- SUBQUERY STATEMENTS -- 
SELECT birthday, (SELECT phone FROM person WHERE person.id = personalData.id) as phone
FROM personalData
WHERE personalData.familyStatus = 'Divorced';


SELECT name, birthday, phone FROM salary
INNER JOIN
personalData
ON salary.id = personalData.id
INNER JOIN
person
ON salary.id = person.id
WHERE salary.position = 'Manager';


-- SUBQUERY STATEMENTS -- 
SELECT
(SELECT phone FROM person WHERE person.id = salary.id) as phone,
(SELECT birthday FROM personalData WHERE personalData.id = salary.id) as birthday
FROM salary
WHERE salary.position = 'Manager';


