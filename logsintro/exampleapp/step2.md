# Gathering logs
Log in to your account on Datadog and navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">Logs Explorer</a>. If you haven't enabled logging in a previous course, you will see an introduction screen. To enable the Log Management feature, click the **Get Started** button and then click the next **Get Started** button in the confirmation dialog.  If you don't see a Start Trial dialog, just move on to the next step.

You should see instructions on getting started with logs. Try refreshing the screen. 

Notice that the logs aren't showing up in the application. This is because the agent is not configured to ship logs to Datadog. 

Since we are working in a containerized environment, the Datadog Agent should run as a container alongside the other containers. All configuration should then happen only through environment variables, volumes, and Docker labels. Learn more about setting up the Datadog Docker Agent in the <a href="https://docs.datadoghq.com/agent/docker" target="_datadog">documentation</a>.

To start gathering the application logs, we need to add a couple environment variables and a new volume to the `datadog` container. Open `docker-compose.yml`{{open}} in the editor on the right. Add these two environment variables to the `environment` list in the `datadog` section:
  
<pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# insert environment variables here">
      - DD_LOGS_ENABLED=true
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true</pre>

  _Make sure these environmment variables are indented at the same level as the others in the `environment` list._

And then add this line to the `volumes` list in the `datadog` section:

<pre class="file" data-filename="docker-compose.yml" data-target="insert" data-marker="# insert volume here">
      - /opt/datadog-agent/run:/opt/datadog-agent/run:rw</pre>

<table>
<tr><td>
`DD_LOGS_ENABLED=true` enables log collection. 
</td></tr>
<tr><td>
`DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true` enables log collection for all containers.
</td></tr>
<tr><td>
`/opt/datadog-agent/run:/opt/datadog-agent/run:rw` mounts a persistent host volume to store the Agent's logging registry. The registry stores a reference to the last log line collected for each container.  Persisting the registry on the host prevents loss of container logs during restarts or network issues.
</td></tr>
</table>

Restart your docker-compose environment by pressing **CTRL-C** in the first terminal then enter the following commands:

`docker-compose stop && docker-compose rm -f && docker-compose up --build`{{execute}}

Navigate to Logs Explorer in Datadog and wait for the logs to start showing up. It can take a few minutes for the first logs to appear, but then they should update faster. Try running some of the curl commands from the previous page as well.

![Log flow](exampleapp/assets/log_flow.png)