-- Title: Q2 Cube Similarity Distance
SELECT 
    'Alien' AS movie_title,
    m2.title AS most_similar_movie,
    MIN(cube_distance(m1.genre,m2.genre)) AS similarity_distance
FROM
    movies m1
JOIN
    movies m2 ON m1.title != m2.title
WHERE
    m1.title = 'Alien'
GROUP BY
    m2.title
ORDER BY 
    similarity_distance ASC
LIMIT 1;
