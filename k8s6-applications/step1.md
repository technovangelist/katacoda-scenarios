In this hands-on section, we are going to take a closer look at autodiscovery and annotations.

1. First, let's make sure our pods are all up and running:
   `kubectl get pods`{{execute}}

2. Look through the list of pods. You can see there are a few services that we have been working with already. There is also a Postgres server as well as a Redis service. 
3. Open a web browser to the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>
4. Navigate to the <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards List</a> and click on **Redis - Overview**. Within a couple minutes you should see metrics appearing in this dashboard from your environment. 
5. Now go back to the Dashboards List and click on **Postgres - Overview**. There are no metrics. 
  *Why is this? It all comes down to Autodiscovery.*
6. Navigate to <a href="https://github.com/DataDog/integrations-core/tree/master/postgres/datadog_checks/postgres/data" target="_datadog">https://github.com/DataDog/integrations-core/tree/master/postgres/datadog_checks/postgres/data</a>. In a separate tab, go to <a href="https://github.com/DataDog/integrations-core/tree/master/redisdb/datadog_checks/redisdb/data" target="_datadog2">https://github.com/DataDog/integrations-core/tree/master/redisdb/datadog_checks/redisdb/data</a>.
  *Both of these pages are folders in our **integrations-core** repository on Github. This is where you can find all of the integrations that we wrote and that we support. Notice that the redis folder includes and **auto_conf.yaml** file and the postgres folder does not. Any integration that includes an **auto_conf.yaml** file is one that we will attempt to integrate with automatically.*
7. In the **redis** folder, click on the **auto_conf.yaml** file.
   *This is the configuration for the redis integration. The first line says that we will look for any container named **redis** and apply the settings below. Redis is usually setup to use port 6379 but the host name is unknown until runtime. **%%host%%** will be replaced at runtime with the correct value.* 
8. Go back to the **redis** folder and click on **conf.yaml.example**. 
   *This is the complete yaml that you could use in your configuration. If some of the other options are important for you, you can override them using annotations. But rather than override redis, we will just setup postgres.*
