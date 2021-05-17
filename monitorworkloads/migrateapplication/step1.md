In this first step we will get started with our Kubernetes environment. When the lab has started, open the IDE from the tab about the terminal. Our Kubernetes configurations are written using YAML, so make sure the YAML plugin is installed. You may need to refresh the IDE by clicking the refresh icon in the tab for the IDE.

1.  Create a db.yaml file in the workshop directory `touch ~/workshop/db.yaml`{{execute}}
2.  The following code is a good starting point for our Postgres database:
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
      strategy: {}
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
              valueFrom:
                secretKeyRef:
                  key: pw
                  name: db-password
            - name: POSTGRES_USER
              value: "user"
            - name: PGDATA
              value: "/var/lib/postgresql/data/mydata"
            resources: {}
            volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgresdb 
          serviceAccountName: postgres
          volumes:
          - name: postgresdb
            persistentVolumeClaim:
                claimName: task-pvc-volume
      </pre>