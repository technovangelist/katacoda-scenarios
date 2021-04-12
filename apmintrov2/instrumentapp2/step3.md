The `store-frontend` service has a Rails framework. The first step for instrumentation is to install the required Ruby tracing and log libraries. Next, an initializer file is added to enable Rails instrumentation, followed by a configuration file to ship logs to Datadog in JSON format so that Datadog can filter the logs based on special parameters. Finally, the docker-compose file is updated for trace and log collection and App Analytics for the frontend service. 

The store-frontend service has been instrumented for you, but you will update the docker-compose.yml. Let's first go through the instrumentation.

1. Click `store-frontend-broken-instrumented/store-frontend/Gemfile`{{open}} to view the Gemfile for the store-frontend. The Gemfile installs the required tracing and log collection libraries.<p> **Line 46** installs the `ddtrace` Gem, which is <a href="https://docs.datadoghq.com/tracing/setup/ruby/" target="_blank">Datadog’s tracing client for Ruby</a>. The `ddtrace` library traces requests as they flow across web servers, databases, and microservices so that developers have high visibility into bottlenecks and troublesome requests. <p>**Line 48** installs the `logging-rails` Gem, which is a railtie for integrating the Ruby logging framework into the Rails application. To learn more, view the <a href="https://github.com/TwP/logging-rails" target="_blank">logging-rails</a> documentation. <p>**Line 49** installs the `lograge` Gem to send logs to Datadog. To learn more, view the <a href="https://docs.datadoghq.com/logs/log_collection/ruby/#setup" target="_blank"> Rails log collection</a> documentation.

2. Click `store-frontend-broken-instrumented/store-frontend/config/initializers/datadog.rb`{{open}} to view the initializer file that enables Rails instrumentation. <p>**Line 3** activates autoinstrumentation for Rails and enables automatic trace collection for the `store-frontend`,  `store-frontend-cache`, and `store-frontend-sqlite` services. You can view the definitions of each option in the <a href="https://docs.datadoghq.com/tracing/setup/ruby/#rails" target="_blank">Tracing Ruby Applications - Integration Instrumentation - Rails</a> documentation. <p>**Line 5** makes sure requests are also instrumented. You can view the definitions of each option in the <a href="https://docs.datadoghq.com/tracing/setup/ruby/#net-http" target="_blank">Tracing Ruby Applications - Integration Instrumentation - Net/HTTP</a> documentation.

3. Click `store-frontend-broken-instrumented/store-frontend/config/environments/development.rb`{{open}} to view the configuration file that converts the logs to the JSON format using **Lines 11-28**. To learn more, view the <a href="https://docs.datadoghq.com/tracing/connect_logs_and_traces/ruby/?tab=lograge#automatic-trace-id-injection" target="_blank">Connecting Ruby Logs and Traces</a> documentation. <p> With the service instrumented and trace collection automatically enabled via the `datadog.rb` initializer file, you can finish enabling trace  and log collection and App Analytics for the service.

4. Click `store-frontend-broken-instrumented/store-frontend/config/application.rb`{{open}}. **Line 7** installs and automatically instruments the `active-record` service to support Rails `store-frontend` service. You can view the <a href="https://docs.datadoghq.com/tracing/setup/ruby/#active-record" target="_blank"> Tracing Ruby Application</a> documentation for more details.

5. Click `docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml`{{open}}.

6. Under **services**, view the details for **frontend**. <p> Let's add the code for enabling trace and log collection.

7. Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service. These environment variables are required for each service in the app that will be monitored. 

    <pre class="file" data-filename="docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add frontend env variables">
         - DD_AGENT_HOST=agent
         - DD_LOGS_INJECTION=true
         - DD_ANALYTICS_ENABLED=true</pre> 

    `DD_AGENT_HOST=agent` defines the address of the Agent that the tracer submits traces to. 
    
    `DD_LOGS_INJECTION=true` enables automatic injection of trace IDs into the logs from the supported logging libraries to correlate traces and logs. 
    
    `DD_ANALYTICS_ENABLED=true` enables App Analytics for the traces.

8. Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to enable logs.

    <pre class="file" data-filename="docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add frontend log labels">
       labels:
         com.datadoghq.ad.logs: '[{"source": "ruby", "service": "store-frontend"}]'</pre> 

With these steps, the Rails `store-frontend` service is instrumented for APM and Log management with Datadog. The **frontend** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-frontend](instrumentapp2/assets/instrumented-frontend.png) 

Before instrumenting the discounts and advertisements services, let's log in to Datadog to view the traces and logs being collected for the store-frontend service. 