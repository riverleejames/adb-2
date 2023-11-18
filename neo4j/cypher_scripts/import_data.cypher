// Import Actors CSV

LOAD CSV WITH HEADERS FROM 'file:///actors.csv' AS row
CREATE (:Actor {actor_id: toInteger(row.actor_id), name: row.name})

// Import Genres CSV
LOAD CSV WITH HEADERS FROM 'file:///genres.csv' AS row
CREATE (:Genre {name: row.name, position: toInteger(row.position)})

// Import Movies CSV
LOAD CSV WITH HEADERS FROM 'file:///movies.csv' AS row
CREATE (:Movie {
    movie_id: toInteger(row.movie_id), 
    title: row.title, 
    action: toInteger(row.action), 
    adventure: toInteger(row.adventure), 
    animation: toInteger(row.animation), 
    comedy: toInteger(row.comedy), 
    crime: toInteger(row.crime), 
    disaster: toInteger(row.disaster), 
    documentary: toInteger(row.documentary), 
    drama: toInteger(row.drama), 
    eastern: toInteger(row.eastern), 
    fantasy: toInteger(row.fantasy), 
    history: toInteger(row.history), 
    horror: toInteger(row.horror), 
    musical: toInteger(row.musical), 
    romance: toInteger(row.romance), 
    sci_fi: toInteger(row['sci-fi']), 
    sport: toInteger(row.sport), 
    thriller: toInteger(row.thriller), 
    western: toInteger(row.western)
})