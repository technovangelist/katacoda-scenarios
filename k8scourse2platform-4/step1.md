1. Navigate to the Datadog Integrations page and install the etcd integration.
1. Install the Helm chart using the helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f values.yaml stable/datadog`{{execute}}.
1. Now run the Datadog agent status command to verify that etcd metrics are being collected. As you can see there is a problem. By the way, here is a way to run that exec command without having to figure out the name of the agent pod, since there is only one agent running. `k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}"`{{execute}} will show us the current name of that pod, so `k exec $(k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}") agent status`{{execute}} will run agent status with that pod name automatically.  If you get `error: unable to upgrade connection: container not found ("agent")`, then the pod isn't ready yet. Run `k get pods`{{execute}} to see their current status.
1. That was a pretty complicated command to get the agent status to come up. Thankfully there is a plugin system for kubectl as well, called krew. The match-name plugin is already installed, so you can also try `k exec $(k match-name datadog) agent status`{{execute}}. Of course if you have multiple pods that have names that start with datadog, only the first will be used.  
1. As you can see there is an error with the etcd integration. Let's first look at how Datadog is configured to run. `k exec $(k match-name datadog) agent configcheck`{{execute}}. Scroll up to etcd and look at the configuration.
1. Now let's take a look at the etcd pod to see how it is configured. `k describe pod -n kube-system etcd-master`{{execute}}. You can see the metrics url as well as a number of other command line options used to start etcd. So we can start there. 
1. We can override the configuration for etcd by working with the `datadog.confd` block of the Helm values.yaml file. In this version of the file, you will find the section around line 274. 

       confd:
         etcd.yaml: |-
           instances:
             - prometheus_url: https://%%host%%:2379/metrics

1. Now upgrade the helm chart: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f values.yaml stable/datadog`{{execute}}.
1. After the pods have started, run the agent configcheck command again. Notice that there are two etcd configs. And one of them has an ip address and the other still says %%host%%. Update the confd block we added above to this:

      confd:
        etcd.yaml: |-
          ad_identifiers:
            - etcd
          instances:
            - prometheus_url: https://%%host%%:2379/metrics

1. Run the `configcheck` command again. Notice there are still two etcd checks running, but they both have the correct ip address filled in. 
1. The autodiscovery feature is still finding etcd so lets fix that. Around line 830 in the Helm values file you will find the `volumes:` block. Add the following:

      volumes:
        - emptyDir: {}
          name: etcd-auto-conf
   
   And then just below that in `volumeMounts:` add:

      volumeMounts:
        - name: etcd-auto-conf
          mountPath: /etc/datadog-agent/conf.d/etcd.d/
          readOnly: true

1. Run the Helm upgrade command again. 
There is still an error. Let's look at the etcd pod again by running the describe command: `k describe pod -n kube-system etcd-master`{{execute}}. 
1. It looks like the command shows a number of certs being used. The reason our metrics call is failing is that we aren't making that secure connection. In order to make the certs available to the Datadog agent, we need to create a volume, mount it, and then add those to the configuration for the etcd integration. First add the volumes. At line 270, add the following volume declarations:

        volumes:
          - hostPath:
              path: /etc/kubernetes/pki/etcd
            name: etcd-keys
          - emptyDir: {}
            name: etcd-auto-conf

1. Just below that in the volumeMounts block add: 

        volumeMounts:
        - name: etcd-auto-conf
          mountPath: /etc/datadog-agent/conf.d/etcd.d/
          readOnly: true
        - mountPath: /keys
          name: etcd-keys
          readOnly: true


1. Now add the mountPaths to the etcd integration configuration. Remember, that's back up at line 274.

        confd:
          etcd.yaml: |-
            ad_identifiers:
              - etcd
            instances:
              - prometheus_url: https://%%host%%:2379/metrics
                ssl_verify: false
                use_preview: true
                ssl_ca_cert: /keys/ca.crt
                ssl_cert: /keys/peer.crt
                ssl_private_key: /keys/peer.key.key

1. Reinstall the Datadog Agent helm chart again, wait for the agent pod to start, and check the agent status and you should see that etcd data is being collected. 
1. Unfortunately the autodiscovered etcd is still configured as well and its not working. So we just need to force it to be ignored. We can do that with another volume and volumeMount. In the volumes block you edited before, add:

         - emptyDir: {}
           name: etcd-auto-conf

1. And under volumeMounts add:

         volumeMounts:
           - name: etcd-auto-conf
             mountPath: /etc/datadog-agent/conf.d/etcd.d/
             readOnly: true

1. Reinstall the Datadog Agent helm chart one more time, wait for the agent pod to start, and check the agent status and you should see that etcd data is being collected and there are no errors.