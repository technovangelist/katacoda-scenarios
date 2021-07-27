Now let's deploy the fourth component of the application: the front end server. This is a Ruby on Rails based application which calls out to discounts and ads and displays products from the database. 

1.  If you weren't able to complete the last section or the yaml file doesn't work, run this command to reset the xxxx file: `cd /root/workshop;mv -i /root/completedfiles/advertisements.yaml /root/workshop/advertisements.yaml;k apply -f .`{{execute}}
2.  The Dockerfile used for this component is also very simple, based on the ruby:2.7.2-slim-buster image. It installs a few other tools, then runs a docker-entrypoint shell script which specifies some environment variables and runs puma which is a special web server. 
3.  Create a frontend.yaml file using this command `touch ~/workshop/frontend.yaml`{{execute}}.
    <pre class="file" data-target="clipboard">
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
      type: LoadBalancer</pre>
4.  And now the app should be all setup. Deploy the yaml files: `k apply -f .`{{execute}}
5.  Now we have successfully migrated our application from a traditional VM based environment to a Kubernetes environment. This was a simple application but the process showed you what most of the parts of a configuration file are for and how you can build one too. 
6.  Now you can visit https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/ to try out the application. If the site isn't available, try running `k get pods`{{execute}} to see if all the pods are running. It can take a minute for them to start completely. 

