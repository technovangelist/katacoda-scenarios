1.  Navigate to the <a href="https://app.datadoghq.com/account/settings#agent/docker" target=_datadog>Agent Installation</a> page in the Datadog application.
2.  Select **Docker** and copy the first command. Run it where ever you have Docker installed.
3.  You now have the Datadog agent running on your Docker machine. 
4.  Run `docker exec -it dd-agent bash`{{execute}} to login to a bash shell on that container.
5.  You can now run any of the Datadog commands you have on Linux. For instance, run `agent status`{{execute}}.
6.  Run `agent`{{execute}} to see the other available commands, or type `exit`{{execute}} to return to your host machine.
7.  Start a Redis container by running the following command: `docker run -d --name ad-redis redis`{{execute}}. This is starting a container based on the image name `redis`.
8.  Run the Datadog Agent Status command `docker exec -it dd-agent agent status`{{execute}}. Also run the Agent's configcheck command `docker exec -it dd-agent agent configcheck`{{execute}}. Is Redis being monitored? Try waiting a few seconds and try again.
9.  Kill and remove the containers using the command `docker rm -f $(docker ps -q)`{{execute}}
10. Start the Datadog container again using the same command as before.
11. Open the file called `Dockerfile` in a the `redisdocker` directory. Notice that the contents are a single line:
    <pre><code>FROM redis
    </code></pre>
12. Build the new image using the following command: `docker build -t inmemdb redisdocker`{{execute}}
13. Run the redisdocker image using the command: `docker run --name inmemdb -d inmemdb`{{execute}}. The Redis docker container based on our modified image is now running.
14. Run the Datadog Agent configcheck command again `docker exec -it dd-agent agent configcheck`{{execute}}. Is the new database being monitored? Why do you think that is?

### Using Docker Compose
Let's switch over to using docker-compose.

1.  Create a docker-compose.yaml file in the same directory as your Dockerfile with the following contents:
    
    <pre><code>version: "3"
    networks:
      main:

    services:
      datadog:
        image: datadog/docker-dd-agent
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - /proc:/host/proc:ro
          - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
        environment:
          - API_KEY
          - SD_BACKEND=docker
        networks:
          - main

      frontendredis:
        image: redis
        networks:
          - main

      backendredis:
        build: .
        networks:
          - main
    </code></pre>

1.  Run `docker-compose up -d`.
1.  Run the datadog info command (```docker-compose exec datadog /etc/init.d/datadog-agent info```). How many redis instances are being monitored?
1.  Modify the backendredis service to show the following:

    <pre><code class=yaml>backendredis:
        build: .
        networks:
          - main
        labels:
          com.datadoghq.ad.check_names: '["redisdb"]'
          com.datadoghq.ad.init_configs: '[{}]'
          com.datadoghq.ad.instances: '[{"host":"%%host%%", "port": "%%port%%"}]'
    </code></pre>

1.  Stop and remove the containers then run `docker-compose up` again. 
1.  Run the Datadog Agent Info command again, how many instances are being monitored?

### Now with Kubernetes

Let's create the same environment in Kubernetes. Your Kubernetes environment could be local using miniKube, on a Rancher or similar environment or on a cloud service such as Google Cloud. If you don't have a Kubernetes environment, setting up miniKube is super quick and easy. The easiest install docs I have seen are here: https://github.com/kubernetes/minikube/releases. You will also need kubectl which you can find here: https://kubernetes.io/docs/tasks/tools/install-kubectl/

1.  Add the Datadog Agent to your Kubernetes environment by creating a dd-agent.yaml file. You can find the contents of this file, will your API KEY already filled in here: https://app.datadoghq.com/account/settings#agent/kubernetes
1.  Start the DaemonSet by running `kubectl apply -f dd-agent.yaml`
1.  Create a yaml file called `redisapp.yaml` with the following contents:

        apiVersion: v1
        kind: Service
        metadata:
          name: redis-master
          labels:
            app: redis
            tier: backend
            role: master
        spec:
          ports:
          - port: 6379
            targetPort: 6379
          selector:
            app: redis
            tier: backend
            role: master
        ---
        apiVersion: extensions/v1beta1
        kind: Deployment
        metadata:
          name: redis-master
        spec:
          replicas: 1
          template:
            metadata:
              labels:
                app: redis
                role: master
                tier: backend
            spec:
              containers:
              - name: master
                image: gcr.io/google_containers/redis:e2e  # or just image: redis
                resources:
                  requests:
                    cpu: 100m
                    memory: 100Mi
                ports:
                - containerPort: 6379
        ---
        apiVersion: v1
        kind: Service
        metadata:
          name: redis-slave
          labels:
            app: redis
            tier: backend
            role: slave
        spec:
          ports:
          - port: 6379
          selector:
            app: redis
            tier: backend
            role: slave
        ---
        apiVersion: extensions/v1beta1
        kind: Deployment
        metadata:
          name: redis-slave
        spec:
          replicas: 2
          template:
            metadata:
              labels:
                app: redis
                role: slave
                tier: backend
            spec:
              containers:
              - name: slave
                image: gcr.io/google_samples/gb-redisslave:v1
                resources:
                  requests:
                    cpu: 100m
                    memory: 100Mi
                env:
                - name: GET_HOSTS_FROM
                  value: dns
                ports:
                - containerPort: 6379

4.  Add the Deployments by running `kubectl apply -f redisapp.yaml`.
5.  Find the name of your agent pod: `kubectl get pods -l app=dd-agent`. Then run the Datadog Agent info command on that pod: `kubectl exec [agent pod]  /etc/init.d/datadog-agent info`.
6.  You should see that only a single redis instance is being monitored.
7.  Update the redis-slave deployment as follows:

    ```
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: redis-slave
    spec:
      replicas: 2
      template:
        metadata:
          annotations:
            service-discovery.datadoghq.com/slave.check_names: '["redisdb"]'
            service-discovery.datadoghq.com/slave.init_configs: '[{}]'
            service-discovery.datadoghq.com/slave.instances: '[{"host":"%%host%%","port":"%%port%%"}]'
          labels:
            app: redis
            role: slave
            tier: backend
        spec:
          containers:
          - name: slave
            image: gcr.io/google_samples/gb-redisslave:v1
            resources:
              requests:
                cpu: 100m
                memory: 100Mi
            env:
            - name: GET_HOSTS_FROM
              value: dns
            ports:
            - containerPort: 6379
    ```
8.  Apply the redisapp.yaml file again. Try the Datadog Agent Info command to see how many instances are being monitored.
9.  Can you see where the info in the annotations come from?

Once you have the Redis container running, choose another local integration from the [Integration documentation](http://docs.datadoghq.com/integrations/). Start the container using an image found on the [Docker Hub](https://hub.docker.com/) and create a configuration. At the end of this session, lets talk about how you did it.