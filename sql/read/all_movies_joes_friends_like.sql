Original Query:
SELECT m.title
FROM Persons joe
JOIN Friendships f ON joe.person_id = f.person1_id OR joe.person_id = f.person2_id
JOIN Persons friend ON friend.person_id = f.person1_id OR friend.person_id = f.person2_id
JOIN Likes l ON friend.person_id = l.person_id
JOIN Movies m ON l.movie_id = m.movie_id
WHERE joe.name = 'Joe' AND friend.name <> 'Joe';


Optimised Query:
SELECT DISTINCT m.title
FROM Persons joe
JOIN Friendships f ON joe.person_id = f.person1_id
JOIN Persons friend ON friend.person_id = f.person2_id
JOIN Likes l ON friend.person_id = l.person_id
JOIN Movies m ON l.movie_id = m.movie_id
WHERE joe.name = 'Joe';

