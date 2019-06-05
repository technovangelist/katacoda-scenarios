This course uses two different applications that run on this cloud shell. In Getting Started with Logs, we use a simple Flask application with NGINX, an API, a micro-service and Redis running in a few Docker containers. The Flask application has already been instrumented with Datadog APM and allows us to focus on the log collection and usage part.

# Trying the application
Let's start this exercise by testing the application. The whole application is managed with docker-compose in order to simplify its usage.

Try out the application with some of the following commands. You can run these commands from Terminal 2 to the right:

`curl -X GET 'http://localhost:8080/think/?subject=technology'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=religion'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=war'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=work'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=music'`{{execute T2}}

