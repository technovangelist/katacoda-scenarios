import os
import requests
from psycopg2 import connect
import json


# in addition, this example assumes env vars VAULT_ADDR, VAULT_PASSWORD
vaultaddr = os.environ['VAULT_ADDR']
vaultpassword = os.environ['VAULT_PASSWORD']


def get_password():
    as_json = json.dumps({"password": vaultpassword})
    response = requests.post(f'http://{vaultaddr}/v1/auth/userpass/login/student',
                             data=as_json)
    resp_json = json.loads(response.content)
    token = resp_json['auth']['client_token']
    response = requests.get(f'http://{vaultaddr}/v1/datadogdash/postgres_creds',
                            headers={'X-Vault-Token': token})
    resp_json = json.loads(response.content)
    password = resp_json['data']['password']
    return password


def get_name(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT name FROM users WHERE ID=8364;')
        return cur.fetchone()[0].strip()


password = get_password()
conn = connect(password=password)
name = get_name(conn)
print(f"Hello, {name}! Hope you're having a good time at Dash!")
