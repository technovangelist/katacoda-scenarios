1. Open the **postgres-deploy.yaml** file in the editor on the right. Scroll down to the commented annotation lines and uncomment them. 
2. Apply the updated yaml:
   `kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}
3. Navigate to the <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards List</a> and click on **Postgres - Overview**. 
   *Within a few minutes you should see Postgres metrics start to show up.*
4. Review the annotations that you uncommented. Compare them to the <a href="https://github.com/DataDog/integrations-core/blob/master/postgres/datadog_checks/postgres/data/conf.yaml.example" target="_datadog">postgres integration example configuration file</a>.
   
   *Notice that there is also a %%port%%. You can find all the supported template variables in <a href="https://docs.datadoghq.com/agent/autodiscovery/?tab=docker#supported-template-variables" target="_datadog">the documentation</a>*
    
    **Annotations for Postgres**
    <pre><code>annotations:
      ad.datadoghq.com/postgres.check_names: '["postgres"]'
      ad.datadoghq.com/postgres.init_configs: '[{}]'
      ad.datadoghq.com/postgres.instances: '[{"host": "%%host%%", "port": "%%port%%","username": "datadog","password": "datadog" }]'</code></pre>

    **Corresponding lines in Postgres Example Yaml**
    
    <pre><code>init_config:
  instances:
     - host: localhost
       port: 5432
       username: datadog
       password: <UNIQUEPASSWORD></code></pre>

   *Do you see how the information from the example yaml is encoded in the annotations?*

1. Try adding **nginx** to this cluster and use annotations to start monitoring the server. You can find a deployment yaml for **nginx** in the editor above. The **nginx** integration configuration file can be found <a href="https://github.com/DataDog/integrations-core/tree/master/nginx/datadog_checks/nginx/data" target="_datadog">here in our Github repo</a>. 
