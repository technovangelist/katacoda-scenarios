1.  To the right you see a terminal window. We have already used that in a few labs. On the tab bar above the terminal, you see that we are currently looking at the **Terminal**. To the right of that is a tab for **IDE**. Notice that you can tear the **IDE** off to a new window if you like. Next to that tab is one for **Storedog**. This is the application. Click this tab to open the app in a new window. It may take a few seconds for it to fully launch.
2.  Click around the app to see what is here. Try clicking on some items in the store. Do some searches (Bags and Totes are some things in the store so you can search for them). Try logging in then create an account.
3.  Let's take a look at how this application was started. Everything is in a single `docker-compose.yaml` file. When you open the IDE tab, you will see a folder for the app and the docker-compose yaml file. Click on the file to open it in the editor.
4.  Scan through the file. You can see there are 5 services: agent, discounts, frontend, advertisements, and db. We saw much of the agent configuration in the previous section but notice a few more environment variables are set. Notice we are also collecting the agent's logs. 
5.  The next service is **discounts**. The command that started the application was `POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /root/lab/ecommerceapp/docker-compose.yaml up -d` and you can see this service and many of the others are using those environment variables. We are collecting these logs too. 
6.  Scroll down to the end to see  the **db** service. This is a **postgresql** database. We have an integration with Postgres though it isn't an application that we autodiscover. Adding the integration is easy enough. Open <a href="https://docs.datadoghq.com/integrations/postgres" target="_blank">the Postgres documentation</a> in a new window. 
7.  Notice there are a few commands you need to run to get access to Postgres metrics. In the startup process for this lab, the following command was run to enable this: 
    ```
    docker-compose -f ./docker-compose.yaml exec -T -d db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;grant SELECT ON pg_stat_database to datadog;"
    ```
8.  The documentation then shows the command to verify you have access. 
9.  Later in the docs is a section about configuring the yaml configuration file. In Docker we do this with autodiscovery labels. Open the <a href="https://docs.datadoghq.com/agent/docker/integrations/?tab=docker" target="_blank">Docker Integrations Autodiscovery</a> page in the documentation. This page shows the format of labels to use for a **Dockerfile**, a **docker-compose.yaml** file, the **docker run command**, and for **Docker Swarm**.
10. Compare the two documentation articles with the configuration of our db service:
    ```
    com.datadoghq.ad.check_names: '["postgres"]'
    com.datadoghq.ad.init_configs: "[{}]"
    com.datadoghq.ad.instances: '[{"host": "%%host%%", "port": "5432",  "password":"password", "username": "datadog", "collect_activity_metrics": true, "collect_default_database":true, "collect_function_metrics": true}]'
    com.datadoghq.ad.logs: '[{"source": "postgresql", "service": "postgres"}]'
    ```
11. First we state the name of the integration in **check_names**. For this integration, nothing goes into **init_configs**. But then **instances** has quite a bit. But not everything is in the documentation. For the full list of options its always best to navigate to the <a href="https://github.com/DataDog/integrations-core/blob/master/postgres/datadog_checks/postgres/data/conf.yaml.example" target="_blank">corresponding file in the integrations core repo on Github</a>. Take special notice of the `%%host%%`. This is autodiscovered at runtime. 
12. Run the agent status command to see what checks are being run: `docker-compose exec agent agent status`{{execute}}. You can see there are a few dozen metrics collected for Postgres.
13. Configcheck is another useful command to run to see how the agent is configured: `docker-compose exec agent agent configcheck`{{execute}}.

On the next page we will move on to using the Datadog app. 