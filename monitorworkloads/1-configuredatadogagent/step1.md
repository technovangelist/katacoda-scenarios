When you are working with virtual machines and cloud instances, you typically configure the Datadog Agent to process an application's metrics in the YAML file for the agent. But with Kubernetes you perform that configuration in the manifest for the application. In this lab, we have an application that is running as well as a Datadog Agent that is submitting metrics, logs, and more to Datadog. But it doesn't know anything about our database, and its not submitting any metrics from our frontend application yet. In this lab we will configure those to submit data. 

1.  In the IDE, open the file called `db.yaml` located under `deploy/generic-k8s/ecommerce-app`. You can see that this manifest defines a deployment, a service account and secret, a volume, and a service. 
2.  What we don't have here is any way to collect Postgres metrics with the Datadog Agent. To do that we need to add annotations. You can learn more about Auto Discovery Annotations at https://docs.datadoghq.com/agent/kubernetes/integrations/?tab=kubernetes
3.  The documentation says "If you define pods indirectly with replication controllers, replica sets, or deployments, add pod annotations under `.spec.template.metadata.`", so add the following to that section around line 61:
    <pre class="file" data-target="clipboard">annotations:
            ad.datadoghq.com/postgres.check_names: '["postgres"]'
            ad.datadoghq.com/postgres.init_configs: '[{}]'
            ad.datadoghq.com/postgres.instances: '[{"host": "%%host%%", "port": "%%port%%","username": "datadog","password": "datadog" }]'</pre>
4.  Now apply the manifest by running `k apply -f deploy/generic-k8s/ecommerce-app/db.yaml`{{execute}}.
5.  You can verify that this works by first running `k get pods`{{execute}} to get the name of our Datadog Agent pod, and then use that in `k exec <agentpodname> agent status`. You will see there are two Agent pods. We want the Agent that is running on the worker node which starts with datadogagent followed by 5 characters. The other Agent pod starts with datadogagent-controlplane followed by 5 characters. You will notice that both of these pods have a app label set, with the controlplane pod app label set to datadogagent-controlplane and the other one having an app label of just datadogagent. So we could also just run `k exec $(k get pod -l app=datadogagent -o name) agent status`{{execute}} 
6.  You will see that the Postgres integration isn't working yet. Take a look at the documentation for the Postgres integration. The reason it's not working is that the **datadog** user in **Postgres** doesn't exist yet. Normally in a Kubernetes environment we would add this with a script on the initialization of the pod, but our database is already running so we need to go through some manual steps. So run `k get pods`{{execute}} again to get the name of our database pod. 
7.  Now run `k exec <dbpodname> -it bash` to run an interactive shell on the pod. 
8.  Run `psql -h localhost -U user postgres`{{execute}}. Then in the psql environment run: 
        `create user datadog with password 'datadog';
        grant pg_monitor to datadog;
        grant SELECT ON pg_stat_database to datadog;`{{execute}}
9.  Exit out of the psql environment and exit out of the db pod shell. Now run the agent status command again to see if there is a different result. You should see that the postgres metrics are being collected. It can take a few seconds for the agent to see the changes, so if you see the same error try again.
