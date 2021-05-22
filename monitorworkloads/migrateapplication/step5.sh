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

cat > /root/completedfiles/discounts.yaml <<EOL
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: ecommerce
    service: discounts
  name: discounts
spec:
  replicas: 1
  selector:
    matchLabels:
      service: discounts
      app: ecommerce
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        service: discounts
        app: ecommerce
    spec:
      containers:
      - image: ddtraining/discounts-fixed:latest
        name: discounts
        command: ["flask"]
        args: ["run", "--port=5001", "--host=0.0.0.0"]
        env:
          - name: FLASK_APP
            value: "discounts.py"
          - name: FLASK_DEBUG
            value: "1"
          - name: POSTGRES_PASSWORD
            valueFrom:
              secretKeyRef:
                key: pw
                name: db-password
          - name: POSTGRES_USER
            value: "user"
        ports:
        - containerPort: 5001
        resources: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    service: discounts
    app: ecommerce
  name: discounts
spec:
  ports:
  - port: 5001
    protocol: TCP
    targetPort: 5001
  selector:
    service: discounts
    app: ecommerce
  type: ClusterIP
EOL

cat > /root/completedfiles/dbpassword.yaml <<EOL
apiVersion: v1
kind: Secret
metadata:
  name: db-password
  labels:
    app: ecommerce
    service: db
type: Opaque
data:
  pw: password
EOL

clear

creds