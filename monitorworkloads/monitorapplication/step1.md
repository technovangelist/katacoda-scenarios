We have updated the configuration of all the components of our app to be in line with what we did in the previous lab. So let's just do a quick review of that. And then we will update the Real User Monitoring ID's to ensure that data is showing up in our account correctly. 

1.  Now lets take a look at what is in the config files. In the IDE tab, navigate to **deploy/generic-k8s/ecommerce-app**. You should see 4 YAML files there for advertisements, db, discounts, and frontend.
1.  Open the **advertisements.yaml** file in the editor.
2.  First notice that we have labels set at **metadata** and **spec.template.metadata**. Scroll down to **spec.template.spec.containers.env**. You can see a number of environment variables here, including: `DATADOG_SERVICE_NAME`, `DD_ENV`, `DD_AGENT_HOST`, `DD_LOGS_INJECTION`, `DD_ANALYTICS_ENABLED`, and `DD_PROFILING_ENABLED` . These environment variables are all that is needed to enable different features like profiling, and more. 
3.  You should see similar values set in **discounts.yaml**
4.  **db.yaml** has a few changes. First notice the two configmaps. These are setting the datadog user in postgres, as well as giving access to the database monitoring features. Further down you will see the labels and annotations set. 
5.  In **frontend.yaml** you will need to update the settings for RUM. In Datadog, navigate to **UX Monitoring | RUM Applications** and click on the application you configured in the previous lab. Take note of the **ApplicationID** and the **ClientToken** and update the yaml file accordingly. 
6.  Now run `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}} to restart the Frontend. 
7.  Open the StoreDog app and start looking around the app so that we have some data in Datadog.