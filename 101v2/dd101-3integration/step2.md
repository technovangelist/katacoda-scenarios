Now we are going to do the same process but for the two services hosted in Docker.

Note: We have an agent running on the host and now another agent in a container. This is only done in the environment to compress the lab steps. Normally in a Docker environment you would only install the agent as a container. In production, the only difference doing it this way is getting charged for the extra host.

1. Change the current working directory to `/root/lab/docker` with the command `cd /root/lab/docker`{{execute}} and then start up docker-compose with this command: `docker-compose up`{{execute}}. This will run containers for Redis, Nginx and the Datadog agent.
2. In the second terminal, change to the `/root/lab/docker` directory and then run the Agent status command: `docker-compose exec datadog agent status`{{execute T2}} Scroll up to the Collector section and see what checks are running.
3. Is there anything surprising here? Nothing has been done to configure Redis to be monitored. But Redis is a service that benefits right away from auto discovery. Notice that Nginx is not being monitored. We need to add a configuration to start monitoring that. 
4. Open the `docker/docker-compose.yaml`{{open}} file in the editor. 
5. We could mount a volume for the Nginx integration yaml file, but there is a better way: Docker object labels. The Datadog agent will read each container's labels to determine how to observe it. In the nginx service, add the following at the same indent level as `image:`:
    <pre class="file" data-filename="docker/docker-compose.yaml" data-target="insert" data-marker="# insert labels here">
   labels:
         com.datadoghq.ad.check_names: '["nginx"]'
         com.datadoghq.ad.init_configs: '[{}]'
         com.datadoghq.ad.instances: '[{"nginx_status_url": "http://%%host%%:%%port%%/nginx_status"}]'</pre>
6. You may be thinking those labels are a bit strange, but you can see where they come from when you look at <a href="https://github.com/DataDog/integrations-core/blob/master/nginx/datadog_checks/nginx/data/conf.yaml.example" target="_datadog">the example yaml file for nginx</a>.
7. To learn more about the formatting for these labels, see <a href="https://docs.datadoghq.com/agent/docker/integrations/?tab=docker" target="_datadog">the Auto Discovery documentation</a>.
8. In the first terminal, type CTRL-C to stop docker-compose. Then restart all the containers with the command `docker-compose down && docker-compose up`{{execute T1}}. In the second terminal, run the Agent status command: `docker-compose exec datadog agent status`{{execute T2}}, and look for the nginx entry in the Collector section.
9. Notice that with both Redis and Nginx, we aren't collecting logs. But that's easy to do by adding another label to each service. Take a look at the <a href="https://docs.datadoghq.com/agent/docker/log/?tab=dockercompose" target="_datadog">Docker Log collection documentation</a> and see if you can figure out what to add to get logs enabled in both integrations.

 To confirm that logging is enabled for Redis and Nginx, restart docker-compose as you did in the previous step, and look at the Logs Agent section of Agent status output. You should see an entry for `docker`, listing two Inputs. These Inputs are the ids of the containers running Redis and Nginx. You can confirm this by comparing the Input values to the container ids displayed by `docker ps`.