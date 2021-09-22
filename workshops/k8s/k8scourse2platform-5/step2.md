By default the API Server does not enable audit logs. In preparation for this lab we went through the following process:
  1. Added a new audit policy yaml file. You can see the file in the editor under auditpolicy.yaml. 
  1. Updated the kube-apiserver.yaml file located at /etc/kubernetes/manifests/ on the master node as follows:
    * point to the new audit policy
    * configure the volumemounts for writing the new logs. 

You can find all the instructions for setting this up on your production systems here: https://docs.datadoghq.com/integrations/kubernetes_audit_logs. 

In this lab we will configure the Datadog Agent to start collecting those audit logs.

1.  Navigate to the Logs feature of Datadog here: https://app.datadoghq.com/logs. If you haven't already activated the Logs trial, click the **Get Started** button. 
1.  Open the **values.yaml** file in the editor. Enable logs by setting `enabled` to true around line 210. You should also enable `containerCollectAll`.
1.  In the `confd` section of the **values.yaml** file (around line 275), add a block for `kube_audit.yaml`:

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
                ssl_private_key: /keys/peer.key
          kube_audit.yaml: |-
            logs:
              - type: file
                path: /var/log/kubernetes/apiserver/audit.log
                service: kube-apiserver-audit
                source: kubernetes.audit

1.  In `volumes` add the block for `klogpath` (around line 830):

        volumes:
          - hostPath:
              path: /etc/kubernetes/pki/etcd
            name: etcd-keys
          - emptyDir: {}
            name: etcd-auto-conf
          - hostPath:
              path: /var/log/kubernetes
            name: klogpath

1.  Add the corresponding blocks in `volumeMounts`:

        volumeMounts:
          - name: etcd-auto-conf
            mountPath: /etc/datadog-agent/conf.d/etcd.d/
            readOnly: true
          - mountPath: /keys
            name: etcd-keys
            readOnly: true
          - name: klogpath
            mountPath: /var/log/kubernetes
            readOnly: true

1.  Apply the changes to our Helm chart `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f values.yaml stable/datadog`{{execute}}.
1.  Check that the logs are being collected by running the status command and looking at the list of logs being collected: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent status`{{execute}} 
1.  Navigate to the Logs page that you opened at the beginning of this lab. You should soon see a large number of logs coming from the service: **kube-apiserver-audit**. 

Soon after the Audit logs start coming in, the Logs integration for Kubernetes Audit Logs automatically install the audit pipeline.

Start looking around the logs to see what kind of information is being collected. You can open the Logs configuration to see how the Kubernetes audit pipeline works. Then take a look at the facets and measures that have been created. If you haven't worked with Logs in Datadog, take a look at the Introduction to Logs course here on the Datadog Learning Center. 