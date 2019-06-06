1. Navigate to the <a href="htthttps://app.datadoghq.com/account/settings" target="_datadog">Datadog integration</a> page. Search for **Redis** and click its **Install** button. At the bottom of the **Configuration** tab, click the **Install Integration** button. Don't worry about completing the steps in the Configuration tab yet.
2. Repeat the previous step for **Docker** and **NGINX**.

# Metrics

Thanks to the Datadog auto-discovery feature, metrics are collected automatically from the Redis and NGINX containers. Out of the box integrations dashboards have been created in your Datadog application.

3. Navigate to Dashboards on the menu bar. 
   
   *Notice that we have some basic System dashboards, but there are also two NGINX dashboards (NGINX- overview and NGINX- metric), a Redis dashboard (Redis - Overview), and a Docker dashboard (Docker - Overview).*

4. Click on each of the dashboards to see the information displayed.
  
  *You may have noticed that you didn't configure anything with these applications but they are populated with data. This is due to the auto discovery features of Datadog. Dashboards give you a clear state of the running system but don't show everything you need to know or why the system is behaving this way.*

# Traces

5. Navigate to APM on the menu bar. In the Services view, you will see at least three services: Redis, thinker-api, and thinker-microservice

  *The application was already instrumented to emit those traces. Refer to the Datadog documentation if you want to learn more on APM instrumentation and to learn more about APM, take the Introduction to APM course on the Learning Platform. Traces describe your system behavior but don't show its overall state or why it's behaving this way.*

# Logs

1. Navigate to Logs on the menu bar.

   *Logs are being collected from all your containers but there are some issues:*
    * Logs are not parsed.
    * Logs are not bound to the other data types that are metrics and traces.



