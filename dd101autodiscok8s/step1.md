Let's create the same environment in Kubernetes. Your Kubernetes environment could be local using miniKube, on a Rancher or similar environment or on a cloud service such as Google Cloud. If you don't have a Kubernetes environment, setting up miniKube is super quick and easy. The easiest install docs I have seen are here: https://github.com/kubernetes/minikube/releases. You will also need kubectl which you can find here: https://kubernetes.io/docs/tasks/tools/install-kubectl/

1.  Add the Datadog Agent to your Kubernetes environment by creating a dd-agent.yaml file. You can find the contents of this file, will your API KEY already filled in here: https://app.datadoghq.com/account/settings#agent/kubernetes
2.  Start the DaemonSet by running `kubectl apply -f dd-agent.yaml`
3.  Create a yaml file called `redisapp.yaml` with the following contents:

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