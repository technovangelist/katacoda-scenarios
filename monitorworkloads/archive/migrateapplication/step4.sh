#!/bin/bash

cat > /root/completedfiles/db.yaml <<EOL
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
EOL
clear
creds

