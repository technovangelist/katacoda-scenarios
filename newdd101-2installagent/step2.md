1. Open the file `docker-compose.yml`{{open}} in the editor to the right. 
2. Notice that only a single Redis image is in the file, but we want to add the Datadog agent. Datadog will run as a sidecar container on our host. 
3. Copy the following text, then paste it into the file.
   <pre class="file" data-target="clipboard">
   datadog:
       links:
       - redis # Ensures datadog container can connect to redis container
       image: datadog/agent:latest
       environment:
       - DD_API_KEY
       volumes:
       - /var/run/docker.sock:/var/run/docker.sock
       - /proc/mounts:/host/proc/mounts:ro
       - /sys/fs/cgroup:/host/sys/fs/cgroup:ro
   </pre>
4. Run `docker-compose up`{{execute}} in the terminal to start.
5. Switch over to the Terminal 2 and run the Datadog status command: `docker-compose exec datadog agent status`{{execute T2}}
6. As you can see, the Datadog agent is running but we have the same issues we saw in the previous step with APM and Logs not enabled. But instead of using a configuration file, we use environment variables to do this.
7. In the editor, add the following environment variables to the Datadog service:
        DD_APM_ENABLED
        DD_LOGS_ENABLED

   The resulting environment section should look like:
        environment:
        - DD_API_KEY
        - DD_APM_ENABLED
        - DD_LOGS_ENABLED

8. In the first terminal tab, press CTRL-C to stop docker-compose and then run docker-compose up again to restart it.
9. In the second terminal, run the status command and see if you have successfully enabled them.
10. Review the available environment variables in <a href="https://docs.datadoghq.com/agent/docker/?tab=standard#overview" target="_datadog">the documentation</a>