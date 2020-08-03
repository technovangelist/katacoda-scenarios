We've provided a script which reads the name from our database and outputs it in a message. You can view its contents by selecting `app_basic.py`{{open}} in the sidebar of the IDE.

As you can see, this code loads the database password from the environment variable we've set.

Before you run the script, please install the [psycopg2](https://www.psycopg.org/) Python package which is used to interface with Postgres. It depends on [python3.8-dev](https://packages.debian.org/sid/python3.8-dev) so we install that first.
```
apt-get install -y python3.8-dev
```{{execute}}

```
pip3 install psycopg2
```{{execute}}

You can run the script as follows
```
python3 app_basic.py
```{{execute}}

In the next step, we'll update our code to more securely retrieve the password from a secrets manager.
