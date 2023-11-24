from openai import OpenAI
from pgvector.psycopg import register_vector
import psycopg

conn = psycopg.connect(dbname='openaivectors', autocommit=True)

conn.execute('CREATE EXTENSION IF NOT EXISTS vector')
register_vector(conn)

conn.execute('DROP TABLE IF EXISTS documents')
conn.execute('CREATE TABLE documents (id bigserial PRIMARY KEY, content text, embedding vector(1536))')

input = [
    'The dog is barking',
    'The cat is purring',
    'The bear is growling',
    'The lion is roaring',
    'The wolf is howling',
    'The tiger is snarling',
    'The elephant is trumpeting',
    'The mouse is squeaking',
    'The snake is hissing',
    'The horse is neighing',
    'The cow is mooing',
    'The sheep is bleating',
    'The goat is bleating',
    'The pig is oinking',
    'The duck is quacking',
    'The goose is honking',
    'The chicken is clucking',
]

client = OpenAI(
    # defaults to os.environ.get("OPENAI_API_KEY")
    api_key="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",
)

response = client.embeddings.create(input=input, model='text-embedding-ada-002')
embeddings = [v.embedding for v in response.data]

for content, embedding in zip(input, embeddings):
    conn.execute('INSERT INTO documents (content, embedding) VALUES (%s, %s)', (content, embedding))

document_id = 1
neighbors = conn.execute('SELECT content FROM documents WHERE id != %(id)s ORDER BY embedding <=> (SELECT embedding FROM documents WHERE id = %(id)s) LIMIT 5', {'id': document_id}).fetchall()
for neighbor in neighbors:
    print(neighbor[0])