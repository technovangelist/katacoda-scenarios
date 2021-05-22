Now that we have seen the basics of how the YAML files are written, let's start building out the db.yaml file.

1.  Create a file named `db.yaml` in the workshop directory: `touch ~/workshop/db.yaml`{{execute}}
2.  The following code is a good starting point for our Postgres database. You'll notice that we added another label and some other keys. Copy the YAML and paste it into your new db.yaml file in the IDE.
    <pre class="file" data-target="clipboard">
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        service: db
        app: ecommerce
      name: db
    spec:
      replicas: 1
      selector:
        matchLabels:
          service: db
          app: ecommerce
      template:
        metadata:
          labels:
            service: db
            app: ecommerce
        spec:
          containers:
          - image: postgres:11-alpine
            name: postgres
            securityContext:
              privileged: true 
            ports:
              - containerPort: 5432
            env:
            - name: POSTGRES_PASSWORD
              value: "password"
            - name: POSTGRES_USER
              value: "user"
            - name: PGDATA
              value: "/var/lib/postgresql/data/mydata"
            resources: {}
            volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgresdb 
          volumes:
          - name: postgresdb
    ---
    apiVersion: v1
    kind: Service
    metadata:
      creationTimestamp: null
      labels:
        app: ecommerce
        service: db 
      name: db
    spec:
      ports:
      - port: 5432
        protocol: TCP
        targetPort: 5432
      selector:
        app: ecommerce
        service: db
    status:
      loadBalancer: {}
    </pre>

3.  You can apply this configuration by running `kubectl apply -f db.yaml` from the workshop directory. In this environment we have aliased `kubectl` to `k` which is a pretty common alias. So try running `k apply -f db.yaml`{{execute}}. Note: *if anything in this file or any of the other yaml files in this scenario are new to you, then visit https://kubernetes.io/docs/home/ and search for the keyword that is not clear.*
4.  If you ever see an error in these labs that looks something like `The connection to the server localhost:8080 was refused`, Kubernetes has not had a chance to start. Wait a few more seconds for it to start.
5.  This will work a lot better for us. There are still some things we should do like create a persistent volume and not specify the password here, but this will work for our first pass.

In the next step, we will take a look at deploying one of the components of the actual web app.