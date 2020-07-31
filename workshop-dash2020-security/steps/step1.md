![dd_logo](../assets/dd_logo.png)

After the workshop environment is ready, you should have 3 containers running. You can ensure they are running with the following command

```
docker ps
```{{execute}}

The 3 containers are:
* server: this container contains your company's web application code. This is the code you will be working with in the workshop.
* legitimate_users: this container simulates users logging into your web application
* datadog: this container collects all of the metrics and logs for your environment.

There is an additional container which we will use in this workshop. It contains the code to simulate an attack. It can be executed with the following command

```
docker run -d --network=securityworkshop_default attacker
```{{execute}}
