CREATE TABLE Persons (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Friendships (
    friendship_id SERIAL PRIMARY KEY,
    person1_id INT REFERENCES Persons(person_id),
    person2_id INT REFERENCES Persons(person_id),
    UNIQUE (person1_id, person2_id)
);

CREATE TABLE Likes (
    like_id SERIAL PRIMARY KEY,
    person_id INT REFERENCES Persons(person_id),
    movie_id INT, -- Assuming a Movies table exists with movie_id as a key
    rating INT CHECK (rating >= 1 AND rating <= 5)
);
