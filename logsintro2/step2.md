# Gathering logs
Log in to your account on Datadog and enable the Log-management feature by clicking on Logs on the menu bar. There will be a **Get Started** button at the top right to enable it. Then click **Start Trial**. If you don't see a Start Trial dialog, just move on to the next step.

You should see instructions on getting started with logs. Try refreshing the screen. 

Notice that the logs aren't showing up in the application. This is because the agent is not configured to ship logs to Datadog. 

Since we are working in a containerized environment, the Datadog Agent should run as a container alongside the other containers. All configuration should then happen only through environment variables, volumes, and docker labels. Learn more about docker Datadog Agent setup in the documentation.

To start gathering the application logs, add the following lines to the **docker-compose.yaml** file in the editor on the right. These options will enable the Agent to start gathering some logs:
  
  <pre><code>datadog:
    environment:
      - DD_LOGS_ENABLED=true
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true
    volumes:
      - /opt/datadog-agent/run:/opt/datadog-agent/run:rw
  </code></pre>

<table><tr><th>Configuration</th><th>Explanations</th></tr>
<tr><td>DD_LOGS_ENABLED=true</td><td>Enable log collection</td></tr>
<tr><td>DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true</td><td>Enable log collection for all containers</td></tr>
<tr><td>/opt/datadog-agent/run:/opt/datadog-agent/run:rw</td><td>Used to store pointers on container current log</td></tr>
</table>

Restart your docker-compose environment by pressing **CTRL-C** in the first terminal then enter the following commands:

`docker-compose stop && docker-compose rm -f && docker-compose up --build -d`{{execute}}

Navigate to Logs in Datadog and wait for the logs to start showing up. It can take a few minutes for the first logs to appear, but then they should update faster.
