1. Open the file `docker-compose.yml`{{open}} in the editor to the right. 
1. Notice that only a single Redis image is in the file, but we want to add the Datadog agent. Datadog will run as a sidecar container on our host. 
1. Copy the following text, then paste it into the file below the `redis` entry at the same indentation level.
   <pre class="file" data-target="clipboard">
   datadog:
       links:
       - redis # Ensures datadog container can connect to redis container
       image: datadog/agent:latest
       environment:
       - DD_API_KEY
       - DD_HOSTNAME=dockerhost
       volumes:
       - /var/run/docker.sock:/var/run/docker.sock:ro
       - /proc/:/host/proc/:ro
       - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
   </pre>
1. Ensure you are in the `/root/lab` directory. If not, run `cd /root/lab`{{execute}} in the terminal.
1. Run `docker-compose up`{{execute}} in the terminal to start.
1. Switch over to the Terminal 2, ensure you are in the `/root/lab` directory, and run the Datadog status command: `docker-compose exec datadog agent status`{{execute T2}}. This command is telling `docker-compose` to execute the command `agent status` inside the `datadog` container.
1. As you can see, the Datadog agent is running but we have the same issue we saw in the previous step with Logs not enabled. Instead of using a YAML file to configure the Datadog Agent container, we use environment variables.
1. In the editor, add the following environment variable to the Datadog service:
    `DD_LOGS_ENABLED=true`
    
    The resulting environment section should look like:

        environment:
        - DD_API_KEY
        - DD_HOSTNAME=dockerhost
        - DD_LOGS_ENABLED=true

1. In the first terminal tab, press CTRL-C to stop docker-compose and then run `docker-compose up` again to restart it.
1. In the second terminal, run the status command and see if you have successfully enabled logs. You should see that the Logs Agent section reports that it is sending compressed logs.

    You can see if APM is enabled by running `docker-compose exec datadog agent config`{{exec}}. In the `apm_config` section, you should see `enabled: true`. As with the host-installed Datadog agent, APM is enabled by default on the Docker agent, too.
1. Review the available environment variables in <a href="https://docs.datadoghq.com/agent/docker/?tab=standard#overview" target="_datadog">the documentation</a>
1. When you are done with this section, run `grademe`{{execute T2}} in the second terminal to indicate that you are done and to grade your progress. You will not receive any credit until you run **grademe**. Then click the **Continue** button.

It's important to note that when working with containers, you only install the agent within the container environment. You don't need to install it on the host as well.
