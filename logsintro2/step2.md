Logs are flowing in your Datadog application but they are not parsed, nor are they linked to the other data types.

In order to solve this issue, we are going to use two reserved attributes:

* source
* service

## Integration pipelines

**The `source` attribute is key to enable the integration pipeline**

Datadog has a range of <a href="https://docs.datadoghq.com/integrations/#cat-log-collection" target="_datadog">Log supported integrations</a>. In order to enable the Log integrations pipeline in Datadog, pass the source name as a value for the source attribute with a docker label.

1. Press CTRL-C in the terminal to stop docker-compose. Then add the following label to the redis block in your docker-compose.yml file:

  <pre><code>redis:
    (...)
    labels:
      com.datadoghq.ad.logs: '[{"source": "redis", "service": "redis"}]'
   </code></pre>

1. Add the following label to the nginx block in the same file:

  <pre><code>nginx:
    (...)
    labels:
      com.datadoghq.ad.logs: '[{"source": "nginx", "service": "nginx"}]'
   </code></pre>

2. Restart your Docker containers using the following commands:
   `docker-compose stop && docker-compose rm -f && docker-compose up --build -d`{{execute}}

3. Send the curl commands you used before to the application. Now open the Logs view in Datadog. You should see Redis and NGINX logs. You might need to wait a few seconds before they register in the system.
   
   `curl -X GET 'http://localhost:8080/think/?subject=technology'`{{execute}}
   `curl -X GET 'http://localhost:8080/think/?subject=religion'`{{execute}}
   `curl -X GET 'http://localhost:8080/think/?subject=war'`{{execute}}
   `curl -X GET 'http://localhost:8080/think/?subject=work'`{{execute}}
   `curl -X GET 'http://localhost:8080/think/?subject=music'`{{execute}}

4. Click on one of the NGINX log lines. Notice the line is shown as-is near the top, but then parsed into attributes below. We will learn how to do that later in the course.


## Binding Application logs to the corresponding metrics and traces

**The service attribute is key for binding metrics traces and logs.**

Our application is already instrumented for APM. Let's add log tags to the containers thinker-api and thinker-microservice in order to be able to bind the traces and the log together.

1. Add the following labels to the docker-compose.yml file:

  <pre><code>api:
    (...)
    labels:
      com.datadoghq.ad.logs: '[{"source": "webapp", "service": "thinker-api"}]'
  thinker:
    (...)
    labels:
      com.datadoghq.ad.logs: '[{"source": "webapp", "service": "thinker-microservice"}]'
  </code></pre>

1. Restart the Docker containers as you did before. Then send a few more of the curl commands and look at the new logs showing up in the Logs view.

The service attribute values are based on what has been set up in our application's code:

For the API service:
 
<pre><code>traced_app = TraceMiddleware(app, tracer, service='thinker-api')</code></pre>

And for the Thinker service:

<pre><code>trace_app(app, tracer, service='thinker-microservice')</code></pre>

Thanks to the `source` attribute, Integration pipelines have been created within your Datadog application and are parsing your application logs from Redis and NGINX. To learn more about log parsing and pipelines, continue to the next exercise.

![Integration pipelines](/technovangelist/scenarios/logsintro2/assets/integration_pipelines.png)

Thanks to the **service** attribute we are now able to switch from metrics to traces to logs.

1. Return to Dashboards. Select the **NGINX - Metrics** dashboard.
1. Click on the graph for **Requests per second**. Look at the context menu that popped up.
1. Choose **View related logs**.
1. In the Search box at the top, remove **Source: nginx**.
1. Change the time span at the top right to **The Past 4 Hours**. If it's been some time since you used this, expand the time window to something more appropriate.
1. Expand the **Service** facet on the left and click on **thinker-api**.
1. Click on any of the log lines to expand the detail view.
1. Click on **thinker-api** under **Service** at the top of the detail view.
1. Choose **See in APM**.
