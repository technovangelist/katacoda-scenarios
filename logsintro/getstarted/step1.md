1. In the Terminal 2 tab, run `creds`{{execute T2}}
1. Navigate to the <a href="https://app.datadoghq.com/account/settings" target="_datadog">Datadog integration</a> page. Search for **Redis** and click its **Install** button. At the bottom of the **Configuration** tab, click the **Install Integration** button. Don't worry about completing the steps in the Configuration tab yet.

    _If you have completed other labs, some of these integrations may already be installed._

2. Repeat the previous step for **Docker** and **NGINX**.

# Metrics

Thanks to the Datadog Autodiscovery feature, metrics are collected automatically from the Redis and NGINX containers. Out-of-the-box integrations dashboards have been created in your Datadog application.

1. Navigate to <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards</a> on the menu bar. 
   
   *Notice that we have some basic System dashboards, but there are also two NGINX dashboards (NGINX- overview and NGINX- metric), a Redis dashboard (Redis - Overview), and a Docker dashboard (Docker - Overview).*

2. Click each of the dashboards to see the information displayed.
  
  *You may have noticed that you didn't configure anything with these applications but they are populated with data. This is due to the auto discovery features of Datadog. Dashboards give you a clear state of the running system but don't show everything you need to know or why the system is behaving this way.*

# Traces

1. Select the **Terminal 2** tab to the right. Click the curl commands below to generate some requests to the application:

    `curl -X GET 'http://localhost:8080/think/?subject=technology'`{{execute T2}}
    `curl -X GET 'http://localhost:8080/think/?subject=religion'`{{execute T2}}
    `curl -X GET 'http://localhost:8080/think/?subject=war'`{{execute T2}}
    `curl -X GET 'http://localhost:8080/think/?subject=work'`{{execute T2}}
    `curl -X GET 'http://localhost:8080/think/?subject=music'`{{execute T2}}

2. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">APM</a> on the menu bar. In the **Traces** view, update the time range to `Past 30 minutes`. You will see traces from three services: thinker-api, thinker-microservice, and redis. 

  *The application was already instrumented to emit those traces. Refer to the Datadog documentation if you want to learn more on APM instrumentation. To learn more about APM, take the Introduction to Introduction to Application Performance Monitoring course in the Learning Center. Traces describe your system behavior but don't show its overall state or the reasons for its behavior.*

# Logs

1. Navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">Logs</a> on the menu bar.

2. Observe that there are no logs displayed for the running containers.

   *Logs are being collected from all your containers, but are not displayed because they are not parsed. The logs are also not bound to the other data types (metrics and traces) being collected from the containers.*
