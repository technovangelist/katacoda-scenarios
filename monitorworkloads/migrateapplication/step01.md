1.  Next let's expose the port that the user needs to access the postgres application. And if you look at the [image on DockerHub](https://hub.docker.com/_/postgres) you will see that a number of environment variables need to be defined. 

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: db
      labels:
        service: db
    spec:
      selector:
        matchLabels:
          service: db
      template:
        metadata:
          labels:
            service: db
        spec:
          containers:
          - image: postgres:11-alpine
            name: postgres
            ports:
              - containerPort: 5432
            env:
            - name: POSTGRES_PASSWORD
              value: "password"
            - name: POSTGRES_USER
              value: "user"  
            - name: PGDATA
              value: "/var/lib/postgresql/data/mydata"
    ```