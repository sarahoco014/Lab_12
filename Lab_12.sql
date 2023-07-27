DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS staffs;
DROP TABLE IF EXISTS enclosures;

CREATE TABLE enclosures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(155),
    capacity INT,
    closedForMaintenance BOOLEAN
); 

CREATE TABLE staffs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(155),
    employeeNumber INT
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(154),
    type VARCHAR(154),
    age INT,
    enclosure_id INT REFERENCES enclosures(id)
);

CREATE TABLE assignments (
    id SERIAL PRIMARY KEY,
    employeeId INT REFERENCES staffs(id),
    enclosure_id INT REFERENCES enclosures(id),
    day VARCHAR(155)
);

INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Lion Den', 5, false); -- 1
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Monkey Gym', 15, true); -- 2
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Penguin Cave', 30, false); -- 3
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Bear Cave', 3, false); -- 4
INSERT INTO enclosures (name, capacity, closedForMaintenance) VALUES ('Giraffe Park', 30, false); -- 5


INSERT INTO staffs (name, employeeNumber) VALUES ('Bob', 12345); -- 1
INSERT INTO staffs (name, employeeNumber) VALUES ('Jim', 67890); -- 2
INSERT INTO staffs (name, employeeNumber) VALUES ('Barbara', 34567); -- 3
INSERT INTO staffs (name, employeeNumber) VALUES ('Karen', 45678); -- 4
INSERT INTO staffs (name, employeeNumber) VALUES ('Debs', 23456); -- 5

INSERT INTO animals (name, type, age, enclosure_id) VALUES ('John', 'Lion', 27, 1);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Elvis', 'Monkey', 11, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Legionus', 'Monkey', 15, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Greg', 'Penguin', 7, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Slippy', 'Penguin', 8, 3);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Gloria', 'Bear', 23, 4);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Melman', 'Monkey', 10, 2);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Dave', 'Bear', 20, 4);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Tony', 'Giraffe', 43, 5);
INSERT INTO animals (name, type, age, enclosure_id) VALUES ('Margaret', 'Lion', 13, 1);

INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (1, 4, 'Thursday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (2, 3, 'Wednesday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (4, 1, 'Monday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (5, 2, 'Saturday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (4, 5, 'Tuesday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (3, 3, 'Thursday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (5, 2, 'Friday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (1, 4, 'Monday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (2, 1, 'Tuesday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (3, 4, 'Monday');
INSERT INTO assignments (employeeId, enclosure_id, day) VALUES (1, 5, 'Friday');

SELECT name FROM animals
WHERE enclosure_id = 1;

SELECT staffs.name FROM staffs
INNER JOIN assignments
ON staffs.id = assignments.employeeId
INNER JOIN enclosures
ON assignments.enclosure_id = enclosures.id
WHERE enclosures.name = 'Lion Den';

SELECT staffs.name FROM staffs
INNER JOIN assignments
ON staffs.id = assignments.employeeId
INNER JOIN enclosures
ON assignments.enclosure_id = enclosures.id
WHERE enclosures.closedForMaintenance = true;

SELECT enclosures.name FROM animals
INNER JOIN enclosures
ON animals.enclosure_id = enclosures.id
ORDER BY animals.age DESC LIMIT 1;

SELECT staffs.name, COUNT(DISTINCT animals.type) FROM animals
INNER JOIN enclosures
ON animals.enclosure_id = enclosures.id
INNER JOIN assignments
ON assignments.enclosure_id = enclosures.id
INNER JOIN staffs
ON staffs.id = assignments.employeeId
WHERE staffs.name = 'Bob'
GROUP BY staffs.name;

SELECT COUNT(DISTINCT staffs.name) FROM staffs
INNER JOIN assignments
ON staffs.id = assignments.employeeId
INNER JOIN enclosures
ON enclosures.id = assignments.enclosure_id
WHERE enclosures.name = 'Lion Den';

SELECT animals.name FROM animals
INNER JOIN enclosures
ON animals.enclosure_id = enclosures.id
WHERE animals.name != 'John' AND enclosures.name = 'Lion Den';