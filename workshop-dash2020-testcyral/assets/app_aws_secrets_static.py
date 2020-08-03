import boto3
from psycopg2 import connect
import json


def get_password():
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager', region_name="us-east-1")
    get_secret_value_response = client.get_secret_value(SecretId="dash")
    secret = json.loads(get_secret_value_response['SecretString'])
    print(f'secret: {secret}\n')
    password = secret['password']
    return password


def get_name(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT name FROM users WHERE ID=8364;')
        return cur.fetchone()[0].strip()


password = get_password()
conn = connect(password=password)
name = get_name(conn)
print(f"Hello, {name}! Hope you're having a good time at Dash!")
