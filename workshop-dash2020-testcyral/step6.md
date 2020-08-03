In this example we'll be using the script `app_approzium.py`{{open}}, which uses [Approzium](https://approzium.com/) to perform password-less authentication. In this case, the plaintext password is never loaded into memory, preventing any possibility of credential leakage.

Before running the script, please install the [`approzium`](https://approzium.readthedocs.io/en/latest/) Python SDK which communicates with the Approzium Authenticator service and establishes the database connection.
```
pip3 install approzium
```{{execute}}

```
python3 app_approzium.py
```{{execute}}