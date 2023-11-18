//Friendship Relationships

// Establish Joe's friendships
MATCH (joe:Person {name: 'Joe'})
MATCH (jill:Person {name: 'Jill'})
MERGE (joe)-[:FRIENDS_WITH]->(jill);

MATCH (joe:Person {name: 'Joe'})
MATCH (jack:Person {name: 'Jack'})
MERGE (joe)-[:FRIENDS_WITH]->(jack);

// Establish Jill's friendships
MATCH (jill:Person {name: 'Jill'})
MATCH (jane:Person {name: 'Jane'})
MERGE (jill)-[:FRIENDS_WITH]->(jane);

// Establish Jack's friendships
MATCH (jack:Person {name: 'Jack'})
MATCH (janice:Person {name: 'Janice'})
MERGE (jack)-[:FRIENDS_WITH]->(janice);