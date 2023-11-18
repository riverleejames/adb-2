// Create relationship between actors and movies

LOAD CSV WITH HEADERS FROM 'file:///movies_actors.csv' AS row
MATCH (m:Movie {movie_id: toInteger(row.movie_id)})
MATCH (a:Actor {actor_id: toInteger(row.actor_id)})
MERGE (a)-[:ACTED_IN]->(m)

// Create relationship between movies and genres
MATCH (m:Movie)
UNWIND [
    {genre: 'Action', value: m.action},
    {genre: 'Adventure', value: m.adventure},
    {genre: 'Animation', value: m.animation},
    {genre: 'Comedy', value: m.comedy},
    {genre: 'Crime', value: m.crime},
    {genre: 'Disaster', value: m.disaster},
    {genre: 'Documentary', value: m.documentary},
    {genre: 'Drama', value: m.drama},
    {genre: 'Eastern', value: m.eastern},
    {genre: 'Fantasy', value: m.fantasy},
    {genre: 'History', value: m.history},
    {genre: 'Horror', value: m.horror},
    {genre: 'Musical', value: m.musical},
    {genre: 'Romance', value: m.romance},
    {genre: 'SciFi', value: m.sci_fi},
    {genre: 'Sport', value: m.sport},
    {genre: 'Thriller', value: m.thriller},
    {genre: 'Western', value: m.western}
] AS genreInfo
MATCH (g:Genre {name: genreInfo.genre})
WHERE genreInfo.value > 0
MERGE (m)-[:IN_GENRE]->(g)