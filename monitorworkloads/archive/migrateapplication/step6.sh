#!/bin/bash
cat > /root/completedfiles/advertisements.yaml <<EOL
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    service: advertisements
    app: ecommerce
  name: advertisements 
spec:
  replicas: 1
  selector:
    matchLabels:
      service: advertisements
      app: ecommerce
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        service: advertisements
        app: ecommerce
    spec:
      containers:
      - image: ddtraining/advertisements-fixed:latest
        name: advertisements 
        command: ["flask"]
        args: ["run", "--port=5002", "--host=0.0.0.0"]
        env:
          - name: FLASK_APP
            value: "ads.py"
          - name: FLASK_DEBUG
            value: "1"
          - name: POSTGRES_PASSWORD
            valueFrom:
              secretKeyRef:
                key: pw
                name: db-password
          - name: POSTGRES_USER
            value: "user"
          - name: POSTGRES_HOST
            value: "db"
        ports:
        - containerPort: 5002
        resources: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    service: advertisements
    app: ecommerce
  name: advertisements
spec:
  ports:
  - port: 5002
    protocol: TCP
    targetPort: 5002
  selector:
    service: advertisements
    app: ecommerce
status:
EOL

cat > /root/completedfiles/frontend.yaml <<EOL
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    service: frontend
    app: ecommerce
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      service: frontend
      app: ecommerce
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        service: frontend
        app: ecommerce
    spec:
      containers:
      - args:
        - docker-entrypoint.sh
        command:
        - sh
        env:
        - name: DB_USERNAME
          value: user
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              key: pw
              name: db-password
        image: ddtraining/ecommerce-frontend:latest
        imagePullPolicy: Always
        name: ecommerce-spree-observability
        ports:
        - containerPort: 3000
          protocol: TCP
        resources:
          requests:
            cpu: 100m
            memory: 100Mi
          limits: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    service: frontend
    app: ecommerce
  name: frontend
spec:
  ports:
    - port: 3000
      protocol: TCP
      targetPort: 3000
      name: http
  selector:
    service: frontend
    app: ecommerce
  type: LoadBalancer
EOL

clear
creds
