When you are working with virtual machines and cloud instances, you typically configure the Datadog Agent in the YAML file for the agent. But with Kubernetes you perform that configuration in the manifest for the application. 

In this lab, we have an application that is running as well as a Datadog Agent that is submitting metrics, logs, and more to Datadog. But the Agent doesn't know anything about our database, and its not submitting any metrics from our frontend application yet. In this lab we will configure those parts of the Agent to submit data. 

1.  Open the IDE which you can find in the tab at the top of the terminal. 
2.  In the IDE, open the file called `db.yaml` located at `deploy/generic-k8s/ecommerce-app/db.yaml`{{open}}. You can see that this manifest defines a deployment, a service account and secret, a volume, and a service. 
3.  What we don't have here is any way to collect Postgres metrics with the Datadog Agent. To do that we need to add annotations. You can learn more about Auto Discovery Annotations at https://docs.datadoghq.com/agent/kubernetes/integrations/?tab=kubernetes
4.  The documentation says "If you define pods indirectly with replication controllers, replica sets, or deployments, add pod annotations under `.spec.template.metadata.`", so add the following to that section around line 61: *Note: the formatting looks wrong here in the text but it should be pasted into your code correctly.*
    <pre class="file" data-target="clipboard">
    annotations:
            ad.datadoghq.com/postgres.check_names: '["postgres"]'
            ad.datadoghq.com/postgres.init_configs: '[{}]'
            ad.datadoghq.com/postgres.instances: '[{"host": "%%host%%", "port": "%%port%%","username": "datadog","password": "datadog" }]'
            ad.datadoghq.com/postgres.logs: '[{"source":"postgres","service":"db"}]'</pre>
5.  Then under `.spec.template.metadata.labels` add:
    <pre class="file" data-target="clipboard">
    tags.datadoghq.com/env: "production"
            tags.datadoghq.com/service: "db"
            tags.datadoghq.com/version: "1.0" 
    </pre>
    
    The result of these two copy/paste actions should look something like this: ![metadata and labels indenting](configuredatadogagent/assets/metadatalabelsafter.png) 
6.  Before applying db.yaml, make sure that all of your pods are up and running. You can do this by checking the output of `k get pods`{{execute}}. Once everything has a status of **Running**, apply the manifest by running `k apply -f deploy/generic-k8s/ecommerce-app/db.yaml`{{execute}}.
7.  You can verify that this works by first running `k get pods`{{execute}} to get the name of our Datadog Agent pod, and then use that in `k exec <agentpodname> -- agent status`. You will see there are two Agent pods. We want the Agent that is running on the worker node which starts with datadogagent followed by 5 characters. 
    
    The other Agent pod starts with datadogagent-cluster-agent followed by a few more characters. You will notice that both of these pods have an app label set (You can see the labels when you run `k describe pod <pod name>`), with the cluster-agent pod app label set to datadogagent-cluster-agent and the other one having an app label of just datadogagent. So we could also just run `k exec $(k get pod -l app=datadogagent -o name) -- agent status`{{execute}} 
8.  You will see that the Postgres integration isn't working yet. ![Postgres Error](configuredatadogagent/assets/postgreserror.png) Take a look at [the documentation for the Postgres integration](https://docs.datadoghq.com/integrations/postgres/). The reason it's not working is that the **datadog** user in **Postgres** doesn't exist yet. Normally in a Kubernetes environment we would add this with a script on the initialization of the pod, but our database is already running so we need to go through some manual steps. So run `k get pods`{{execute}} again to get the name of our database pod. 
9.  Now run `k exec <dbpodname> -it -- bash` to run an interactive shell on the pod. If you describe the pod, you will see it has a service label set to db, so you can also run `k exec $(k get pod -l service=db -o name) -it -- bash `{{execute}}. 
10. Run `psql -h localhost -U user postgres`{{execute}}. Then copy and run the following in the psql environment: 
    <pre class="file" data-target="clipboard">create user datadog with password 'datadog';
    grant pg_monitor to datadog;
    grant SELECT ON pg_stat_database to datadog;
    </pre>
11. If the prompt in the terminal shows `postgres=#` then type **exit** and then press return to exit the psql environment. Then if the prompt shows `bash-5.1#` then type **exit** agaIn and press return. 
12. Now run the agent status command again to see if there is a different result. You should see that the postgres metrics are being collected. It can take a few seconds for the agent to see the changes, so if you see the same error try again.
    ![Postgres metrics in the Agent](configuredatadogagent/assets/postgresmetricsagent.png)
13. In the next few pages we are going to start using Datadog to monitor the application, So let's generate some traffic in our application. On the right side of the window above the terminal you will see a tab labeled **storedog**. Click it and you should see the app run in a new tab. If you see errors, wait a few more seconds and click the refresh icon at the top of the tab. Don't refresh your browser since that will require to run these steps again. It can take up to a minute or so for all the containers to sync with each other. After you see the application, take a look around at the app. Click on different links. Spend about a minute or two trying out different paths through the app.
