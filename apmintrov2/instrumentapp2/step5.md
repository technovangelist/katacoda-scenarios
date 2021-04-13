The `discounts` and `advertisements` services have a Python Flask framework, so the services are instrumented using the Python tracing library `ddtrace`. First, the `ddtrace` library is added to the list of required libraries, and then, the docker-compose.yml is updated for trace injection, log injection, and App Analytics.

#### Discounts Service

1.  Click `discounts-service/requirements.txt`{{open}} to view the list of required libraries that are installed for the service. The `ddtrace` library (**Line 4**) has already been included.

2.  Click `docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml`{{open}}.

3.  Under **services**, view the details for **discounts**. <p> Let's add the code for enabling trace and log collection.

4.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add discounts env variables">
      - DD_AGENT_HOST=agent
      - DD_LOGS_INJECTION=true
      - DD_ANALYTICS_ENABLED=true</pre>

5.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add the `ddtrace-run` wrapper to the command that brings up the Flask server.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="command: flask run --port=5001 --host=0.0.0.0">

    command: ddtrace-run flask run --port=5001 --host=0.0.0.0</pre>

        `ddtrace-run` automates instrumentation of the service for Datadog APM. You can view more details for automatic and manual instrumentation using `ddtrace` in the <a href="http://pypi.datadoghq.com/trace/docs/web_integrations.html#flask" target="_blank">Datadog Python Trace and Profile Client</a> documentation.

6.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to enable logs.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add discounts log labels">
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "discounts-service"}]'</pre>

7.  Click `rm /ecommworkshop/store-frontend-broken-instrumented/store-frontend/tmp/pids/*; docker-compose -f docker-compose-broken-no-apm-instrumentation.yml up -d`{{execute}} to restart the docker deployment to apply these changes. <p> The **discounts** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-discounts](instrumentapp2/assets/instrumented-discounts.png)

8.  Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog to view the list of traces that are coming in. <p> You should now see traces for the `discounts` service in the list. This may take a couple of minutes.

9.  Click a trace for the `discounts` service to view the Flame Graph, Span List, Tags, related Hosts, and related Logs.

#### Advertisements Service

Because the advertisements service also has a Python-Flask framework, the advertisements service has the same instrumentation as the discounts service. The ddtrace library has already been installed for you for this service (**Line 4** in `ads-service/requirements.txt`{{open}}).

1.  Click `docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml`{{open}}.

2.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add the following to the list of environment variables for the service.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add ads env variables">
      - DD_AGENT_HOST=agent
      - DD_LOGS_INJECTION=true
      - DD_ANALYTICS_ENABLED=true</pre>

3.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add the `ddtrace-run` wrapper to the command that brings up the Flask server. Note that the port for this service is 5002.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="command: flask run --port=5002 --host=0.0.0.0">

    command: ddtrace-run flask run --port=5002 --host=0.0.0.0</pre>

4.  Click **Copy to Editor** below or manually copy and paste the text where indicated to add labels to enable logs.

<pre class="file" data-filename="docker-compose-files/docker-compose-broken-no-apm-instrumentation.yml" data-target="insert" data-marker="# add ads log labels">
    labels:
      com.datadoghq.ad.logs: '[{"source": "python", "service": "advertisements-service"}]'</pre>

5.  Click `rm /ecommworkshop/store-frontend-broken-instrumented/store-frontend/tmp/pids/*; docker-compose -f docker-compose-broken-no-apm-instrumentation.yml up -d`{{execute}} to restart the docker deployment to apply these changes. <p> The **advertisements** section of the docker-compose file should now look like the screenshot below. <p> ![instrumented-adverstisements](instrumentapp2/assets/instrumented-advertisements.png)

6.  Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog to view the list of traces that are coming in. <p> You should now see traces for the `advertisements` service in the list. This may take a couple of minutes.

7.  Click a trace for the `advertisements` service to view the Flame Graph, Span List, Tags, related Hosts, and related Logs.

With these steps, the Python-based services are also instrumented for APM with Datadog. The final list for **Service** under **Facets** is shown below.

![trace-services](instrumentapp2/assets/trace-allservices.png)

The `postgres` service appears in the list because it is installed and automatically instrumented to support the discounts and advertisements services using **Line 12** in `discounts-service/requirements.txt`{{open}} and `ads-service/requirements.txt`{{open}}, respectively. You can view <a href="http://pypi.datadoghq.com/trace/docs/db_integrations.html#module-ddtrace.contrib.psycopg" target="_blank"> Datadog's Python tracing client</a> for more details.

### Assessment

Click `grademe`{{execute}} to receive a grade for this activity.
