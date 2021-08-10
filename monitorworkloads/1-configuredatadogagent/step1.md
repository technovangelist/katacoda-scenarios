When you are working with virtual machines and cloud instances, you typically configure the Datadog Agent to process an application's metrics in the YAML file for the agent. But with Kubernetes you perform that configuration in the manifest for the application. In this lab, we have an application that is running as well as a Datadog Agent that is submitting metrics, logs, and more to Datadog. But it doesn't know anything about our database, and its not submitting any metrics from our frontend application yet. In this lab we will configure those to submit data. 

1.  In the IDE, open the file called `db.yaml` located under `deploy/generic-k8s/ecommerce-app`. You can see that this manifest defines a deployment, a service account and secret, a volume, and a service. 
2.  What we don't have here is any way to collect Postgres metrics with the Datadog Agent. To do that we need to add annotations. You can learn more about Auto Discovery Annotations at https://docs.datadoghq.com/agent/kubernetes/integrations/?tab=kubernetes
3.  The documentation says "If you define pods indirectly with replication controllers, replica sets, or deployments, add pod annotations under `.spec.template.metadata.`", so add the following to that section:
        annotations:
        ad.datadoghq.com/postgres.check_names: '["postgres"]'
        ad.datadoghq.com/postgres.init_configs: '[{}]'
        ad.datadoghq.com/postgres.instances: '[{"host": "%%host%%", "port": "%%port%%","username": "user","password": "password" }]'
4.  Now apply the manifest by running `k apply -f deploy/generic-k8s/ecommerce-app/db.yaml`{{execute}}.
5.  Open <a href="https://app.datadoghq.com" target="_datadog">app.datadoghq.com</a> and navigate to Integrations. Enable the Postgres integration, if it isn't already enabled. 
6.  Now you should be able to visit Dashboards and open either of the Postgres dashboards and see their metrics show up.

On the next page we will configure the frontend to submit APM traces to Datadog. 
