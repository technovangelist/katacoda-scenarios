The next step after looking at the audit logs and determining you do not have sufficient logging, we need to modify the audit logs. Let's start by trying to answer some basic questions questions:

* Who is failing to login?
* Why are they failing to login?

Go ahead and attempt to modify the audit log function which can be found in `/workspace/security-workshop/server/utils.py`.
Don't worry to much about getting the logs perfect. We will cover some recommendations in the steps to follow.


# Testing the changes

You can test your changes by redeploying the code.

```
cd /workspace/security-workshop/server/
docker-compose build
docker-compose up -d
```{{execute}}

The new logging format should now be visible in the Datadog Log Monitoring product. New successful logins occur every 30 to 60 seconds. However, you can force logins to occur by running the following commands

Successful Login
```
curl -X POST -H "Content-Type: application/json" --data '{"user":"john.doe@gmail.com", "password":"john.doe@gmail.com"}' http://127.0.0.1:9999/login
```{{execute}}

Unsuccessful Login - Invalid Password
```
curl -X POST -H "Content-Type: application/json" --data '{"user":"john.doe@gmail.com", "invalid_password":"invalid_password"}' http://127.0.0.1:9999/login
```{{execute}}

Unsuccessful Login - Invalid User
```
curl -X POST -H "Content-Type: application/json" --data '{"user":"invalid.user@gmail.com", "invalid_password":"john.doe@gmail.co"}' http://127.0.0.1:9999/login
```{{execute}}
