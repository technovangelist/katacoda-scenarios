import os
import approzium
from approzium.psycopg2 import connect


# assumes env vars APPROZIUM_ADDR, PGHOST, PGPORT, PGDATABASE, PGUSER are set.
approziumaddr = os.environ['APPROZIUM_ADDR']

auth = approzium.AuthClient(approziumaddr, disable_tls=True)
approzium.default_auth_client = auth


def get_name(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT name FROM users WHERE ID=8364;')
        return cur.fetchone()[0].strip()


conn = connect("")
name = get_name(conn)
print(f"Hello, {name}! Hope you're having a good time at Dash!")
