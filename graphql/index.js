import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { Neo4jGraphQL } from "@neo4j/graphql";
import neo4j from "neo4j-driver";

const typeDefs = `
  type Actor {
    actedInMovies: [Movie!]! @relationship(type: "ACTED_IN", direction: OUT)
    actor_id: BigInt!
    name: String!
  }
  
  type Genre {
    moviesInGenre: [Movie!]! @relationship(type: "IN_GENRE", direction: IN)
    name: String!
    position: BigInt!
  }
  
  interface LikesProperties @relationshipProperties {
    rating: BigInt!
  }
  
  type Movie {
    action: BigInt!
    actorsActedIn: [Actor!]! @relationship(type: "ACTED_IN", direction: IN)
    adventure: BigInt!
    animation: BigInt!
    comedy: BigInt!
    crime: BigInt!
    disaster: BigInt!
    documentary: BigInt!
    drama: BigInt!
    eastern: BigInt!
    fantasy: BigInt!
    history: BigInt!
    horror: BigInt!
    inGenreGenres: [Genre!]! @relationship(type: "IN_GENRE", direction: OUT)
    movie_id: BigInt!
    musical: BigInt!
    peopleLikes: [Person!]! @relationship(type: "LIKES", direction: IN, properties: "LikesProperties")
    romance: BigInt!
    sci_fi: BigInt!
    sport: BigInt!
    thriller: BigInt!
    title: String!
    western: BigInt!
  }
  
  type Person {
    friendsWithPeople: [Person!]! @relationship(type: "FRIENDS_WITH", direction: OUT)
    likesMovies: [Movie!]! @relationship(type: "LIKES", direction: OUT, properties: "LikesProperties")
    name: String!
    peopleFriendsWith: [Person!]! @relationship(type: "FRIENDS_WITH", direction: IN)
  }

  type GraphEntity {
    name: String
    movie_id: BigInt
    actor_id: BigInt
    title: String
  }

  type Path {
    nodes: [GraphEntity]
  }

  type Query {
    degreesOfSeparation(actor1Name: String!, actor2Name: String!): Path
  }
`;

function processPathResult(result) {
  if (!result.records.length || !result.records[0].get('path')) {
    return null;
  }

  const path = result.records[0].get('path');
  const nodes = [];

  path.segments.forEach(segment => {
    nodes.push(segment.start.properties);
    if(segment.relationship) {
      nodes.push(segment.end.properties); 
    }
  });

  // Add the final actor if exists
  if (path.end) {
    nodes.push(path.end.properties);
  }

  return { nodes };
}



const resolvers = {
  Query: {
    degreesOfSeparation: async (_, { actor1Name, actor2Name }) => {
      const session = driver.session({ database: "movies" });
      console.log(actor1Name, actor2Name);
      try {
        const result = await session.run(
          'MATCH (actor1:Actor {name: $actor1Name}) ' +
          'MATCH (actor2:Actor {name: $actor2Name}) ' +
          'MATCH path = shortestPath((actor1)-[:ACTED_IN*]-(actor2)) ' +
          'RETURN path',
          { actor1Name, actor2Name }
        );
        console.log(result);
        console.log(result.records); 
        return processPathResult(result);
      } catch (error) {
        console.error(error);
      } finally {
        session.close();
      }
    },
  },
};


const driver = neo4j.driver(
  "bolt://localhost:7687/",
  neo4j.auth.basic("neo4j", "ca7uwaxa")
);

const neoSchema = new Neo4jGraphQL({ typeDefs, resolvers, driver });

const server = new ApolloServer({
  schema: await neoSchema.getSchema(),
});

const { url } = await startStandaloneServer(server, {
  context: async ({ req }) => ({ req }),
  listen: { port: 4000 },
});

console.log(`🚀 Server ready at ${url}`);
