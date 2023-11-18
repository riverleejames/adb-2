MATCH (jack:Person {name: 'Jack'})
OPTIONAL MATCH (movie1:Movie {title: 'Titanic'})
MERGE (jack)-[:LIKES {rating: 3}]->(movie1);

MATCH (jack:Person {name: 'Jack'})
OPTIONAL MATCH (movie2:Movie {title: 'Ghostbusters'})
MERGE (jack)-[:LIKES {rating: 5}]->(movie2);

MATCH (jack:Person {name: 'Jack'})
OPTIONAL MATCH (movie3:Movie {title: 'Sister Act'})
MERGE (jack)-[:LIKES {rating: 4}]->(movie3);

MATCH (jill:Person {name: 'Jill'})
OPTIONAL MATCH (movie2:Movie {title: 'Stargate'})
MERGE (jill)-[:LIKES {rating: 4}]->(movie2);

MATCH (jill:Person {name: 'Jill'})
OPTIONAL MATCH (movie3:Movie {title: 'Star Wars'})
MERGE (jill)-[:LIKES {rating: 5}]->(movie3);
