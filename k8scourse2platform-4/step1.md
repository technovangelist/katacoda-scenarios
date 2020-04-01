In this Hands On section, the agent has been started automatically for you. 

1. Navigate to the Datadog Integrations page and install the etcd integration.
1. Install the Helm chart using the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. Now run the Datadog agent status command to verify that etcd metrics are being collected. As you can see there is a problem. By the way, here is a way to run that exec command without having to figure out the name of the agent pod, since there is only one agent running. `k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}"`{{execute}} will show us the current name of that pod, so `k exec $(k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}") agent status`{{execute}} will run agent status with that pod name automatically. 
1. As you can see there is an error with the etcd integration. Lets take a look at the etcd pod to see what the right url is. `k describe pod -n kube-system etcd-master`{{execute}}.
1. So it's the ip address of the host and port 2379. We can override the configuration for etcd by adding a `datadog.confd` block. It doesn't really matter where in the file it is added, so let's put it at line 16. Add 

      confd:
        etcd.yaml: |-
          instances:
            - prometheus_url: https://%%host%%:2379/metrics

1. Now upgrade the helm chart: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. After the pods have started, run the agent status command again. There is still an error. Let's look at the etcd pod again by running the describe command: `k describe pod -n kube-system etcd-master`{{execute}}. 
1. It looks like the command shows a number of certs being used. The reason our metrics call is failing is that we aren't making that secure connection. In order to make the certs available to the Datadog agent, we need to create a volume, mount it, and then add those to the configuration for the etcd integration. First add the volumes. At line 272, add the following volume declarations:

      - hostPath:
          path: /etc/kubernetes/pki/etcd/ca.crt
          type: File
        name: etcd-ca
      - hostPath:
          path: /etc/kubernetes/pki/etcd/peer.crt
          type: File
        name: etcd-crt
      - hostPath:
          path: /etc/kubernetes/pki/etcd/peer.key
          type: File
        name: etcd-private-key

1. Just below that in the volumeMounts block add: 

      - mountPath: /etc/datadog-agent/certs/etcd-ca.crt
        name: etcd-ca
        readOnly: true
      - mountPath: /etc/datadog-agent/certs/etcd-client.crt
        name: etcd-crt
        readOnly: true
      - mountPath: /etc/datadog-agent/certs/etcd-client.key
        name: etcd-private-key
        readOnly: true

1. Now add the mountPaths to the etcd integration configuration:

      instances:
        - prometheus_url: https://%%host%%:2379/metrics
          ssl_verify: true
          ssl_ca_cert: /etc/datadog-agent/certs/etcd-ca.crt
          ssl_cert: /etc/datadog-agent/certs/etcd-client.crt
          ssl_private_key: /etc/datadog-agent/certs/etcd-client.key

1. Upgrade the Datadog Agent helm chart. 