Now we are going to do the same process but for the two services hosted in Docker. 

1. Start up docker-compose with this command: `docker-compose up`{{execute}}.
2. In the second terminal, run the agent status command: `docker-compose exec datadog agent status`{{execute T2}}. Scroll up to the Collector section and see what checks are running.
3. Is there anything surprising here? Nothing has been done to configure Redis to be monitored. But Redis is a service that benefits right away from auto discovery. Notice that Nginx is not being monitored. We need to add a configuration to start monitoring that. 
4. Open the `docker/docker-compose.yaml`{{open}} file in the editor. 
5. add the labels

explain labels, point to docs for labels, point to original file for nginx yaml.
