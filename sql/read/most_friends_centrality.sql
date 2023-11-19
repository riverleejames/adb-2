SELECT p.name, COUNT(*) as num_friends
FROM (
    SELECT person1_id as person_id FROM Friendships
    UNION ALL
    SELECT person2_id as person_id FROM Friendships
) AS all_friendships
JOIN Persons p ON all_friendships.person_id = p.person_id
GROUP BY p.name
ORDER BY num_friends DESC
LIMIT 1;
