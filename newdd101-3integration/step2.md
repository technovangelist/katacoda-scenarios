Now we are going to do the same process but for the two services hosted in Docker. 

1. Start up docker-compose with this command: `docker-compose up`{{execute}}.
2. In the second terminal, change to the `/root/lab/docker` directory and then run the agent status command: `docker-compose exec datadog agent status`{{execute T2}}. Scroll up to the Collector section and see what checks are running.
3. Is there anything surprising here? Nothing has been done to configure Redis to be monitored. But Redis is a service that benefits right away from auto discovery. Notice that Nginx is not being monitored. We need to add a configuration to start monitoring that. 
4. Open the `docker/docker-compose.yaml`{{open}} file in the editor. 
5. We could mount a volume for the Nginx integration yaml file, but there is a better way: labels. In the nginx service, add the following at the same indent level as `image:`:
   <pre class="file" data-target="clipboard">
    labels:
      com.datadoghq.ad.check_names: '["nginx"]'
      com.datadoghq.ad.init_configs: '[{}]'
      com.datadoghq.ad.instances: '[{"nginx_status_url": "http://%%host%%:%%port%%/nginx_status"}]'
   </pre>

explain labels, point to docs for labels, point to original file for nginx yaml.