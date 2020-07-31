We have now updated the logging function in the code. Let’s now build the Docker container and deploy it with Docker Compose.

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
