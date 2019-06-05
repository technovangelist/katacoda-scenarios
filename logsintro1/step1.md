# Trying the application
Let's start this exercise by testing the application. The whole application is managed with docker-compose in order to simplify its usage.

Try out the application with some of the following commands. You can run these commands from Terminal 2 to the right after `docker-compose up` has completed the startup process:

`curl -X GET 'http://localhost:8080/think/?subject=technology'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=religion'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=war'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=work'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=music'`{{execute T2}}

