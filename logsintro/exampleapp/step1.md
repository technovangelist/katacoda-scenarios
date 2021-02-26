# Trying the application
Let's start this exercise by testing the application. The whole application is managed with docker-compose in order to simplify its usage.

`docker-compose up` is running automatically in the first terminal. Once it has completed its startup process it will display a stream of output from the running containers. You can see your Datadog credentials by running `creds`{{execute T2}} in Terminal 2. Then try out the application with some of the following commands in Terminal 2:

`curl -X GET 'http://localhost:8080/think/?subject=technology'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=religion'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=war'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=work'`{{execute T2}}
`curl -X GET 'http://localhost:8080/think/?subject=music'`{{execute T2}}

