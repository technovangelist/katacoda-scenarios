We now have a working database. Let's work on the first of our web server components: discounts. This is a flask-based Python application. 

1.  If you weren't able to complete the last section or the yaml file doesn't work, run this command to reset the db.yaml file: `mv -i /root/completedfiles/db.yaml /root/workshop/db.yaml`{{execute}}. 
2.  Apply the db.yaml file: `k apply -f db.yaml`{{execute}}
3.  Create a **discounts.yaml** file using this command `touch ~/workshop/discounts.yaml`{{execute}}.
4.  Add the following content to this file: 
    <pre class="file" data-target="clipboard">
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
                value: "password"
              - name: POSTGRES_USER
                value: "user"
              - name: POSTGRES_HOST
                value: "db"
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
    </pre>

5.  Now run `k apply -f discounts.yaml`{{execute}} 
6.  Looking at the contents of discount.yaml, you can see that it's loading an image called **ddtraining/discounts-fixed**. This is a simple docker image based on **python:3.9.1-slim-buster** that has installed the requirements that you can see in the **discounts-service** folder in this lab. The only other thing defined in that docker image is that the package **build-essential** has been installed. 
7.  You can see in the YAML, the flask command is being run with a few command line parameters to specify the host and port. And then a few environment variables are defined. 
8.  In the IDE, open bootstrap.py under the discounts-service directory. You can see at **line 23** the url is generated for postgres that includes the database password. This is being pulled from an environment variable at **line 15**. And notice that that environment variable is defined on **line 33 of the discounts.yaml file** you created. And there is the corresponding variable in **db.yaml**. In case we ever want to change that password, we should define it once and then use it over and over again. And we should define it as a secret. 
9.  Create a **dbpassword.yaml** file (`touch ~/workshop/dbpassword.yaml`{{execute}}) and add the following to that file:
    <pre class="file" data-target="clipboard">
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
    </pre>

10. Now we can reuse that secret in both db and discounts.yaml. Replace the POSTGRES_PASSWORD and POSTGRES_USER environment variables in both YAML files with this:
    <pre class="file" data-target="clipboard">
    - name: POSTGRES_PASSWORD
      valueFrom:
        secretKeyRef:
          key: pw
          name: db-password
    - name: POSTGRES_USER
      value: "user"
    </pre>
11. Apply the three yaml files again: `k apply -f db.yaml;k apply -f discounts.yaml;k apply -f dbpassword.yaml`{{execute}}
12. Alternatively if you want to apply all the yaml files in one directory you can run `k apply -f .`{{execute}}