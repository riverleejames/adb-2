MATCH (actor1:Actor {name: 'Ashley Judd'})
	MATCH (actor2:Actor {name: 'Ava Gardner'})
	OPTIONAL MATCH path = shortestPath((actor1)-[:ACTED_IN*]-(actor2))
	RETURN path