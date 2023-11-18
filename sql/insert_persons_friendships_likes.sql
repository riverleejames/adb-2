INSERT INTO Persons (name) VALUES 
('Joe'), 
('Jack'), 
('John'), 
('Jill'), 
('Jane'), 
('Janice');


INSERT INTO Friendships (person1_id, person2_id) VALUES
((SELECT person_id FROM Persons WHERE name = 'Joe'), (SELECT person_id FROM Persons WHERE name = 'Jill')),
((SELECT person_id FROM Persons WHERE name = 'Jill'), (SELECT person_id FROM Persons WHERE name = 'Jane')),
((SELECT person_id FROM Persons WHERE name = 'Joe'), (SELECT person_id FROM Persons WHERE name = 'Jack')),
((SELECT person_id FROM Persons WHERE name = 'Jack'), (SELECT person_id FROM Persons WHERE name = 'Janice'));

-- Insert Like for Jack and Titanic
INSERT INTO Likes (person_id, movie_id, rating)
SELECT 
    (SELECT person_id FROM Persons WHERE name = 'Jack'),
    (SELECT movie_id FROM Movies WHERE title = 'Titanic'),
    3;

-- Insert Like for Jack and Ghostbusters
INSERT INTO Likes (person_id, movie_id, rating)
SELECT 
    (SELECT person_id FROM Persons WHERE name = 'Jack'),
    (SELECT movie_id FROM Movies WHERE title = 'Ghostbusters'),
    5;

-- Insert Like for Jack and Sister Act
INSERT INTO Likes (person_id, movie_id, rating)
SELECT 
    (SELECT person_id FROM Persons WHERE name = 'Jack'),
    (SELECT movie_id FROM Movies WHERE title = 'Sister Act'),
    4;

-- Insert Like for Jill and Stargate
INSERT INTO Likes (person_id, movie_id, rating)
SELECT 
    (SELECT person_id FROM Persons WHERE name = 'Jill'),
    (SELECT movie_id FROM Movies WHERE title = 'Stargate'),
    4;

-- Insert Like for Jill and Star Wars
INSERT INTO Likes (person_id, movie_id, rating)
SELECT 
    (SELECT person_id FROM Persons WHERE name = 'Jill'),
    (SELECT movie_id FROM Movies WHERE title = 'Star Wars'),
    5;
