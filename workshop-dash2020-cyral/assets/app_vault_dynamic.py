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
    response = requests.get(f'http://{vaultaddr}/v1/database/creds/my-role',
                            headers={'X-Vault-Token': token})
    resp_json = json.loads(response.content)
    username = resp_json['data']['username']
    password = resp_json['data']['password']
    return username, password


def get_name(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT name FROM users WHERE ID=8364;')
        return cur.fetchone()[0].strip()


username, password = get_password()
print(f"\nConnecting with username '{username}' and password '{password}'.\n")
conn = connect(password=password, user=username)
name = get_name(conn)
print(f"Hello, {name}! Hope you're having a good time at Dash!")
