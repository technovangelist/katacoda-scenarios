1. Navigate to the Datadog Integrations page and install the etcd integration.
1. Install the Helm chart using the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. Now run the Datadog agent status command to verify that etcd metrics are being collected. As you can see there is a problem. By the way, here is a way to run that exec command without having to figure out the name of the agent pod, since there is only one agent running. `k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}"`{{execute}} will show us the current name of that pod, so `k exec $(k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}") agent status`{{execute}} will run agent status with that pod name automatically.  If you get `error: unable to upgrade connection: container not found ("agent")`, then the pod isn't ready yet. Run `k get pods`{{execute}} to see their current status.
1. As you can see there is an error with the etcd integration. Lets take a look at the etcd pod to see what the right url is. `k describe pod -n kube-system etcd-master`{{execute}}. You are looking for the `--listen-client-urls` line under Command. 
1. So it's the ip address of the host and port 2379. We can override the configuration for etcd by adding a `datadog.confd` block to the values.yaml file. It doesn't really matter where in the file it is added, so let's put it at line 16. Add 

       confd:
         etcd.yaml: |-
           instances:
             - prometheus_url: https://%%host%%:2379/metrics

1. Now upgrade the helm chart: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. After the pods have started, run the agent status command again. There is still an error. Let's look at the etcd pod again by running the describe command: `k describe pod -n kube-system etcd-master`{{execute}}. 
1. It looks like the command shows a number of certs being used. The reason our metrics call is failing is that we aren't making that secure connection. In order to make the certs available to the Datadog agent, we need to create a volume, mount it, and then add those to the configuration for the etcd integration. First add the volumes. At line 270, add the following volume declarations:

       volumes:
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

       volumeMounts:
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

1. Upgrade the Datadog Agent helm chart again, wait for the agent pod to start, and check the agent status and you should see that etcd data is being collected. 
1. Unfortunately the autodiscovered etcd is still configured as well and its not working. So we just need to force it to be ignored. We can do that with another volume and volumeMount. In the volumes block you edited before, add:

         - emptyDir: {}
           name: etcd-auto-conf

1. And under volumeMounts add:

         volumeMounts:
           - name: etcd-auto-conf
             mountPath: /etc/datadog-agent/conf.d/etcd.d/
             readOnly: true

1. Upgrade the Datadog Agent helm chart one more time, wait for the agent pod to start, and check the agent status and you should see that etcd data is being collected and there are no errors.