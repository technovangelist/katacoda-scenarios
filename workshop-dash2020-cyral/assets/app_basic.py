import os
from psycopg2 import connect


# assumes env vars PGHOST, PGPORT, PGDATABASE, PGUSER, PASSWORD are set.
# all of them are picked up by psycopg2 except PASSWORD
password = os.environ['PASSWORD']


def get_name(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT name FROM users WHERE ID=8364;')
        return cur.fetchone()[0].strip()


conn = connect(password=password)
name = get_name(conn)
print(f"Hello, {name}! Hope you're having a good time at Dash!")
