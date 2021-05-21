Let's continue rolling out our application to Kubernetes. Here we are going to enable the third service which is the advertisements server. 

1.  If you weren't able to complete the last section or the yaml file doesn't work, run this command to reset the files: `mv -i /root/completedfiles/db.yaml /root/workshop/db.yaml;mv -i /root/completedfiles/dbpassword.yaml /root/workshop/dbpassword.yaml;mv -i /root/completedfiles/discounts.yaml /root/workshop/discounts.yaml`{{execute}}. 
2.  Apply the yaml files: `k apply -f .`{{execute}}
3.  Create an advertisements yaml file: `touch ~/workshop/advertisements.yaml`{{execute}}.
4.  Now add the following content to that yaml file: 
    <pre class="file" data-target="clipboard">
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
    </pre>
5.  This yaml file should look pretty familiar. We are using a different docker container image, but it's configured in exactly the same way. In fact, both discounts and advertisements are very similar Python Flask apps. We will be updating all of these files when we need to start monitoring the application.